import Foundation
import SwiftSignalKit

import SwiftSignalKit




private enum AccountKind {
    case authorized
    case unauthorized
}

private var declaredEncodables: Void = {
    declareEncodable(AuthAccountRecord.self, f: { AuthAccountRecord(decoder: $0) })
    declareEncodable(UnauthorizedAccountState.self, f: { UnauthorizedAccountState(decoder: $0) })
    declareEncodable(AuthorizedAccountState.self, f: { AuthorizedAccountState(decoder: $0) })
    declareEncodable(TelegramUser.self, f: { TelegramUser(decoder: $0) })
    declareEncodable(TelegramGroup.self, f: { TelegramGroup(decoder: $0) })
    declareEncodable(TelegramChannel.self, f: { TelegramChannel(decoder: $0) })
    declareEncodable(TelegramMediaImage.self, f: { TelegramMediaImage(decoder: $0) })
    declareEncodable(TelegramMediaImageRepresentation.self, f: { TelegramMediaImageRepresentation(decoder: $0) })
    declareEncodable(TelegramMediaContact.self, f: { TelegramMediaContact(decoder: $0) })
    declareEncodable(TelegramMediaMap.self, f: { TelegramMediaMap(decoder: $0) })
    declareEncodable(TelegramMediaFile.self, f: { TelegramMediaFile(decoder: $0) })
    declareEncodable(TelegramMediaFileAttribute.self, f: { TelegramMediaFileAttribute(decoder: $0) })
    declareEncodable(CloudFileMediaResource.self, f: { CloudFileMediaResource(decoder: $0) })
    declareEncodable(ChannelState.self, f: { ChannelState(decoder: $0) })
    declareEncodable(RegularChatState.self, f: { RegularChatState(decoder: $0) })
    declareEncodable(InlineBotMessageAttribute.self, f: { InlineBotMessageAttribute(decoder: $0) })
    declareEncodable(TextEntitiesMessageAttribute.self, f: { TextEntitiesMessageAttribute(decoder: $0) })
    declareEncodable(ReplyMessageAttribute.self, f: { ReplyMessageAttribute(decoder: $0) })
    declareEncodable(ReplyThreadMessageAttribute.self, f: { ReplyThreadMessageAttribute(decoder: $0) })
    declareEncodable(ReactionsMessageAttribute.self, f: { ReactionsMessageAttribute(decoder: $0) })
    declareEncodable(PendingReactionsMessageAttribute.self, f: { PendingReactionsMessageAttribute(decoder: $0) })
    declareEncodable(CloudDocumentMediaResource.self, f: { CloudDocumentMediaResource(decoder: $0) })
    declareEncodable(TelegramMediaWebpage.self, f: { TelegramMediaWebpage(decoder: $0) })
    declareEncodable(ViewCountMessageAttribute.self, f: { ViewCountMessageAttribute(decoder: $0) })
    declareEncodable(ForwardCountMessageAttribute.self, f: { ForwardCountMessageAttribute(decoder: $0) })
    declareEncodable(NotificationInfoMessageAttribute.self, f: { NotificationInfoMessageAttribute(decoder: $0) })
    declareEncodable(TelegramMediaAction.self, f: { TelegramMediaAction(decoder: $0) })
    declareEncodable(TelegramPeerNotificationSettings.self, f: { TelegramPeerNotificationSettings(decoder: $0) })
    declareEncodable(CachedUserData.self, f: { CachedUserData(decoder: $0) })
    declareEncodable(BotInfo.self, f: { BotInfo(decoder: $0) })
    declareEncodable(CachedGroupData.self, f: { CachedGroupData(decoder: $0) })
    declareEncodable(CachedChannelData.self, f: { CachedChannelData(decoder: $0) })
    declareEncodable(TelegramUserPresence.self, f: { TelegramUserPresence(decoder: $0) })
    declareEncodable(LocalFileMediaResource.self, f: { LocalFileMediaResource(decoder: $0) })
    declareEncodable(StickerPackCollectionInfo.self, f: { StickerPackCollectionInfo(decoder: $0) })
    declareEncodable(StickerPackItem.self, f: { StickerPackItem(decoder: $0) })
    declareEncodable(LocalFileReferenceMediaResource.self, f: { LocalFileReferenceMediaResource(decoder: $0) })
    declareEncodable(OutgoingMessageInfoAttribute.self, f: { OutgoingMessageInfoAttribute(decoder: $0) })
    declareEncodable(ForwardSourceInfoAttribute.self, f: { ForwardSourceInfoAttribute(decoder: $0) })
    declareEncodable(SourceReferenceMessageAttribute.self, f: { SourceReferenceMessageAttribute(decoder: $0) })
    declareEncodable(EditedMessageAttribute.self, f: { EditedMessageAttribute(decoder: $0) })
    declareEncodable(ReplyMarkupMessageAttribute.self, f: { ReplyMarkupMessageAttribute(decoder: $0) })
    declareEncodable(CachedResolvedByNamePeer.self, f: { CachedResolvedByNamePeer(decoder: $0) })
    declareEncodable(OutgoingChatContextResultMessageAttribute.self, f: { OutgoingChatContextResultMessageAttribute(decoder: $0) })
    declareEncodable(HttpReferenceMediaResource.self, f: { HttpReferenceMediaResource(decoder: $0) })
    declareEncodable(WebFileReferenceMediaResource.self, f: { WebFileReferenceMediaResource(decoder: $0) })
    declareEncodable(EmptyMediaResource.self, f: { EmptyMediaResource(decoder: $0) })
    declareEncodable(TelegramSecretChat.self, f: { TelegramSecretChat(decoder: $0) })
    declareEncodable(SecretChatState.self, f: { SecretChatState(decoder: $0) })
    declareEncodable(SecretChatIncomingEncryptedOperation.self, f: { SecretChatIncomingEncryptedOperation(decoder: $0) })
    declareEncodable(SecretChatIncomingDecryptedOperation.self, f: { SecretChatIncomingDecryptedOperation(decoder: $0) })
    declareEncodable(SecretChatOutgoingOperation.self, f: { SecretChatOutgoingOperation(decoder: $0) })
    declareEncodable(SecretFileMediaResource.self, f: { SecretFileMediaResource(decoder: $0) })
    declareEncodable(CloudChatRemoveMessagesOperation.self, f: { CloudChatRemoveMessagesOperation(decoder: $0) })
    declareEncodable(AutoremoveTimeoutMessageAttribute.self, f: { AutoremoveTimeoutMessageAttribute(decoder: $0) })
    declareEncodable(AutoclearTimeoutMessageAttribute.self, f: { AutoclearTimeoutMessageAttribute(decoder: $0) })
    declareEncodable(GlobalNotificationSettings.self, f: { GlobalNotificationSettings(decoder: $0) })
    declareEncodable(CloudChatRemoveChatOperation.self, f: { CloudChatRemoveChatOperation(decoder: $0) })
    declareEncodable(SynchronizePinnedChatsOperation.self, f: { SynchronizePinnedChatsOperation(decoder: $0) })
    declareEncodable(SynchronizeConsumeMessageContentsOperation.self, f: { SynchronizeConsumeMessageContentsOperation(decoder: $0) })
    declareEncodable(RecentMediaItem.self, f: { RecentMediaItem(decoder: $0) })
    declareEncodable(RecentPeerItem.self, f: { RecentPeerItem(decoder: $0) })
    declareEncodable(RecentHashtagItem.self, f: { RecentHashtagItem(decoder: $0) })
    declareEncodable(LoggedOutAccountAttribute.self, f: { LoggedOutAccountAttribute(decoder: $0) })
    declareEncodable(AccountEnvironmentAttribute.self, f: { AccountEnvironmentAttribute(decoder: $0) })
    declareEncodable(AccountSortOrderAttribute.self, f: { AccountSortOrderAttribute(decoder: $0) })
    declareEncodable(CloudChatClearHistoryOperation.self, f: { CloudChatClearHistoryOperation(decoder: $0) })
    declareEncodable(OutgoingContentInfoMessageAttribute.self, f: { OutgoingContentInfoMessageAttribute(decoder: $0) })
    declareEncodable(ConsumableContentMessageAttribute.self, f: { ConsumableContentMessageAttribute(decoder: $0) })
    declareEncodable(TelegramMediaGame.self, f: { TelegramMediaGame(decoder: $0) })
    declareEncodable(TelegramMediaInvoice.self, f: { TelegramMediaInvoice(decoder: $0) })
    declareEncodable(TelegramMediaWebFile.self, f: { TelegramMediaWebFile(decoder: $0) })
    declareEncodable(SynchronizeInstalledStickerPacksOperation.self, f: { SynchronizeInstalledStickerPacksOperation(decoder: $0) })
    declareEncodable(FeaturedStickerPackItem.self, f: { FeaturedStickerPackItem(decoder: $0) })
    declareEncodable(SynchronizeMarkFeaturedStickerPacksAsSeenOperation.self, f: { SynchronizeMarkFeaturedStickerPacksAsSeenOperation(decoder: $0) })
    declareEncodable(ArchivedStickerPacksInfo.self, f: { ArchivedStickerPacksInfo(decoder: $0) })
    declareEncodable(SynchronizeChatInputStateOperation.self, f: { SynchronizeChatInputStateOperation(decoder: $0) })
    declareEncodable(SynchronizeSavedGifsOperation.self, f: { SynchronizeSavedGifsOperation(decoder: $0) })
    declareEncodable(SynchronizeSavedStickersOperation.self, f: { SynchronizeSavedStickersOperation(decoder: $0) })
    declareEncodable(SynchronizeRecentlyUsedMediaOperation.self, f: { SynchronizeRecentlyUsedMediaOperation(decoder: $0) })
    declareEncodable(CacheStorageSettings.self, f: { CacheStorageSettings(decoder: $0) })
    declareEncodable(LocalizationSettings.self, f: { LocalizationSettings(decoder: $0) })
    declareEncodable(LocalizationListState.self, f: { LocalizationListState(decoder: $0) })
    declareEncodable(ProxySettings.self, f: { ProxySettings(decoder: $0) })
    declareEncodable(NetworkSettings.self, f: { NetworkSettings(decoder: $0) })
    declareEncodable(RemoteStorageConfiguration.self, f: { RemoteStorageConfiguration(decoder: $0) })
    declareEncodable(LimitsConfiguration.self, f: { LimitsConfiguration(decoder: $0) })
    declareEncodable(VoipConfiguration.self, f: { VoipConfiguration(decoder: $0) })
    declareEncodable(SuggestedLocalizationEntry.self, f: { SuggestedLocalizationEntry(decoder: $0) })
    declareEncodable(SynchronizeLocalizationUpdatesOperation.self, f: { SynchronizeLocalizationUpdatesOperation(decoder: $0) })
    declareEncodable(ChannelMessageStateVersionAttribute.self, f: { ChannelMessageStateVersionAttribute(decoder: $0) })
    declareEncodable(PeerGroupMessageStateVersionAttribute.self, f: { PeerGroupMessageStateVersionAttribute(decoder: $0) })
    declareEncodable(CachedSecretChatData.self, f: { CachedSecretChatData(decoder: $0) })
    declareEncodable(TemporaryTwoStepPasswordToken.self, f: { TemporaryTwoStepPasswordToken(decoder: $0) })
    declareEncodable(AuthorSignatureMessageAttribute.self, f: { AuthorSignatureMessageAttribute(decoder: $0) })
    declareEncodable(TelegramMediaExpiredContent.self, f: { TelegramMediaExpiredContent(decoder: $0) })
    declareEncodable(SavedStickerItem.self, f: { SavedStickerItem(decoder: $0) })
    declareEncodable(ConsumablePersonalMentionMessageAttribute.self, f: { ConsumablePersonalMentionMessageAttribute(decoder: $0) })
    declareEncodable(ConsumePersonalMessageAction.self, f: { ConsumePersonalMessageAction(decoder: $0) })
    declareEncodable(CachedStickerPack.self, f: { CachedStickerPack(decoder: $0) })
    declareEncodable(LoggingSettings.self, f: { LoggingSettings(decoder: $0) })
    declareEncodable(CachedLocalizationInfos.self, f: { CachedLocalizationInfos(decoder: $0) })
    declareEncodable(CachedSecureIdConfiguration.self, f: { CachedSecureIdConfiguration(decoder: $0) })
    declareEncodable(CachedWallpapersConfiguration.self, f: { CachedWallpapersConfiguration(decoder: $0) })
    declareEncodable(CachedThemesConfiguration.self, f: { CachedThemesConfiguration(decoder: $0) })
    declareEncodable(SynchronizeGroupedPeersOperation.self, f: { SynchronizeGroupedPeersOperation(decoder: $0) })
    declareEncodable(ContentPrivacySettings.self, f: { ContentPrivacySettings(decoder: $0) })
    declareEncodable(TelegramDeviceContactImportedData.self, f: { TelegramDeviceContactImportedData(decoder: $0) })
    declareEncodable(SecureFileMediaResource.self, f: { SecureFileMediaResource(decoder: $0) })
    declareEncodable(CachedStickerQueryResult.self, f: { CachedStickerQueryResult(decoder: $0) })
    declareEncodable(TelegramWallpaper.self, f: { TelegramWallpaper(decoder: $0) })
    declareEncodable(TelegramTheme.self, f: { TelegramTheme(decoder: $0) })
    declareEncodable(ThemeSettings.self, f: { ThemeSettings(decoder: $0) })
    declareEncodable(SynchronizeMarkAllUnseenPersonalMessagesOperation.self, f: { SynchronizeMarkAllUnseenPersonalMessagesOperation(decoder: $0) })
    declareEncodable(SynchronizeAppLogEventsOperation.self, f: { SynchronizeAppLogEventsOperation(decoder: $0) })
    declareEncodable(CachedRecentPeers.self, f: { CachedRecentPeers(decoder: $0) })
    declareEncodable(AppChangelogState.self, f: { AppChangelogState(decoder: $0) })
    declareEncodable(AppConfiguration.self, f: { AppConfiguration(decoder: $0) })
    declareEncodable(JSON.self, f: { JSON(decoder: $0) })
    declareEncodable(SearchBotsConfiguration.self, f: { SearchBotsConfiguration(decoder: $0) })
    declareEncodable(AutodownloadSettings.self, f: { AutodownloadSettings(decoder: $0 )})
    declareEncodable(TelegramMediaPoll.self, f: { TelegramMediaPoll(decoder: $0) })
    declareEncodable(TelegramMediaUnsupported.self, f: { TelegramMediaUnsupported(decoder: $0) })
    declareEncodable(ContactsSettings.self, f: { ContactsSettings(decoder: $0) })
    declareEncodable(SecretChatSettings.self, f: { SecretChatSettings(decoder: $0) })
    declareEncodable(EmojiKeywordCollectionInfo.self, f: { EmojiKeywordCollectionInfo(decoder: $0) })
    declareEncodable(EmojiKeywordItem.self, f: { EmojiKeywordItem(decoder: $0) })
    declareEncodable(SynchronizeEmojiKeywordsOperation.self, f: { SynchronizeEmojiKeywordsOperation(decoder: $0) })
    declareEncodable(CloudPhotoSizeMediaResource.self, f: { CloudPhotoSizeMediaResource(decoder: $0) })
    declareEncodable(CloudDocumentSizeMediaResource.self, f: { CloudDocumentSizeMediaResource(decoder: $0) })
    declareEncodable(CloudPeerPhotoSizeMediaResource.self, f: { CloudPeerPhotoSizeMediaResource(decoder: $0) })
    declareEncodable(CloudStickerPackThumbnailMediaResource.self, f: { CloudStickerPackThumbnailMediaResource(decoder: $0) })
    declareEncodable(AccountBackupDataAttribute.self, f: { AccountBackupDataAttribute(decoder: $0) })
    declareEncodable(ContentRequiresValidationMessageAttribute.self, f: { ContentRequiresValidationMessageAttribute(decoder: $0) })
    declareEncodable(WasScheduledMessageAttribute.self, f: { WasScheduledMessageAttribute(decoder: $0) })
    declareEncodable(OutgoingScheduleInfoMessageAttribute.self, f: { OutgoingScheduleInfoMessageAttribute(decoder: $0) })
    declareEncodable(UpdateMessageReactionsAction.self, f: { UpdateMessageReactionsAction(decoder: $0) })
    declareEncodable(RestrictedContentMessageAttribute.self, f: { RestrictedContentMessageAttribute(decoder: $0) })
    declareEncodable(SendScheduledMessageImmediatelyAction.self, f: { SendScheduledMessageImmediatelyAction(decoder: $0) })
    declareEncodable(WalletCollection.self, f: { WalletCollection(decoder: $0) })
    declareEncodable(EmbeddedMediaStickersMessageAttribute.self, f: { EmbeddedMediaStickersMessageAttribute(decoder: $0) })
    declareEncodable(TelegramMediaWebpageAttribute.self, f: { TelegramMediaWebpageAttribute(decoder: $0) })
    declareEncodable(CachedPollOptionResult.self, f: { CachedPollOptionResult(decoder: $0) })
    declareEncodable(ChatListFiltersState.self, f: { ChatListFiltersState(decoder: $0) })
    declareEncodable(PeersNearbyState.self, f: { PeersNearbyState(decoder: $0) })
    declareEncodable(TelegramMediaDice.self, f: { TelegramMediaDice(decoder: $0) })
    declareEncodable(ChatListFiltersFeaturedState.self, f: { ChatListFiltersFeaturedState(decoder: $0) })
    declareEncodable(SynchronizeChatListFiltersOperation.self, f: { SynchronizeChatListFiltersOperation(decoder: $0) })
    declareEncodable(PromoChatListItem.self, f: { PromoChatListItem(decoder: $0) })
    declareEncodable(TelegramMediaFile.VideoThumbnail.self, f: { TelegramMediaFile.VideoThumbnail(decoder: $0) })
    declareEncodable(CachedChatContextResult.self, f: { CachedChatContextResult(decoder: $0) })
    declareEncodable(PeerAccessRestrictionInfo.self, f: { PeerAccessRestrictionInfo(decoder: $0) })
    declareEncodable(TelegramMediaImage.VideoRepresentation.self, f: { TelegramMediaImage.VideoRepresentation(decoder: $0) })
    declareEncodable(Country.self, f: { Country(decoder: $0) })
    declareEncodable(Country.CountryCode.self, f: { Country.CountryCode(decoder: $0) })
    declareEncodable(CountriesList.self, f: { CountriesList(decoder: $0) })
    declareEncodable(ValidationMessageAttribute.self, f: { ValidationMessageAttribute(decoder: $0) })
    declareEncodable(EmojiSearchQueryMessageAttribute.self, f: { EmojiSearchQueryMessageAttribute(decoder: $0) })
    declareEncodable(CachedPeerInvitationImporters.self, f: { CachedPeerInvitationImporters(decoder: $0) })
    declareEncodable(CachedPeerExportedInvitations.self, f: { CachedPeerExportedInvitations(decoder: $0) })
    declareEncodable(ExportedInvitation.self, f: { ExportedInvitation(decoder: $0) })
    declareEncodable(CachedDisplayAsPeers.self, f: { CachedDisplayAsPeers(decoder: $0) })
    declareEncodable(WallpapersState.self, f: { WallpapersState(decoder: $0) })
    declareEncodable(WallpaperDataResource.self, f: { WallpaperDataResource(decoder: $0) })
    
    return
}()

