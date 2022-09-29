//
//  VTBPlayerItemTrack.swift
//  KSPlayer
//
//  Created by kintan on 2018/3/10.
//

import Libavformat
import VideoToolbox

class VideoHardwareDecode: DecodeProtocol {
    private weak var delegate: DecodeResultDelegate?
    private var session: DecompressionSession?
    private let codecpar: AVCodecParameters
    private let timebase: Timebase
    private let options: KSOptions
    private var startTime = Int64(0)
    private var lastPosition = Int64(0)
    private var error: NSError?
    required convenience init(assetTrack: AssetTrack, options: KSOptions, delegate: DecodeResultDelegate) {
        self.init(assetTrack: assetTrack, options: options, session: DecompressionSession(codecpar: assetTrack.stream.pointee.codecpar.pointee, options: options), delegate: delegate)
    }

    init(assetTrack: AssetTrack, options: KSOptions, session: DecompressionSession?, delegate: DecodeResultDelegate) {
        timebase = assetTrack.timebase
        codecpar = assetTrack.stream.pointee.codecpar.pointee
        self.options = options
        self.session = session
        self.delegate = delegate
    }

    func doDecode(packet: Packet) throws {
        let corePacket = packet.corePacket.pointee
        guard let data = corePacket.data, let session = session else {
            delegate?.decodeResult(frame: nil)
            return
        }
        let sampleBuffer = try session.formatDescription.getSampleBuffer(isConvertNALSize: session.isConvertNALSize, data: data, size: Int(corePacket.size))
        let flags: VTDecodeFrameFlags = [._EnableAsynchronousDecompression]
        var flagOut = VTDecodeInfoFlags.frameDropped
        let pts = corePacket.pts
        let packetFlags = corePacket.flags
        let duration = corePacket.duration
        let size = Int64(corePacket.size)
        let status = VTDecompressionSessionDecodeFrame(session.decompressionSession, sampleBuffer: sampleBuffer, flags: flags, infoFlagsOut: &flagOut) { [weak self] status, infoFlags, imageBuffer, _, _ in
            guard let self = self, !infoFlags.contains(.frameDropped) else {
                return
            }
            guard status == noErr else {
                if status == kVTInvalidSessionErr || status == kVTVideoDecoderMalfunctionErr || status == kVTVideoDecoderBadDataErr {
                    if corePacket.flags & AV_PKT_FLAG_KEY == 1 {
                        self.error = NSError(errorCode: .codecVideoReceiveFrame, ffmpegErrnum: status)
                    } else {
                        // 解决从后台切换到前台，解码失败的问题
                        self.doFlushCodec()
                    }
                }
                return
            }
            self.error = nil
            let frame = VideoVTBFrame()
            frame.corePixelBuffer = imageBuffer
            frame.timebase = self.timebase
            if packetFlags & AV_PKT_FLAG_KEY == 1, packetFlags & AV_PKT_FLAG_DISCARD != 0, self.lastPosition > 0 {
                self.startTime = self.lastPosition - pts
            }
            self.lastPosition = max(self.lastPosition, pts)
            frame.position = self.startTime + pts
            frame.duration = duration
            frame.size = size
            self.lastPosition += frame.duration
            self.delegate?.decodeResult(frame: frame)
        }
        if let error = error {
            throw error
        }
        if status == kVTInvalidSessionErr || status == kVTVideoDecoderMalfunctionErr || status == kVTVideoDecoderBadDataErr {
            if corePacket.flags & AV_PKT_FLAG_KEY == 1 {
                throw NSError(errorCode: .codecVideoReceiveFrame, ffmpegErrnum: status)
            } else {
                // 解决从后台切换到前台，解码失败的问题
                doFlushCodec()
            }
        }
    }

    func doFlushCodec() {
        session = DecompressionSession(codecpar: codecpar, options: options)
        lastPosition = 0
        startTime = 0
    }

    func shutdown() {
        session = nil
    }

    func decode() {
        lastPosition = 0
        startTime = 0
    }
}

