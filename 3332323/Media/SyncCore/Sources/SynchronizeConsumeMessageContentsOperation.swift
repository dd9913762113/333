import Foundation



func addSynchronizeConsumeMessageContentsOperation(transaction: Transaction, messageIds: [MessageId]) {
    for (peerId, messageIds) in messagesIdsGroupedByPeerId(Set(messageIds)) {
        var updateLocalIndex: Int32?
        /*transaction.operationLogEnumerateEntries(peerId: peerId, tag: OperationLogTags.SynchronizeConsumeMessageContents, { entry in
            updateLocalIndex = entry.tagLocalIndex
            return false
        })*/
        let operationContents = SynchronizeConsumeMessageContentsOperation(messageIds: messageIds)
        if let updateLocalIndex = updateLocalIndex {
            let _ = transaction.operationLogRemoveEntry(peerId: peerId, tag: OperationLogTags.SynchronizeConsumeMessageContents, tagLocalIndex: updateLocalIndex)
        }
        transaction.operationLogAddEntry(peerId: peerId, tag: OperationLogTags.SynchronizeConsumeMessageContents, tagLocalIndex: .automatic, tagMergedIndex: .automatic, contents: operationContents)
    }
}







public final class SynchronizeConsumeMessageContentsOperation: PostboxCoding {
    public let messageIds: [MessageId]
    
    public init(messageIds: [MessageId]) {
        self.messageIds = messageIds
    }
    
    public init(decoder: PostboxDecoder) {
        self.messageIds = MessageId.decodeArrayFromBuffer(decoder.decodeBytesForKeyNoCopy("i")!)
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        let buffer = WriteBuffer()
        MessageId.encodeArrayToBuffer(self.messageIds, buffer: buffer)
        encoder.encodeBytes(buffer, forKey: "i")
    }
}
