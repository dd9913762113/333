
import Foundation



func addSynchronizeChatInputStateOperation(transaction: Transaction, peerId: PeerId) {
    var updateLocalIndex: Int32?
    let tag: PeerOperationLogTag = OperationLogTags.SynchronizeChatInputStates
    
    var previousOperation: SynchronizeChatInputStateOperation?
    transaction.operationLogEnumerateEntries(peerId: peerId, tag: tag, { entry in
        updateLocalIndex = entry.tagLocalIndex
        if let operation = entry.contents as? SynchronizeChatInputStateOperation {
            previousOperation = operation
        }
        return false
    })
    var previousState: SynchronizeableChatInputState?
    if let previousOperation = previousOperation {
        previousState = previousOperation.previousState
    } else if let peerChatInterfaceState = transaction.getPeerChatInterfaceState(peerId) as? SynchronizeableChatInterfaceState {
        previousState = peerChatInterfaceState.synchronizeableInputState
    }
    let operationContents = SynchronizeChatInputStateOperation(previousState: previousState)
    if let updateLocalIndex = updateLocalIndex {
        let _ = transaction.operationLogRemoveEntry(peerId: peerId, tag: tag, tagLocalIndex: updateLocalIndex)
    }
    transaction.operationLogAddEntry(peerId: peerId, tag: tag, tagLocalIndex: .automatic, tagMergedIndex: .automatic, contents: operationContents)
}













public final class SynchronizeChatInputStateOperation: PostboxCoding {
    public let previousState: SynchronizeableChatInputState?
    
    public init(previousState: SynchronizeableChatInputState?) {
        self.previousState = previousState
    }
    
    public init(decoder: PostboxDecoder) {
        self.previousState = decoder.decodeObjectForKey("p", decoder: { SynchronizeableChatInputState(decoder: $0) }) as? SynchronizeableChatInputState
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        if let previousState = self.previousState {
            encoder.encodeObject(previousState, forKey: "p")
        } else {
            encoder.encodeNil(forKey: "p")
        }
    }
}
