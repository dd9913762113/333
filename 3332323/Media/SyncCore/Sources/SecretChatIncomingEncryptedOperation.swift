
import Foundation





private func keyFingerprintFromBytes(_ bytes: Buffer) -> Int64 {
    if let memory = bytes.data, bytes.size >= 4 {
        var fingerprint: Int64 = 0
        memcpy(&fingerprint, memory, 8)
        return fingerprint
    }
    return 0
}

extension SecretChatIncomingEncryptedOperation {
    convenience init(message: Api.EncryptedMessage) {
        switch message {
            case let .encryptedMessage(randomId, chatId, date, bytes, file):
                self.init(peerId: PeerId(namespace: Namespaces.Peer.SecretChat, id: PeerId.Id._internalFromInt32Value(chatId)), globallyUniqueId: randomId, timestamp: date, type: .message, keyFingerprint: keyFingerprintFromBytes(bytes), contents: MemoryBuffer(bytes), mediaFileReference: SecretChatFileReference(file))
            case let .encryptedMessageService(randomId, chatId, date, bytes):
                self.init(peerId: PeerId(namespace: Namespaces.Peer.SecretChat, id: PeerId.Id._internalFromInt32Value(chatId)), globallyUniqueId: randomId, timestamp: date, type: .service, keyFingerprint: keyFingerprintFromBytes(bytes), contents: MemoryBuffer(bytes), mediaFileReference: nil)
        }
    }
}

















public enum SecretChatIncomingEncryptedOperationType: Int32 {
    case message
    case service
    
    public init(_ value: Int32) {
        if value == 0 {
            self = .message
        } else {
            self = .service
        }
    }
    
    public var value: Int32 {
        switch self {
            case .message:
                return 0
            case .service:
                return 1
        }
    }
}

public final class SecretChatIncomingEncryptedOperation: PostboxCoding {
    public let peerId: PeerId
    public let globallyUniqueId: Int64
    public let timestamp: Int32
    public let type: SecretChatIncomingEncryptedOperationType
    public let keyFingerprint: Int64
    public let contents: MemoryBuffer
    public let mediaFileReference: SecretChatFileReference?
    
    public init(peerId: PeerId, globallyUniqueId: Int64, timestamp: Int32, type: SecretChatIncomingEncryptedOperationType, keyFingerprint: Int64, contents: MemoryBuffer, mediaFileReference: SecretChatFileReference?) {
        self.peerId = peerId
        self.globallyUniqueId = globallyUniqueId
        self.timestamp = timestamp
        self.type = type
        self.keyFingerprint = keyFingerprint
        self.contents = contents
        self.mediaFileReference = mediaFileReference
    }
    
    public init(decoder: PostboxDecoder) {
        self.peerId = PeerId(decoder.decodeInt64ForKey("p", orElse: 0))
        self.globallyUniqueId = decoder.decodeInt64ForKey("u", orElse: 0)
        self.timestamp = decoder.decodeInt32ForKey("t", orElse: 0)
        self.type = SecretChatIncomingEncryptedOperationType(decoder.decodeInt32ForKey("k", orElse: 0))
        self.keyFingerprint = decoder.decodeInt64ForKey("f", orElse: 0)
        self.contents = decoder.decodeBytesForKey("c")!
        self.mediaFileReference = decoder.decodeObjectForKey("m", decoder: { SecretChatFileReference(decoder: $0) }) as? SecretChatFileReference
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt64(self.peerId.toInt64(), forKey: "p")
        encoder.encodeInt64(self.globallyUniqueId, forKey: "u")
        encoder.encodeInt32(self.timestamp, forKey: "t")
        encoder.encodeInt32(self.type.value, forKey: "k")
        encoder.encodeInt64(self.keyFingerprint, forKey: "f")
        encoder.encodeBytes(self.contents, forKey: "c")
        if let mediaFileReference = self.mediaFileReference {
            encoder.encodeObject(mediaFileReference, forKey: "m")
        } else {
            encoder.encodeNil(forKey: "m")
        }
    }
}