public func initializeAccountManagement() {
    let _ = declaredEncodables
}

public func rootPathForBasePath(_ appGroupPath: String) -> String {
    return appGroupPath + "/telegram-data"
}

public func performAppGroupUpgrades(appGroupPath: String, rootPath: String) {
    DispatchQueue.global(qos: .default).async {
        let _ = try? FileManager.default.createDirectory(at: URL(fileURLWithPath: rootPath), withIntermediateDirectories: true, attributes: nil)

        if let items = FileManager.default.enumerator(at: URL(fileURLWithPath: appGroupPath), includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles, .skipsSubdirectoryDescendants], errorHandler: nil) {
            let allowedDirectories: [String] = [
                "telegram-data",
                "Library"
            ]

            for url in items {
                guard let url = url as? URL else {
                    continue
                }
                if let isDirectory = try? url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory, isDirectory {
                    if !allowedDirectories.contains(url.lastPathComponent) {
                        let _ = try? FileManager.default.removeItem(at: url)
                    }
                }
            }
        }
    }
    
    do {
        var resourceValues = URLResourceValues()
        resourceValues.isExcludedFromBackup = true
        var mutableUrl = URL(fileURLWithPath: rootPath)
        try mutableUrl.setResourceValues(resourceValues)
    } catch let e {
        print("\(e)")
    }
}

