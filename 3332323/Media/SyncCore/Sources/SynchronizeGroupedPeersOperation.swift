
import Foundation

import SwiftSignalKit



public func updatePeerGroupIdInteractively(postbox: Postbox, peerId: PeerId, groupId: PeerGroupId) -> Signal<Void, NoError> {
    return postbox.transaction { transaction -> Void in
        updatePeerGroupIdInteractively(transaction: transaction, peerId: peerId, groupId: groupId)
    }
}

public func updatePeerGroupIdInteractively(transaction: Transaction, peerId: PeerId, groupId: PeerGroupId) {
    let initialInclusion = transaction.getPeerChatListInclusion(peerId)
    var updatedInclusion = initialInclusion
    switch initialInclusion {
        case .notIncluded:
            break
        case let .ifHasMessagesOrOneOf(currentGroupId, pinningIndex, minTimestamp):
            if currentGroupId == groupId {
                return
            }
            if pinningIndex != nil {
                /*let updatedPinnedItems = transaction.getPinnedItemIds(groupId: currentGroupId).filter({ $0 != .peer(peerId) })
                transaction.setPinnedItemIds(groupId: currentGroupId, itemIds: updatedPinnedItems)*/
            }
            updatedInclusion = .ifHasMessagesOrOneOf(groupId: groupId, pinningIndex: nil, minTimestamp: minTimestamp)
    }
    if initialInclusion != updatedInclusion {
        transaction.updatePeerChatListInclusion(peerId, inclusion: updatedInclusion)
        if peerId.namespace != Namespaces.Peer.SecretChat {
            addSynchronizeGroupedPeersOperation(transaction: transaction, peerId: peerId, groupId: groupId)
        }
    }
}

private func addSynchronizeGroupedPeersOperation(transaction: Transaction, peerId: PeerId, groupId: PeerGroupId) {
    let tag: PeerOperationLogTag = OperationLogTags.SynchronizeGroupedPeers
    let logPeerId = PeerId(0)
    
    transaction.operationLogAddEntry(peerId: logPeerId, tag: tag, tagLocalIndex: .automatic, tagMergedIndex: .automatic, contents: SynchronizeGroupedPeersOperation(peerId: peerId, groupId: groupId))
}














public final class SynchronizeGroupedPeersOperation: PostboxCoding {
    public let peerId: PeerId
    public let groupId: PeerGroupId
    
    public init(peerId: PeerId, groupId: PeerGroupId) {
        self.peerId = peerId
        self.groupId = groupId
    }
    
    public init(decoder: PostboxDecoder) {
        self.peerId = PeerId(decoder.decodeInt64ForKey("peerId", orElse: 0))
        self.groupId = PeerGroupId.init(rawValue: decoder.decodeInt32ForKey("groupId", orElse: 0))
    }
    
    public func encode(_ encoder: PostboxEncoder) {
        encoder.encodeInt64(self.peerId.toInt64(), forKey: "peerId")
        encoder.encodeInt32(self.groupId.rawValue, forKey: "groupId")
    }
}
