
import Foundation

import SwiftSignalKit





func validatedEncryptionConfig(postbox: Postbox, network: Network) -> Signal<SecretChatEncryptionConfig, NoError> {
    return network.request(Api.functions.messages.getDhConfig(version: 0, randomLength: 0))
    |> retryRequest
    |> mapToSignal { result -> Signal<SecretChatEncryptionConfig, NoError> in
        switch result {
            case let .dhConfig(g, p, version, _):
                if !MTCheckIsSafeG(UInt32(g)) {
                    Logger.shared.log("SecretChatEncryptionConfig", "Invalid g")
                    return .complete()
                }
                
                if !MTCheckMod(network.encryptionProvider, p.makeData(), UInt32(g), network.context.keychain) {
                    Logger.shared.log("SecretChatEncryptionConfig", "Invalid p or g")
                    return .complete()
                }
                
                if !MTCheckIsSafePrime(network.encryptionProvider, p.makeData(), network.context.keychain) {
                    Logger.shared.log("SecretChatEncryptionConfig", "Invalid p")
                    return .never()
                }
                return .single(SecretChatEncryptionConfig(g: g, p: MemoryBuffer(p), version: version))
            case .dhConfigNotModified(_):
                assertionFailure()
                return .never()
        }
    }
}





















public final class SecretChatEncryptionConfig: PostboxCoding {
    public let g: Int32
    public let p: MemoryBuffer
    public let version: Int32
    
    public init(g: Int32, p: MemoryBuffer, version: Int32) {
        self.g = g
        self.p = p
        self.version = version
    }
    
    public init(decoder: PostboxDecoder) {
        self.g = decoder.decodeInt32ForKey("g", orElse: 0)
        self.p = decoder.decodeBytesForKey("p")!
        self.version = decoder.decodeInt32ForKey("v", orElse: 0)
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt32(self.g, forKey: "g")
        encoder.encodeBytes(self.p, forKey: "p")
        encoder.encodeInt32(self.version, forKey: "v")
    }
}