public final class TemporaryAccount {
    public let id: AccountRecordId
    public let basePath: String
    public let postbox: Postbox
    
    init(id: AccountRecordId, basePath: String, postbox: Postbox) {
        self.id = id
        self.basePath = basePath
        self.postbox = postbox
    }
}

public func temporaryAccount(manager: AccountManager, rootPath: String, encryptionParameters: ValueBoxEncryptionParameters) -> Signal<TemporaryAccount, NoError> {
    return manager.allocatedTemporaryAccountId()
    |> mapToSignal { id -> Signal<TemporaryAccount, NoError> in
        let path = "\(rootPath)/\(accountRecordIdPathName(id))"
        return openPostbox(basePath: path + "/postbox", seedConfiguration: telegramPostboxSeedConfiguration, encryptionParameters: encryptionParameters, timestampForAbsoluteTimeBasedOperations: Int32(CFAbsoluteTimeGetCurrent() + NSTimeIntervalSince1970), isTemporary: false, isReadOnly: false, useCopy: false)
        |> mapToSignal { result -> Signal<TemporaryAccount, NoError> in
            switch result {
                case .upgrading:
                    return .complete()
                case .error:
                    return .complete()
                case let .postbox(postbox):
                    return .single(TemporaryAccount(id: id, basePath: path, postbox: postbox))
            }
        }
    }
}

