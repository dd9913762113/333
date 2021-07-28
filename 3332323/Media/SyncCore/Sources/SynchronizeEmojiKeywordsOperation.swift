
import Foundation
//  import MurMurHash32



func addSynchronizeEmojiKeywordsOperation(transaction: Transaction, inputLanguageCode: String, languageCode: String?, fromVersion: Int32?) {
    let tag = OperationLogTags.SynchronizeEmojiKeywords
    let peerId = PeerId(namespace: PeerId.Namespace._internalFromInt32Value(0), id: PeerId.Id._internalFromInt32Value(murMurHashString32(inputLanguageCode)))
    
    var hasExistingOperation = false
    transaction.operationLogEnumerateEntries(peerId: peerId, tag: tag) { entry -> Bool in
        hasExistingOperation = true
        return false
    }
    
    guard !hasExistingOperation else {
        return
    }
    let operationContents = SynchronizeEmojiKeywordsOperation(inputLanguageCode: inputLanguageCode, languageCode: languageCode, fromVersion: fromVersion)
    transaction.operationLogAddEntry(peerId: peerId, tag: tag, tagLocalIndex: .automatic, tagMergedIndex: .automatic, contents: operationContents)
}







public final class SynchronizeEmojiKeywordsOperation: PostboxCoding {
    public let inputLanguageCode: String
    public let languageCode: String?
    public let fromVersion: Int32?
    
    public init(inputLanguageCode: String, languageCode: String?, fromVersion: Int32?) {
        self.inputLanguageCode = inputLanguageCode
        self.languageCode = languageCode
        self.fromVersion = fromVersion
    }
    
    public init(decoder: PostboxDecoder) {
        self.inputLanguageCode = decoder.decodeStringForKey("ilc", orElse: "")
        self.languageCode = decoder.decodeOptionalStringForKey("lc")
        self.fromVersion = decoder.decodeOptionalInt32ForKey("v")
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeString(self.inputLanguageCode, forKey: "ilc")
        if let languageCode = self.languageCode {
            encoder.encodeString(languageCode, forKey: "lc")
        } else {
            encoder.encodeNil(forKey: "lc")
        }
        if let fromVersion = self.fromVersion {
            encoder.encodeInt32(fromVersion, forKey: "v")
        } else {
            encoder.encodeNil(forKey: "v")
        }
    }
}