class DecompressionSession {
    fileprivate let isConvertNALSize: Bool
    fileprivate let formatDescription: CMFormatDescription
    fileprivate let decompressionSession: VTDecompressionSession
    init?(codecpar: AVCodecParameters, options _: KSOptions) {
        let format = AVPixelFormat(codecpar.format)
        guard let pixelFormatType = format.osType(), let extradata = codecpar.extradata else {
            return nil
        }
        let extradataSize = codecpar.extradata_size
        if extradataSize >= 5, extradata[4] == 0xFE {
            extradata[4] = 0xFF
            isConvertNALSize = true
        } else {
            isConvertNALSize = false
        }
        let isFullRangeVideo = codecpar.color_range == AVCOL_RANGE_JPEG
        let videoCodecType = codecpar.codec_id.mediaSubType.rawValue
        let dic: NSMutableDictionary = [
            kCVImageBufferChromaLocationBottomFieldKey: kCVImageBufferChromaLocation_Left,
            kCVImageBufferChromaLocationTopFieldKey: kCVImageBufferChromaLocation_Left,
            kCMFormatDescriptionExtension_FullRangeVideo: isFullRangeVideo,
            videoCodecType == kCMVideoCodecType_HEVC ? "EnableHardwareAcceleratedVideoDecoder" : "RequireHardwareAcceleratedVideoDecoder": true,
            kCMFormatDescriptionExtension_SampleDescriptionExtensionAtoms: [
                videoCodecType.avc: NSData(bytes: extradata, length: Int(extradataSize)),
            ],
        ]
        dic[kCVImageBufferPixelAspectRatioKey] = codecpar.sample_aspect_ratio.size.aspectRatio
        dic[kCVImageBufferColorPrimariesKey] = codecpar.color_primaries.colorPrimaries
        dic[kCVImageBufferTransferFunctionKey] = codecpar.color_trc.transferFunction
        dic[kCVImageBufferYCbCrMatrixKey] = codecpar.color_space.ycbcrMatrix
        // swiftlint:disable line_length
        var description: CMFormatDescription?
        var status = CMVideoFormatDescriptionCreate(allocator: kCFAllocatorDefault, codecType: videoCodecType, width: codecpar.width, height: codecpar.height, extensions: dic, formatDescriptionOut: &description)
        // swiftlint:enable line_length
        guard status == noErr, let formatDescription = description else {
            return nil
        }
        self.formatDescription = formatDescription
//        VTDecompressionSessionCanAcceptFormatDescription(<#T##session: VTDecompressionSession##VTDecompressionSession#>, formatDescription: <#T##CMFormatDescription#>)
        let attributes: NSMutableDictionary = [
            kCVPixelBufferPixelFormatTypeKey: pixelFormatType,
            kCVPixelBufferMetalCompatibilityKey: true,
        ]
        var session: VTDecompressionSession?
        // swiftlint:disable line_length
        status = VTDecompressionSessionCreate(allocator: kCFAllocatorDefault, formatDescription: formatDescription, decoderSpecification: nil, imageBufferAttributes: attributes, outputCallback: nil, decompressionSessionOut: &session)
        // swiftlint:enable line_length
        guard status == noErr, let decompressionSession = session else {
            return nil
        }
        self.decompressionSession = decompressionSession
    }

    deinit {
        VTDecompressionSessionWaitForAsynchronousFrames(decompressionSession)
        VTDecompressionSessionInvalidate(decompressionSession)
    }
}

extension CMFormatDescription {
    fileprivate func getSampleBuffer(isConvertNALSize: Bool, data: UnsafeMutablePointer<UInt8>, size: Int) throws -> CMSampleBuffer {
        if isConvertNALSize {
            var ioContext: UnsafeMutablePointer<AVIOContext>?
            let status = avio_open_dyn_buf(&ioContext)
            if status == 0 {
                var nalSize: UInt32 = 0
                let end = data + size
                var nalStart = data
                while nalStart < end {
                    nalSize = UInt32(nalStart[0]) << 16 | UInt32(nalStart[1]) << 8 | UInt32(nalStart[2])
                    avio_wb32(ioContext, nalSize)
                    nalStart += 3
                    avio_write(ioContext, nalStart, Int32(nalSize))
                    nalStart += Int(nalSize)
                }
                var demuxBuffer: UnsafeMutablePointer<UInt8>?
                let demuxSze = avio_close_dyn_buf(ioContext, &demuxBuffer)
                return try createSampleBuffer(data: demuxBuffer, size: Int(demuxSze))
            } else {
                throw NSError(errorCode: .codecVideoReceiveFrame, ffmpegErrnum: status)
            }
        } else {
            return try createSampleBuffer(data: data, size: size)
        }
    }