public func currentAccount(allocateIfNotExists: Bool, networkArguments: NetworkInitializationArguments, supplementary: Bool, manager: AccountManager, rootPath: String, auxiliaryMethods: AccountAuxiliaryMethods, encryptionParameters: ValueBoxEncryptionParameters) -> Signal<AccountResult?, NoError> {
    return manager.currentAccountRecord(allocateIfNotExists: allocateIfNotExists)
    |> distinctUntilChanged(isEqual: { lhs, rhs in
        return lhs?.0 == rhs?.0
    })
    |> mapToSignal { record -> Signal<AccountResult?, NoError> in
        if let record = record {
            let reload = ValuePromise<Bool>(true, ignoreRepeated: false)
            return reload.get()
            |> mapToSignal { _ -> Signal<AccountResult?, NoError> in
                let beginWithTestingEnvironment = record.1.contains(where: { attribute in
                    if let attribute = attribute as? AccountEnvironmentAttribute, case .test = attribute.environment {
                        return true
                    } else {
                        return false
                    }
                })
                return accountWithId(accountManager: manager, networkArguments: networkArguments, id: record.0, encryptionParameters: encryptionParameters, supplementary: supplementary, rootPath: rootPath, beginWithTestingEnvironment: beginWithTestingEnvironment, backupData: nil, auxiliaryMethods: auxiliaryMethods)
                |> mapToSignal { accountResult -> Signal<AccountResult?, NoError> in
                    let postbox: Postbox
                    let initialKind: AccountKind
                    switch accountResult {
                        case .upgrading:
                            return .complete()
                        case let .unauthorized(account):
                            postbox = account.postbox
                            initialKind = .unauthorized
                        case let .authorized(account):
                            postbox = account.postbox
                            initialKind = .authorized
                    }
                    let updatedKind = postbox.stateView()
                    |> map { view -> Bool in
                        let kind: AccountKind
                        if view.state is AuthorizedAccountState {
                            kind = .authorized
                        } else {
                            kind = .unauthorized
                        }
                        if kind != initialKind {
                            return true
                        } else {
                            return false
                        }
                    }
                    |> distinctUntilChanged
                    
                    return Signal { subscriber in
                        subscriber.putNext(accountResult)
                        
                        return updatedKind.start(next: { value in
                            if value {
                                reload.set(true)
                            }
                        })
                    }
                }
            }
        } else {
            return .single(nil)
        }
    }
}

public func logoutFromAccount(id: AccountRecordId, accountManager: AccountManager, alreadyLoggedOutRemotely: Bool) -> Signal<Void, NoError> {
    Logger.shared.log("AccountManager", "logoutFromAccount \(id)")
    return accountManager.transaction { transaction -> Void in
        transaction.updateRecord(id, { current in
            if alreadyLoggedOutRemotely {
                return nil
            } else if let current = current {
                var found = false
                for attribute in current.attributes {
                    if attribute is LoggedOutAccountAttribute {
                        found = true
                        break
                    }
                }
                if found {
                    return current
                } else {
                    return AccountRecord(id: current.id, attributes: current.attributes + [LoggedOutAccountAttribute()], temporarySessionId: nil)
                }
            } else {
                return nil
            }
        })
    }
}

public func managedCleanupAccounts(networkArguments: NetworkInitializationArguments, accountManager: AccountManager, rootPath: String, auxiliaryMethods: AccountAuxiliaryMethods, encryptionParameters: ValueBoxEncryptionParameters) -> Signal<Void, NoError> {
    let currentTemporarySessionId = accountManager.temporarySessionId
    return Signal { subscriber in
        let loggedOutAccounts = Atomic<[AccountRecordId: MetaDisposable]>(value: [:])
        let _ = (accountManager.transaction { transaction -> Void in
            for record in transaction.getRecords() {
                if let temporarySessionId = record.temporarySessionId, temporarySessionId != currentTemporarySessionId {
                    transaction.updateRecord(record.id, { _ in
                        return nil
                    })
                }
            }
        }).start()
        let disposable = accountManager.accountRecords().start(next: { view in
            var disposeList: [(AccountRecordId, MetaDisposable)] = []
            var beginList: [(AccountRecordId, [AccountRecordAttribute], MetaDisposable)] = []
            let _ = loggedOutAccounts.modify { disposables in
                var validIds: [AccountRecordId: [AccountRecordAttribute]] = [:]
                outer: for record in view.records {
                    for attribute in record.attributes {
                        if attribute is LoggedOutAccountAttribute {
                            validIds[record.id] = record.attributes
                            continue outer
                        }
                    }
                }
                
                var disposables = disposables
                
                for id in disposables.keys {
                    if validIds[id] == nil {
                        disposeList.append((id, disposables[id]!))
                    }
                }
                
                for (id, _) in disposeList {
                    disposables.removeValue(forKey: id)
                }
                
                for (id, attributes) in validIds {
                    if disposables[id] == nil {
                        let disposable = MetaDisposable()
                        beginList.append((id, attributes, disposable))
                        disposables[id] = disposable
                    }
                }
                
                return disposables
            }
            for (_, disposable) in disposeList {
                disposable.dispose()
            }
            for (id, attributes, disposable) in beginList {
                Logger.shared.log("managedCleanupAccounts", "cleanup \(id), current is \(String(describing: view.currentRecord?.id))")
                disposable.set(cleanupAccount(networkArguments: networkArguments, accountManager: accountManager, id: id, encryptionParameters: encryptionParameters, attributes: attributes, rootPath: rootPath, auxiliaryMethods: auxiliaryMethods).start())
            }
            
            var validPaths = Set<String>()
            for record in view.records {
                if let temporarySessionId = record.temporarySessionId, temporarySessionId != currentTemporarySessionId {
                    continue
                }
                validPaths.insert("\(accountRecordIdPathName(record.id))")
            }
            if let record = view.currentAuthAccount {
                validPaths.insert("\(accountRecordIdPathName(record.id))")
            }
            
            if let files = try? FileManager.default.contentsOfDirectory(at: URL(fileURLWithPath: rootPath), includingPropertiesForKeys: [], options: []) {
                for url in files {
                    if url.lastPathComponent.hasPrefix("account-") {
                        if !validPaths.contains(url.lastPathComponent) {
                            try? FileManager.default.removeItem(at: url)
                        }
                    }
                }
            }
        })
        
        return ActionDisposable {
            disposable.dispose()
        }
    }
}

private func cleanupAccount(networkArguments: NetworkInitializationArguments, accountManager: AccountManager, id: AccountRecordId, encryptionParameters: ValueBoxEncryptionParameters, attributes: [AccountRecordAttribute], rootPath: String, auxiliaryMethods: AccountAuxiliaryMethods) -> Signal<Void, NoError> {
    let beginWithTestingEnvironment = attributes.contains(where: { attribute in
        if let attribute = attribute as? AccountEnvironmentAttribute, case .test = attribute.environment {
            return true
        } else {
            return false
        }
    })
    return accountWithId(accountManager: accountManager, networkArguments: networkArguments, id: id, encryptionParameters: encryptionParameters, supplementary: true, rootPath: rootPath, beginWithTestingEnvironment: beginWithTestingEnvironment, backupData: nil, auxiliaryMethods: auxiliaryMethods)
    |> mapToSignal { account -> Signal<Void, NoError> in
        switch account {
            case .upgrading:
                return .complete()
            case .unauthorized:
                return .complete()
            case let .authorized(account):
                account.shouldBeServiceTaskMaster.set(.single(.always))
                return account.network.request(Api.functions.auth.logOut())
                |> map(Optional.init)
                |> `catch` { _ -> Signal<Api.Bool?, NoError> in
                    return .single(.boolFalse)
                }
                |> mapToSignal { _ -> Signal<Void, NoError> in
                    account.shouldBeServiceTaskMaster.set(.single(.never))
                    return accountManager.transaction { transaction -> Void in
                        transaction.updateRecord(id, { _ in
                            return nil
                        })
                    }
                }
        }
    }
}
















public struct AccountManagerModifier {
    public let getRecords: () -> [AccountRecord]
    public let updateRecord: (AccountRecordId, (AccountRecord?) -> (AccountRecord?)) -> Void
    public let getCurrent: () -> (AccountRecordId, [AccountRecordAttribute])?
    public let setCurrentId: (AccountRecordId) -> Void
    public let getCurrentAuth: () -> AuthAccountRecord?
    public let createAuth: ([AccountRecordAttribute]) -> AuthAccountRecord?
    public let removeAuth: () -> Void
    public let createRecord: ([AccountRecordAttribute]) -> AccountRecordId
    public let getSharedData: (ValueBoxKey) -> PreferencesEntry?
    public let updateSharedData: (ValueBoxKey, (PreferencesEntry?) -> PreferencesEntry?) -> Void
    public let getAccessChallengeData: () -> PostboxAccessChallengeData
    public let setAccessChallengeData: (PostboxAccessChallengeData) -> Void
    public let getVersion: () -> Int32?
    public let setVersion: (Int32) -> Void
    public let getNotice: (NoticeEntryKey) -> NoticeEntry?
    public let setNotice: (NoticeEntryKey, NoticeEntry?) -> Void
    public let clearNotices: () -> Void
}

final class AccountManagerImpl {
    private let queue: Queue
    private let basePath: String
    private let atomicStatePath: String
    private let temporarySessionId: Int64
    private let guardValueBox: ValueBox?
    private let valueBox: ValueBox
    
    private var tables: [Table] = []
    
    private var currentAtomicState: AccountManagerAtomicState
    private var currentAtomicStateUpdated = false
    
    private let legacyMetadataTable: AccountManagerMetadataTable
    private let legacyRecordTable: AccountManagerRecordTable
    
    let sharedDataTable: AccountManagerSharedDataTable
    let noticeTable: NoticeTable
    
    private var currentRecordOperations: [AccountManagerRecordOperation] = []
    private var currentMetadataOperations: [AccountManagerMetadataOperation] = []
    
    private var currentUpdatedSharedDataKeys = Set<ValueBoxKey>()
    private var currentUpdatedNoticeEntryKeys = Set<NoticeEntryKey>()
    private var currentUpdatedAccessChallengeData: PostboxAccessChallengeData?
    
    private var recordsViews = Bag<(MutableAccountRecordsView, ValuePipe<AccountRecordsView>)>()
    
    private var sharedDataViews = Bag<(MutableAccountSharedDataView, ValuePipe<AccountSharedDataView>)>()
    private var noticeEntryViews = Bag<(MutableNoticeEntryView, ValuePipe<NoticeEntryView>)>()
    private var accessChallengeDataViews = Bag<(MutableAccessChallengeDataView, ValuePipe<AccessChallengeDataView>)>()
    