    private func createSampleBuffer(data: UnsafeMutablePointer<UInt8>?, size: Int) throws -> CMSampleBuffer {
        var blockBuffer: CMBlockBuffer?
        var sampleBuffer: CMSampleBuffer?
        // swiftlint:disable line_length
        var status = CMBlockBufferCreateWithMemoryBlock(allocator: nil, memoryBlock: data, blockLength: size, blockAllocator: kCFAllocatorNull, customBlockSource: nil, offsetToData: 0, dataLength: size, flags: 0, blockBufferOut: &blockBuffer)
        if status == noErr {
            status = CMSampleBufferCreate(allocator: nil, dataBuffer: blockBuffer, dataReady: true, makeDataReadyCallback: nil, refcon: nil, formatDescription: self, sampleCount: 1, sampleTimingEntryCount: 0, sampleTimingArray: nil, sampleSizeEntryCount: 0, sampleSizeArray: nil, sampleBufferOut: &sampleBuffer)
            if let sampleBuffer = sampleBuffer {
                return sampleBuffer
            }
        }
        throw NSError(errorCode: .codecVideoReceiveFrame, ffmpegErrnum: status)
        // swiftlint:enable line_length
    }
}

extension AVCodecID {
    var mediaSubType: CMFormatDescription.MediaSubType {
        switch self {
        case AV_CODEC_ID_H263:
            return .h263
        case AV_CODEC_ID_H264:
            return .h264
        case AV_CODEC_ID_HEVC:
            return .hevc
        case AV_CODEC_ID_MPEG1VIDEO:
            return .mpeg1Video
        case AV_CODEC_ID_MPEG2VIDEO:
            return .mpeg2Video
        case AV_CODEC_ID_MPEG4:
            return .mpeg4Video
        case AV_CODEC_ID_VP9:
            return CMFormatDescription.MediaSubType(rawValue: kCMVideoCodecType_VP9)
        case AV_CODEC_ID_AAC:
            return .mpeg4AAC
        case AV_CODEC_ID_AC3:
            return .ac3
        case AV_CODEC_ID_ADPCM_IMA_QT:
            return .appleIMA4
        case AV_CODEC_ID_ALAC:
            return .appleLossless
        case AV_CODEC_ID_AMR_NB:
            return .amr
        case AV_CODEC_ID_EAC3:
            return .enhancedAC3
        case AV_CODEC_ID_GSM_MS:
            return .microsoftGSM
        case AV_CODEC_ID_ILBC:
            return .iLBC
        case AV_CODEC_ID_MP1:
            return .mpegLayer1
        case AV_CODEC_ID_MP2:
            return .mpegLayer2
        case AV_CODEC_ID_MP3:
            return .mpegLayer3
        case AV_CODEC_ID_PCM_ALAW:
            return .aLaw
        case AV_CODEC_ID_PCM_MULAW:
            return .uLaw
        case AV_CODEC_ID_QDMC:
            return .qDesign
        case AV_CODEC_ID_QDM2:
            return .qDesign2
        default:
            return CMFormatDescription.MediaSubType(rawValue: 0)
        }
    }
}

extension CMVideoCodecType {
    var avc: String {
        switch self {
        case kCMVideoCodecType_MPEG4Video:
            return "esds"
        case kCMVideoCodecType_H264:
            return "avcC"
        case kCMVideoCodecType_HEVC:
            return "hvcC"
        case kCMVideoCodecType_VP9:
            return "vpcC"
        default: return "avcC"
        }
    }
}