    static func getCurrentRecords(basePath: String) -> (records: [AccountRecord], currentId: AccountRecordId?) {
        let atomicStatePath = "\(basePath)/atomic-state"
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: atomicStatePath))
            let atomicState = try JSONDecoder().decode(AccountManagerAtomicState.self, from: data)
            return (atomicState.records.sorted(by: { $0.key.int64 < $1.key.int64 }).map({ $1 }), atomicState.currentRecordId)
        } catch let e {
            postboxLog("decode atomic state error: \(e)")
            preconditionFailure()
        }
    }
    
    fileprivate init?(queue: Queue, basePath: String, isTemporary: Bool, isReadOnly: Bool, temporarySessionId: Int64) {
        let startTime = CFAbsoluteTimeGetCurrent()
        
        self.queue = queue
        self.basePath = basePath
        self.atomicStatePath = "\(basePath)/atomic-state"
        self.temporarySessionId = temporarySessionId
        let _ = try? FileManager.default.createDirectory(atPath: basePath, withIntermediateDirectories: true, attributes: nil)
        guard let guardValueBox = SqliteValueBox(basePath: basePath + "/guard_db", queue: queue, isTemporary: isTemporary, isReadOnly: false, encryptionParameters: nil, upgradeProgress: { _ in }) else {
            return nil
        }
        self.guardValueBox = guardValueBox
        guard let valueBox = SqliteValueBox(basePath: basePath + "/db", queue: queue, isTemporary: isTemporary, isReadOnly: isReadOnly, encryptionParameters: nil, upgradeProgress: { _ in }) else {
            return nil
        }
        self.valueBox = valueBox
        
        self.legacyMetadataTable = AccountManagerMetadataTable(valueBox: self.valueBox, table: AccountManagerMetadataTable.tableSpec(0))
        self.legacyRecordTable = AccountManagerRecordTable(valueBox: self.valueBox, table: AccountManagerRecordTable.tableSpec(1))
        self.sharedDataTable = AccountManagerSharedDataTable(valueBox: self.valueBox, table: AccountManagerSharedDataTable.tableSpec(2))
        self.noticeTable = NoticeTable(valueBox: self.valueBox, table: NoticeTable.tableSpec(3))
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: self.atomicStatePath))
            do {
                let atomicState = try JSONDecoder().decode(AccountManagerAtomicState.self, from: data)
                self.currentAtomicState = atomicState
            } catch let e {
                postboxLog("decode atomic state error: \(e)")
                let _ = try? FileManager.default.removeItem(atPath: self.atomicStatePath)
                preconditionFailure()
            }
        } catch let e {
            postboxLog("load atomic state error: \(e)")
            var legacyRecordDict: [AccountRecordId: AccountRecord] = [:]
            for record in self.legacyRecordTable.getRecords() {
                legacyRecordDict[record.id] = record
            }
            self.currentAtomicState = AccountManagerAtomicState(records: legacyRecordDict, currentRecordId: self.legacyMetadataTable.getCurrentAccountId(), currentAuthRecord: self.legacyMetadataTable.getCurrentAuthAccount(), accessChallengeData: self.legacyMetadataTable.getAccessChallengeData())
            self.syncAtomicStateToFile()
        }
        
        let tableAccessChallengeData = self.legacyMetadataTable.getAccessChallengeData()
        if self.currentAtomicState.accessChallengeData != .none {
            if tableAccessChallengeData == .none {
                self.legacyMetadataTable.setAccessChallengeData(self.currentAtomicState.accessChallengeData)
            }
        } else if tableAccessChallengeData != .none {
            self.currentAtomicState.accessChallengeData = tableAccessChallengeData
            self.syncAtomicStateToFile()
        }
        
        postboxLog("AccountManager: currentAccountId = \(String(describing: currentAtomicState.currentRecordId))")
        
        self.tables.append(self.legacyMetadataTable)
        self.tables.append(self.legacyRecordTable)
        self.tables.append(self.sharedDataTable)
        self.tables.append(self.noticeTable)
        
        postboxLog("AccountManager initialization took \((CFAbsoluteTimeGetCurrent() - startTime) * 1000.0) ms")
    }
    
    deinit {
        assert(self.queue.isCurrent())
    }
    
    fileprivate func transaction<T>(ignoreDisabled: Bool, _ f: @escaping (AccountManagerModifier) -> T) -> Signal<T, NoError> {
        return Signal { subscriber in
            self.queue.justDispatch {
                self.valueBox.begin()
                
                let transaction = AccountManagerModifier(getRecords: {
                    return self.currentAtomicState.records.map { $0.1 }
                }, updateRecord: { id, update in
                    let current = self.currentAtomicState.records[id]
                    let updated = update(current)
                    if updated != current {
                        if let updated = updated {
                            self.currentAtomicState.records[id] = updated
                        } else {
                            self.currentAtomicState.records.removeValue(forKey: id)
                        }
                        self.currentAtomicStateUpdated = true
                        self.currentRecordOperations.append(.set(id: id, record: updated))
                    }
                }, getCurrent: {
                    if let id = self.currentAtomicState.currentRecordId, let record = self.currentAtomicState.records[id] {
                        return (record.id, record.attributes)
                    } else {
                        return nil
                    }
                }, setCurrentId: { id in
                    self.currentAtomicState.currentRecordId = id
                    self.currentMetadataOperations.append(.updateCurrentAccountId(id))
                    self.currentAtomicStateUpdated = true
                }, getCurrentAuth: {
                    if let record = self.currentAtomicState.currentAuthRecord {
                        return record
                    } else {
                        return nil
                    }
                }, createAuth: { attributes in
                    let record = AuthAccountRecord(id: generateAccountRecordId(), attributes: attributes)
                    self.currentAtomicState.currentAuthRecord = record
                    self.currentAtomicStateUpdated = true
                    self.currentMetadataOperations.append(.updateCurrentAuthAccountRecord(record))
                    return record
                }, removeAuth: {
                    self.currentAtomicState.currentAuthRecord = nil
                    self.currentMetadataOperations.append(.updateCurrentAuthAccountRecord(nil))
                    self.currentAtomicStateUpdated = true
                }, createRecord: { attributes in
                    let id = generateAccountRecordId()
                    let record = AccountRecord(id: id, attributes: attributes, temporarySessionId: nil)
                    self.currentAtomicState.records[id] = record
                    self.currentRecordOperations.append(.set(id: id, record: record))
                    self.currentAtomicStateUpdated = true
                    return id
                }, getSharedData: { key in
                    return self.sharedDataTable.get(key: key)
                }, updateSharedData: { key, f in
                    let updated = f(self.sharedDataTable.get(key: key))
                    self.sharedDataTable.set(key: key, value: updated, updatedKeys: &self.currentUpdatedSharedDataKeys)
                }, getAccessChallengeData: {
                    return self.legacyMetadataTable.getAccessChallengeData()
                }, setAccessChallengeData: { data in
                    self.currentUpdatedAccessChallengeData = data
                    self.currentAtomicStateUpdated = true
                    self.legacyMetadataTable.setAccessChallengeData(data)
                    self.currentAtomicState.accessChallengeData = data
                }, getVersion: {
                    return self.legacyMetadataTable.getVersion()
                }, setVersion: { version in
                    self.legacyMetadataTable.setVersion(version)
                }, getNotice: { key in
                    self.noticeTable.get(key: key)
                }, setNotice: { key, value in
                    self.noticeTable.set(key: key, value: value)
                    self.currentUpdatedNoticeEntryKeys.insert(key)
                }, clearNotices: {
                    self.noticeTable.clear()
                })
                
                let result = f(transaction)
               
                self.beforeCommit()
                
                self.valueBox.commit()
                //self.valueBox.checkpoint()
                
                subscriber.putNext(result)
                subscriber.putCompletion()
            }
            return EmptyDisposable
        }
    }
    
    private func syncAtomicStateToFile() {
        if let data = try? JSONEncoder().encode(self.currentAtomicState) {
            if let _ = try? data.write(to: URL(fileURLWithPath: self.atomicStatePath), options: [.atomic]) {
            } else {
                preconditionFailure()
            }
        } else {
            preconditionFailure()
        }
    }
    
    private func beforeCommit() {
        if self.currentAtomicStateUpdated {
            self.syncAtomicStateToFile()
        }
        
        if !self.currentRecordOperations.isEmpty || !self.currentMetadataOperations.isEmpty {
            for (view, pipe) in self.recordsViews.copyItems() {
                if view.replay(operations: self.currentRecordOperations, metadataOperations: self.currentMetadataOperations) {
                    pipe.putNext(AccountRecordsView(view))
                }
            }
        }
        
        if !self.currentUpdatedSharedDataKeys.isEmpty {
            for (view, pipe) in self.sharedDataViews.copyItems() {
                if view.replay(accountManagerImpl: self, updatedKeys: self.currentUpdatedSharedDataKeys) {
                    pipe.putNext(AccountSharedDataView(view))
                }
            }
        }
        
        if !self.currentUpdatedNoticeEntryKeys.isEmpty {
            for (view, pipe) in self.noticeEntryViews.copyItems() {
                if view.replay(accountManagerImpl: self, updatedKeys: self.currentUpdatedNoticeEntryKeys) {
                    pipe.putNext(NoticeEntryView(view))
                }
            }
        }
        
        if let data = self.currentUpdatedAccessChallengeData {
            for (view, pipe) in self.accessChallengeDataViews.copyItems() {
                if view.replay(updatedData: data) {
                    pipe.putNext(AccessChallengeDataView(view))
                }
            }
        }
        
        self.currentRecordOperations.removeAll()
        self.currentMetadataOperations.removeAll()
        self.currentUpdatedSharedDataKeys.removeAll()
        self.currentUpdatedNoticeEntryKeys.removeAll()
        self.currentUpdatedAccessChallengeData = nil
        self.currentAtomicStateUpdated = false
        
        for table in self.tables {
            table.beforeCommit()
        }
    }
    
    fileprivate func accountRecords() -> Signal<AccountRecordsView, NoError> {
        return self.transaction(ignoreDisabled: false, { transaction -> Signal<AccountRecordsView, NoError> in
            return self.accountRecordsInternal(transaction: transaction)
        })
        |> switchToLatest
    }
    
    fileprivate func sharedData(keys: Set<ValueBoxKey>) -> Signal<AccountSharedDataView, NoError> {
        return self.transaction(ignoreDisabled: false, { transaction -> Signal<AccountSharedDataView, NoError> in
            return self.sharedDataInternal(transaction: transaction, keys: keys)
        })
        |> switchToLatest
    }
    
    fileprivate func noticeEntry(key: NoticeEntryKey) -> Signal<NoticeEntryView, NoError> {
        return self.transaction(ignoreDisabled: false, { transaction -> Signal<NoticeEntryView, NoError> in
            return self.noticeEntryInternal(transaction: transaction, key: key)
        })
        |> switchToLatest
    }
    
    fileprivate func accessChallengeData() -> Signal<AccessChallengeDataView, NoError> {
        return self.transaction(ignoreDisabled: false, { transaction -> Signal<AccessChallengeDataView, NoError> in
            return self.accessChallengeDataInternal(transaction: transaction)
        })
        |> switchToLatest
    }
    
    private func accountRecordsInternal(transaction: AccountManagerModifier) -> Signal<AccountRecordsView, NoError> {
        assert(self.queue.isCurrent())
        let mutableView = MutableAccountRecordsView(getRecords: {
            return self.currentAtomicState.records.map { $0.1 }
        }, currentId: self.currentAtomicState.currentRecordId, currentAuth: self.currentAtomicState.currentAuthRecord)
        let pipe = ValuePipe<AccountRecordsView>()
        let index = self.recordsViews.add((mutableView, pipe))
        
        let queue = self.queue
        return (.single(AccountRecordsView(mutableView))
        |> then(pipe.signal()))
        |> `catch` { _ -> Signal<AccountRecordsView, NoError> in
        }
        |> afterDisposed { [weak self] in
            queue.async {
                if let strongSelf = self {
                    strongSelf.recordsViews.remove(index)
                }
            }
        }
    }
    
    private func sharedDataInternal(transaction: AccountManagerModifier, keys: Set<ValueBoxKey>) -> Signal<AccountSharedDataView, NoError> {
        let mutableView = MutableAccountSharedDataView(accountManagerImpl: self, keys: keys)
        let pipe = ValuePipe<AccountSharedDataView>()
        let index = self.sharedDataViews.add((mutableView, pipe))
        
        let queue = self.queue
        return (.single(AccountSharedDataView(mutableView))
        |> then(pipe.signal()))
        |> `catch` { _ -> Signal<AccountSharedDataView, NoError> in
        }
        |> afterDisposed { [weak self] in
            queue.async {
                if let strongSelf = self {
                    strongSelf.sharedDataViews.remove(index)
                }
            }
        }
    }
    
    private func noticeEntryInternal(transaction: AccountManagerModifier, key: NoticeEntryKey) -> Signal<NoticeEntryView, NoError> {
        let mutableView = MutableNoticeEntryView(accountManagerImpl: self, key: key)
        let pipe = ValuePipe<NoticeEntryView>()
        let index = self.noticeEntryViews.add((mutableView, pipe))
        
        let queue = self.queue
        return (.single(NoticeEntryView(mutableView))
        |> then(pipe.signal()))
        |> `catch` { _ -> Signal<NoticeEntryView, NoError> in
        }
        |> afterDisposed { [weak self] in
            queue.async {
                if let strongSelf = self {
                    strongSelf.noticeEntryViews.remove(index)
                }
            }
        }
    }
    
    private func accessChallengeDataInternal(transaction: AccountManagerModifier) -> Signal<AccessChallengeDataView, NoError> {
        let mutableView = MutableAccessChallengeDataView(data: transaction.getAccessChallengeData())
        let pipe = ValuePipe<AccessChallengeDataView>()
        let index = self.accessChallengeDataViews.add((mutableView, pipe))
        
        let queue = self.queue
        return (.single(AccessChallengeDataView(mutableView))
        |> then(pipe.signal()))
        |> `catch` { _ -> Signal<AccessChallengeDataView, NoError> in
        }
        |> afterDisposed { [weak self] in
            queue.async {
                if let strongSelf = self {
                    strongSelf.accessChallengeDataViews.remove(index)
                }
            }
        }
    }
    
    fileprivate func currentAccountRecord(allocateIfNotExists: Bool) -> Signal<(AccountRecordId, [AccountRecordAttribute])?, NoError> {
        return self.transaction(ignoreDisabled: false, { transaction -> Signal<(AccountRecordId, [AccountRecordAttribute])?, NoError> in
            let current = transaction.getCurrent()
            if let _ = current {
            } else if allocateIfNotExists {
                let id = generateAccountRecordId()
                transaction.setCurrentId(id)
                transaction.updateRecord(id, { _ in
                    return AccountRecord(id: id, attributes: [], temporarySessionId: nil)
                })
            } else {
                return .single(nil)
            }
            
            let signal = self.accountRecordsInternal(transaction: transaction)
            |> map { view -> (AccountRecordId, [AccountRecordAttribute])? in
                if let currentRecord = view.currentRecord {
                    return (currentRecord.id, currentRecord.attributes)
                } else {
                    return nil
                }
            }
            
            return signal
        })
        |> switchToLatest
        |> distinctUntilChanged(isEqual: { lhs, rhs in
            if let lhs = lhs, let rhs = rhs {
                if lhs.0 != rhs.0 {
                    return false
                }
                if lhs.1.count != rhs.1.count {
                    return false
                }
                for i in 0 ..< lhs.1.count {
                    if !lhs.1[i].isEqual(to: rhs.1[i]) {
                        return false
                    }
                }
                return true
            } else if (lhs != nil) != (rhs != nil) {
                return false
            } else {
                return true
            }
        })
    }
    
    func allocatedTemporaryAccountId() -> Signal<AccountRecordId, NoError> {
        let temporarySessionId = self.temporarySessionId
        return self.transaction(ignoreDisabled: false, { transaction -> Signal<AccountRecordId, NoError> in
            
            let id = generateAccountRecordId()
            transaction.updateRecord(id, { _ in
                return AccountRecord(id: id, attributes: [], temporarySessionId: temporarySessionId)
            })
            
            return .single(id)
        })
        |> switchToLatest
        |> distinctUntilChanged(isEqual: { lhs, rhs in
            return lhs == rhs
        })
    }
}

private let sharedQueue = Queue()

public final class AccountManager {
    public let basePath: String
    public let mediaBox: MediaBox
    private let queue: Queue
    private let impl: QueueLocalObject<AccountManagerImpl>
    public let temporarySessionId: Int64
    
    public static func getCurrentRecords(basePath: String) -> (records: [AccountRecord], currentId: AccountRecordId?) {
        return AccountManagerImpl.getCurrentRecords(basePath: basePath)
    }
    
    public init(basePath: String, isTemporary: Bool, isReadOnly: Bool) {
        self.queue = sharedQueue
        self.basePath = basePath
        var temporarySessionId: Int64 = 0
        arc4random_buf(&temporarySessionId, 8)
        self.temporarySessionId = temporarySessionId
        let queue = self.queue
        self.impl = QueueLocalObject(queue: queue, generate: {
            if let value = AccountManagerImpl(queue: queue, basePath: basePath, isTemporary: isTemporary, isReadOnly: isReadOnly, temporarySessionId: temporarySessionId) {
                return value
            } else {
                preconditionFailure()
            }
        })
        self.mediaBox = MediaBox(basePath: basePath + "/media")
    }
    
    public func transaction<T>(ignoreDisabled: Bool = false, _ f: @escaping (AccountManagerModifier) -> T) -> Signal<T, NoError> {
        return Signal { subscriber in
            let disposable = MetaDisposable()
            self.impl.with { impl in
                disposable.set(impl.transaction(ignoreDisabled: ignoreDisabled, f).start(next: { next in
                    subscriber.putNext(next)
                }, completed: {
                    subscriber.putCompletion()
                }))
            }
            return disposable
        }
    }
    
    public func accountRecords() -> Signal<AccountRecordsView, NoError> {
        return Signal { subscriber in
            let disposable = MetaDisposable()
            self.impl.with { impl in
                disposable.set(impl.accountRecords().start(next: { next in
                    subscriber.putNext(next)
                }, completed: {
                    subscriber.putCompletion()
                }))
            }
            return disposable
        }
    }
    
    public func sharedData(keys: Set<ValueBoxKey>) -> Signal<AccountSharedDataView, NoError> {
        return Signal { subscriber in
            let disposable = MetaDisposable()
            self.impl.with { impl in
                disposable.set(impl.sharedData(keys: keys).start(next: { next in
                    subscriber.putNext(next)
                }, completed: {
                    subscriber.putCompletion()
                }))
            }
            return disposable
        }
    }
    
    public func noticeEntry(key: NoticeEntryKey) -> Signal<NoticeEntryView, NoError> {
        return Signal { subscriber in
            let disposable = MetaDisposable()
            self.impl.with { impl in
                disposable.set(impl.noticeEntry(key: key).start(next: { next in
                    subscriber.putNext(next)
                }, completed: {
                    subscriber.putCompletion()
                }))
            }
            return disposable
        }
    }
    
    public func accessChallengeData() -> Signal<AccessChallengeDataView, NoError> {
        return Signal { subscriber in
            let disposable = MetaDisposable()
            self.impl.with { impl in
                disposable.set(impl.accessChallengeData().start(next: { next in
                    subscriber.putNext(next)
                }, completed: {
                    subscriber.putCompletion()
                }))
            }
            return disposable
        }
    }
    
    public func currentAccountRecord(allocateIfNotExists: Bool) -> Signal<(AccountRecordId, [AccountRecordAttribute])?, NoError> {
        return Signal { subscriber in
            let disposable = MetaDisposable()
            self.impl.with { impl in
                disposable.set(impl.currentAccountRecord(allocateIfNotExists: allocateIfNotExists).start(next: { next in
                    subscriber.putNext(next)
                }, completed: {
                    subscriber.putCompletion()
                }))
            }
            return disposable
        }
    }
    
    public func allocatedTemporaryAccountId() -> Signal<AccountRecordId, NoError> {
        return Signal { subscriber in
            let disposable = MetaDisposable()
            self.impl.with { impl in
                disposable.set(impl.allocatedTemporaryAccountId().start(next: { next in
                    subscriber.putNext(next)
                }, completed: {
                    subscriber.putCompletion()
                }))
            }
            return disposable
        }
    }
}
