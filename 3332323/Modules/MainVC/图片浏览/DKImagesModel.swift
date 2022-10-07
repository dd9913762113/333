//
//  DKImagesModel.swift
//  3332323
//
//  Created by dd on 7/10/2022.
//  Copyright © 2022 XJW. All rights reserved.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let imagesModel = try? newJSONDecoder().decode(ImagesModel.self, from: jsonData)

import Foundation
import HandyJSON
// MARK: - ImagesModel
struct ImagesModel: Codable {
//struct ImagesModel: HandyJSON {

    var pageProps: PageProps?
    var serverRegionProps: ServerRegionProps?
    var experimentsProps: ExperimentsProps?
    var botProps: BotProps?
    var serverTimestamp: Int?
    var initialBrand: String?
    var nSSP: Bool?

    enum CodingKeys: String, CodingKey {
        case pageProps, serverRegionProps, experimentsProps, botProps, serverTimestamp, initialBrand
        case nSSP = "__N_SSP"
    }
    
}

// MARK: - BotProps
struct BotProps: Codable {
    var isBot: Bool?
}

// MARK: - ExperimentsProps
struct ExperimentsProps: Codable {
    var featureFlags: FeatureFlags?
}

// MARK: - FeatureFlags
struct FeatureFlags: Codable {
}

// MARK: - PageProps
struct PageProps: Codable {
    var assets: [Asset]?
    var imageType: ImageType?
    var isIDSearch, isBot: Bool?
    var meta: Meta?
    var query: QueryClass?
    var searchIDS: [JSONAny]?
    var headerBanner: FeatureFlags?
    var nextI18Next: NextI18Next?

    enum CodingKeys: String, CodingKey {
        case assets, imageType
        case isIDSearch = "isIdSearch"
        case isBot, meta, query
        case searchIDS = "searchIds"
        case headerBanner
        case nextI18Next = "_nextI18Next"
    }
}

// MARK: - Asset
struct Asset: Codable {
    var id: String?
    var type: TypeEnum?
    var alt, title: String?
    var imageType: ImageType?
    var assetDescription: String?
    var aspect: Double?
    var sizes: Sizes?
    var modelReleaseInfo: ModelReleaseInfo?
    var isEditorial: Bool?
    var src: String?
    var displays: [String: Display]?
    var link: String?
    var width, height: Int?
    var channels: [Channel]?
    var contentTier, contributorID: Int?
    var meta: Meta?

    enum CodingKeys: String, CodingKey {
        case id, type, alt, title, imageType
        case assetDescription = "description"
        case aspect, sizes, modelReleaseInfo, isEditorial, src, displays, link, width, height, channels, contentTier
        case contributorID = "contributorId"
        case meta
    }
}

enum Channel: String, Codable {
    case bigstock = "bigstock"
    case selfServe = "self_serve"
    case shutterstock = "shutterstock"
}

// MARK: - Display
struct Display: Codable {
    var src: String?
    var width, height: Double?
}

enum ImageType: String, Codable {
    case photo = "photo"
}

// MARK: - Meta
struct Meta: Codable {
    var pagination: MetaPagination?
    var spellcheckInfo: FeatureFlags?
    var seoNoIndex: Bool?
    var effectiveLanguage: InitialLocale?
    var facetFields: [JSONAny]?
    var trackingID: String?
    var isChildSafe: Bool?
    var query: QueryEnum?
    var relatedKeywords: [RelatedKeyword]?
    var queryTranslations: QueryTranslations?

    enum CodingKeys: String, CodingKey {
        case pagination, spellcheckInfo, seoNoIndex, effectiveLanguage, facetFields
        case trackingID = "trackingId"
        case isChildSafe, query, relatedKeywords, queryTranslations
    }
}

enum InitialLocale: String, Codable {
    case zh = "zh"
}

// MARK: - MetaPagination
struct MetaPagination: Codable {
    var pageNumber, pageSize, totalPages, totalRecords: Int?
    var numInjected: Int?
}

enum QueryEnum: String, Codable {
    case sexy = "sexy"
}

// MARK: - QueryTranslations
struct QueryTranslations: Codable {
    var ja: Ja?
    var el: El?
    var fr: QueryEnum?
    var da: Da?
    var pt: Pt?
    var fi: Fi?
    var ru: Ru?
    var it: It?
    var ko: Ko?
    var vi: Vi?
    var en: QueryEnum?
    var sv: Sv?
    var de: QueryEnum?
    var zhHant: ZhHant?
    var th: Th?
    var id: ID?
    var nl: QueryEnum?
    var he: He?
    var tr: ID?
    var es: Es?
    var hi: Hi?
    var ar: Ar?
    var ro: Ro?
    var zh: ZhEnum?
}

enum Ar: String, Codable {
    case جذاب = "جذاب"
}

enum Da: String, Codable {
    case sexet = "sexet"
}

enum El: String, Codable {
    case σέξι = "σέξι"
}

enum Es: String, Codable {
    case atractiva = "atractiva"
}

enum Fi: String, Codable {
    case seksikäs = "seksikäs"
}

enum He: String, Codable {
    case סקסי = "סקסי"
}

enum Hi: String, Codable {
    case सकस = "सेक्सी"
}

enum ID: String, Codable {
    case seksi = "seksi"
}

enum It: String, Codable {
    case procace = "procace"
}

enum Ja: String, Codable {
    case いろっぽい = "いろっぽい"
}

enum Ko: String, Codable {
    case 섹시 = "섹시"
}

enum Pt: String, Codable {
    case sensual = "sensual"
}

enum Ro: String, Codable {
    case sexi = "sexi"
}

enum Ru: String, Codable {
    case сексапильный = "сексапильный"
}

enum Sv: String, Codable {
    case sexig = "sexig"
}

enum Th: String, Codable {
    case กระตนความรสกทางเพศ = "กระตุ้นความรู้สึกทางเพศ"
}

enum Vi: String, Codable {
    case cuốnHuT = "cuốn hút"
}

enum ZhEnum: String, Codable {
    case 勾人 = "勾人"
}

enum ZhHant: String, Codable {
    case 性感 = "性感"
}

enum RelatedKeyword: String, Codable {
    case 人体 = "人体"
    case 化妆品 = "化妆品"
    case 口紅 = "口紅"
    case 头发和皮肤 = "头发和皮肤"
    case 女人 = "女人"
    case 女式内衣 = "女式内衣"
    case 女装 = "女装"
    case 服装和配饰 = "服装和配饰"
    case 美容与时尚 = "美容与时尚"
    case 親密關係 = "親密關係"
}

enum ModelReleaseInfo: String, Codable {
    case modelReleased = "model_released"
}

// MARK: - Sizes
struct Sizes: Codable {
    var mediumJpg, hugeTiff, smallJpg, hugeJpg: HugeJpg?
}

// MARK: - HugeJpg
struct HugeJpg: Codable {
    var format: Format?
    var dpi: Int?
    var name: Name?
    var width, height: Int?
    var displayName: DisplayName?
    var sizeInBytes: Int?
    var humanReadableSize, widthIn, heightIn, widthCM: String?
    var heightCM: String?

    enum CodingKeys: String, CodingKey {
        case format, dpi, name, width, height, displayName, sizeInBytes, humanReadableSize, widthIn, heightIn
        case widthCM = "widthCm"
        case heightCM = "heightCm"
    }
}

enum DisplayName: String, Codable {
    case huge = "Huge"
    case med = "Med"
    case small = "Small"
}

enum Format: String, Codable {
    case jpg = "jpg"
    case tiff = "tiff"
}

enum Name: String, Codable {
    case hugeJpg = "huge_jpg"
    case hugeTiff = "huge_tiff"
    case mediumJpg = "medium_jpg"
    case smallJpg = "small_jpg"
}

enum TypeEnum: String, Codable {
    case images = "images"
}

// MARK: - NextI18Next
struct NextI18Next: Codable {
    var initialI18NStore: InitialI18NStore?
    var initialLocale: InitialLocale?
    var userConfig: JSONNull?

    enum CodingKeys: String, CodingKey {
        case initialI18NStore = "initialI18nStore"
        case initialLocale, userConfig
    }
}

// MARK: - InitialI18NStore
struct InitialI18NStore: Codable {
    var zh: ZhClass?
}

// MARK: - ZhClass
struct ZhClass: Codable {
    var primaryLayout: [String: String]?
    var searchBar: SearchBar?
    var searchIconButton: SearchIconButton?
    var addToCartViews: AddToCartViews?
    var filterDrawerLayout: FilterDrawerLayout?
    var filterPills: [String: String]?
    var filterPillsShared: FilterPillsShared?
    var imageFilterDrawer, licenseNames: [String: String]?
    var licenseSelectionTable: LicenseSelectionTable?
    var noSearchResults: NoSearchResults?
    var orderConfirmationEmail: OrderConfirmationEmail?
    var overlay: Overlay?
    var pagination: ZhPagination?
    var priceFormatter: PriceFormatter?
    var search: Search?
    var feedbackBanner: FeedbackBanner?
    var sstkHeader: [String: String]?
    var vectorFormatTypeSelect: VectorFormatTypeSelect?
    var videoLicenseTypeSelect: VideoLicenseTypeSelect?
}

// MARK: - AddToCartViews
struct AddToCartViews: Codable {
    var commonActionsAddToCard, commonActionsAddedToCart, commonActionsCancel, commonActionsRedownload: String?
    var commonActionsRemove, commonActionsView, entCartNotAddedSelectVideosSuccess, entCartSizeLimitWarning: String?
    var entItemInCart, entMultipleVideosAddToCartNote, entSelectLicense, entSelectVideosWontBeAddedCartNote: String?
    var notificationsLabelAddToCartFailure: String?

    enum CodingKeys: String, CodingKey {
        case commonActionsAddToCard = "common:actions_add_to_card"
        case commonActionsAddedToCart = "common:actions_added_to_cart"
        case commonActionsCancel = "common:actions_cancel"
        case commonActionsRedownload = "common:actions_redownload"
        case commonActionsRemove = "common:actions_remove"
        case commonActionsView = "common:actions_view"
        case entCartNotAddedSelectVideosSuccess = "ent:cart_not_added_select_videos_success"
        case entCartSizeLimitWarning = "ent:cart_size_limit_warning"
        case entItemInCart = "ent:item_in_cart"
        case entMultipleVideosAddToCartNote = "ent:multiple_videos_add_to_cart_note"
        case entSelectLicense = "ent:select_license"
        case entSelectVideosWontBeAddedCartNote = "ent:select_videos_wont_be_added_cart_note"
        case notificationsLabelAddToCartFailure = "notifications:label_add_to_cart_failure"
    }
}

// MARK: - FeedbackBanner
struct FeedbackBanner: Codable {
    var feedbackLinksFeedbackTextSearch, feedbackLinksFeedbackTitleSearch: String?

    enum CodingKeys: String, CodingKey {
        case feedbackLinksFeedbackTextSearch = "feedback:links_feedback_text_search"
        case feedbackLinksFeedbackTitleSearch = "feedback:links_feedback_title_search"
    }
}

// MARK: - FilterDrawerLayout
struct FilterDrawerLayout: Codable {
    var imageFiltersApply, licenseHistoryFilterButtonClosed, licenseHistoryFilterButtonOpen, searchFiltersClearAllLabel: String?
    var searchFiltersLabel: String?

    enum CodingKeys: String, CodingKey {
        case imageFiltersApply = "image:filters_apply"
        case licenseHistoryFilterButtonClosed = "license-history:filter_button_closed"
        case licenseHistoryFilterButtonOpen = "license-history:filter_button_open"
        case searchFiltersClearAllLabel = "search:filters_clear_all_label"
        case searchFiltersLabel = "search:filters_label"
    }
}

// MARK: - FilterPillsShared
struct FilterPillsShared: Codable {
    var searchFiltersClearAllLabel: String?

    enum CodingKeys: String, CodingKey {
        case searchFiltersClearAllLabel = "search:filters_clear_all_label"
    }
}

// MARK: - LicenseSelectionTable
struct LicenseSelectionTable: Codable {
    var accountAdminCompPrefsOptHighNonWatermarked, accountAdminCompPrefsOptHighWatermarked, accountAdminCompPrefsOptLowNonWatermarked, accountAdminCompPrefsOptLowWatermarked: String?
    var commonActionsAddedToCart, commonActionsRedownload, commonActionsRemove, commonImageSizeVector: String?
    var commonResolutions4K, commonResolutionsHD, commonResolutionsLow, commonResolutionsSD: String?
    var commonResolutionsWeb: String?

    enum CodingKeys: String, CodingKey {
        case accountAdminCompPrefsOptHighNonWatermarked = "account:admin_comp_prefs_opt_high_non_watermarked"
        case accountAdminCompPrefsOptHighWatermarked = "account:admin_comp_prefs_opt_high_watermarked"
        case accountAdminCompPrefsOptLowNonWatermarked = "account:admin_comp_prefs_opt_low_non_watermarked"
        case accountAdminCompPrefsOptLowWatermarked = "account:admin_comp_prefs_opt_low_watermarked"
        case commonActionsAddedToCart = "common:actions_added_to_cart"
        case commonActionsRedownload = "common:actions_redownload"
        case commonActionsRemove = "common:actions_remove"
        case commonImageSizeVector = "common:image_size_vector"
        case commonResolutions4K = "common:resolutions_4k"
        case commonResolutionsHD = "common:resolutions_hd"
        case commonResolutionsLow = "common:resolutions_low"
        case commonResolutionsSD = "common:resolutions_sd"
        case commonResolutionsWeb = "common:resolutions_web"
    }
}

// MARK: - NoSearchResults
struct NoSearchResults: Codable {
    var aiSearchNoMatchesDisableFilters, aiSearchNoMatchesDisableFiltersAction, entSearchNoMatchesBullet3, searchChildSafetyHelpMessage: String?
    var searchChildSafetyTitle, searchIsFilteredClearFilters, searchIsFilteredHeader, searchIsFilteredHelp: String?
    var searchNoMatchesBullet1, searchNoMatchesBullet2, searchNoMatchesBullet3, searchNoMatchesBullet3ContactUs: String?
    var searchNoMatchesHeader, searchNoMatchesReverseAudioSearch: String?

    enum CodingKeys: String, CodingKey {
        case aiSearchNoMatchesDisableFilters = "ai-search:no_matches_disable_filters"
        case aiSearchNoMatchesDisableFiltersAction = "ai-search:no_matches_disable_filters_action"
        case entSearchNoMatchesBullet3 = "ent:search:no_matches_bullet3"
        case searchChildSafetyHelpMessage = "search:child_safety_help_message"
        case searchChildSafetyTitle = "search:child_safety_title"
        case searchIsFilteredClearFilters = "search:is_filtered_clear_filters"
        case searchIsFilteredHeader = "search:is_filtered_header"
        case searchIsFilteredHelp = "search:is_filtered_help"
        case searchNoMatchesBullet1 = "search:no_matches_bullet1"
        case searchNoMatchesBullet2 = "search:no_matches_bullet2"
        case searchNoMatchesBullet3 = "search:no_matches_bullet3"
        case searchNoMatchesBullet3ContactUs = "search:no_matches_bullet3_contact_us"
        case searchNoMatchesHeader = "search:no_matches_header"
        case searchNoMatchesReverseAudioSearch = "search:no_matches_reverse_audio_search"
    }
}

// MARK: - OrderConfirmationEmail
struct OrderConfirmationEmail: Codable {
    var accountProfileName, entContactSalesRepresentative, entEmailSentTo, entNotAnInvoice: String?
    var entOrderConfirmation, entOrderConfirmationEmailSubject, entOrderConfirmationEmailSubtotal, entPurchaseInformationKey: String?
    var entUsername, siteFooterCopyright, tosTos2020_09_04_PartV24_TableR2C2L1, tosTos2020_09_04_PartV24_TableR2C2L2: String?

    enum CodingKeys: String, CodingKey {
        case accountProfileName = "account:profile_name"
        case entContactSalesRepresentative = "ent:contact_sales_representative"
        case entEmailSentTo = "ent:email_sent_to"
        case entNotAnInvoice = "ent:not_an_invoice"
        case entOrderConfirmation = "ent:order_confirmation"
        case entOrderConfirmationEmailSubject = "ent:order_confirmation_email_subject"
        case entOrderConfirmationEmailSubtotal = "ent:order_confirmation_email_subtotal"
        case entPurchaseInformationKey = "ent:purchase_information_key"
        case entUsername = "ent:username"
        case siteFooterCopyright = "site-footer:copyright"
        case tosTos2020_09_04_PartV24_TableR2C2L1 = "tos:tos_2020_09_04_part_v_24_table_r2_c2_l1"
        case tosTos2020_09_04_PartV24_TableR2C2L2 = "tos:tos_2020_09_04_part_v_24_table_r2_c2_l2"
    }
}

// MARK: - Overlay
struct Overlay: Codable {
    var commonActionsAddToCard, commonActionsAddedToCart, commonActionsDownload, commonActionsPreview: String?
    var commonActionsSave, commonActionsSimilar, commonActionsTry, entComp: String?
    var entCompTipNoCredits, entTipNoAccessContent, imageLogoutAdpFreeTrialDownload: String?

    enum CodingKeys: String, CodingKey {
        case commonActionsAddToCard = "common:actions_add_to_card"
        case commonActionsAddedToCart = "common:actions_added_to_cart"
        case commonActionsDownload = "common:actions_download"
        case commonActionsPreview = "common:actions_preview"
        case commonActionsSave = "common:actions_save"
        case commonActionsSimilar = "common:actions_similar"
        case commonActionsTry = "common:actions_try"
        case entComp = "ent:comp"
        case entCompTipNoCredits = "ent:comp_tip_no_credits"
        case entTipNoAccessContent = "ent:tip_no_access_content"
        case imageLogoutAdpFreeTrialDownload = "image:logout_adp_free_trial_download"
    }
}

// MARK: - ZhPagination
struct ZhPagination: Codable {
    var commonActionsChangePage, commonActionsNext, commonActionsNextPage, commonActionsPrevPage: String?
    var commonFiltersPaginationLastPageText, entEditorialPaginationLastPageText, entPrevious: String?

    enum CodingKeys: String, CodingKey {
        case commonActionsChangePage = "common:actions_change_page"
        case commonActionsNext = "common:actions_next"
        case commonActionsNextPage = "common:actions_next_page"
        case commonActionsPrevPage = "common:actions_prev_page"
        case commonFiltersPaginationLastPageText = "common:filters_pagination_last-page-text"
        case entEditorialPaginationLastPageText = "ent:editorial_pagination_last-page-text"
        case entPrevious = "ent:previous"
    }
}

// MARK: - PriceFormatter
struct PriceFormatter: Codable {
    var compCredits, credit, credits, entUnavailable: String?
    var entUnlimited, licenseCredits: String?

    enum CodingKeys: String, CodingKey {
        case compCredits = "comp_credits"
        case credit, credits
        case entUnavailable = "ent:unavailable"
        case entUnlimited = "ent:unlimited"
        case licenseCredits = "license_credits"
    }
}

// MARK: - Search
struct Search: Codable {
    var imageSearchCrossContentLink, imageSearchIDSPageTitle, imageSearchIDSTitle, imageSearchIDSTitleCount: String?
    var imageSearchMetaDescription, imageSearchMetaDescriptionNoSearchTerm, imageSearchMetaTitleAllimages, imageSearchMetaTitleAllimagesNoSearchTerm: String?
    var imageSearchMetaTitleIllustrations, imageSearchMetaTitleIllustrationsNoSearchTerm, imageSearchMetaTitlePhotos, imageSearchMetaTitlePhotosNoSearchTerm: String?
    var imageSearchMetaTitleVectors, imageSearchMetaTitleVectorsNoSearchTerm, imageSearchSubtitleIllustrations, imageSearchSubtitleIllustrationsNoSearchTerm: String?
    var imageSearchSubtitleImage, imageSearchSubtitleImageNoSearchTerm, imageSearchSubtitlePhotos, imageSearchSubtitlePhotosNoSearchTerm: String?
    var imageSearchSubtitleVectors, imageSearchSubtitleVectorsNoSearchTerm, imageSearchTitleEditorial, imageSearchTitleEditorialNoSearchTerm: String?
    var imageSearchTitleIllustrations, imageSearchTitleIllustrationsNoSearchTerm, imageSearchTitleImage, imageSearchTitleImageNoSearchTerm: String?
    var imageSearchTitleMusic, imageSearchTitleMusicNoSearchTerm, imageSearchTitlePhotos, imageSearchTitlePhotosNoSearchTerm: String?
    var imageSearchTitleVectors, imageSearchTitleVectorsNoSearchTerm, imageSearchTitleVideo, imageSearchTitleVideoNoSearchTerm: String?
    var imageSEOTitleIllustration, imageSEOTitlePhoto, imageSEOTitleVector, searchFiltersLabel: String?

    enum CodingKeys: String, CodingKey {
        case imageSearchCrossContentLink = "image:search_cross_content_link"
        case imageSearchIDSPageTitle = "image:search_ids_page_title"
        case imageSearchIDSTitle = "image:search_ids_title"
        case imageSearchIDSTitleCount = "image:search_ids_title_count"
        case imageSearchMetaDescription = "image:search_meta_description"
        case imageSearchMetaDescriptionNoSearchTerm = "image:search_meta_description_no_search_term"
        case imageSearchMetaTitleAllimages = "image:search_meta_title_allimages"
        case imageSearchMetaTitleAllimagesNoSearchTerm = "image:search_meta_title_allimages_no_search_term"
        case imageSearchMetaTitleIllustrations = "image:search_meta_title_illustrations"
        case imageSearchMetaTitleIllustrationsNoSearchTerm = "image:search_meta_title_illustrations_no_search_term"
        case imageSearchMetaTitlePhotos = "image:search_meta_title_photos"
        case imageSearchMetaTitlePhotosNoSearchTerm = "image:search_meta_title_photos_no_search_term"
        case imageSearchMetaTitleVectors = "image:search_meta_title_vectors"
        case imageSearchMetaTitleVectorsNoSearchTerm = "image:search_meta_title_vectors_no_search_term"
        case imageSearchSubtitleIllustrations = "image:search_subtitle_illustrations"
        case imageSearchSubtitleIllustrationsNoSearchTerm = "image:search_subtitle_illustrations_no_search_term"
        case imageSearchSubtitleImage = "image:search_subtitle_image"
        case imageSearchSubtitleImageNoSearchTerm = "image:search_subtitle_image_no_search_term"
        case imageSearchSubtitlePhotos = "image:search_subtitle_photos"
        case imageSearchSubtitlePhotosNoSearchTerm = "image:search_subtitle_photos_no_search_term"
        case imageSearchSubtitleVectors = "image:search_subtitle_vectors"
        case imageSearchSubtitleVectorsNoSearchTerm = "image:search_subtitle_vectors_no_search_term"
        case imageSearchTitleEditorial = "image:search_title_editorial"
        case imageSearchTitleEditorialNoSearchTerm = "image:search_title_editorial_no_search_term"
        case imageSearchTitleIllustrations = "image:search_title_illustrations"
        case imageSearchTitleIllustrationsNoSearchTerm = "image:search_title_illustrations_no_search_term"
        case imageSearchTitleImage = "image:search_title_image"
        case imageSearchTitleImageNoSearchTerm = "image:search_title_image_no_search_term"
        case imageSearchTitleMusic = "image:search_title_music"
        case imageSearchTitleMusicNoSearchTerm = "image:search_title_music_no_search_term"
        case imageSearchTitlePhotos = "image:search_title_photos"
        case imageSearchTitlePhotosNoSearchTerm = "image:search_title_photos_no_search_term"
        case imageSearchTitleVectors = "image:search_title_vectors"
        case imageSearchTitleVectorsNoSearchTerm = "image:search_title_vectors_no_search_term"
        case imageSearchTitleVideo = "image:search_title_video"
        case imageSearchTitleVideoNoSearchTerm = "image:search_title_video_no_search_term"
        case imageSEOTitleIllustration = "image:seo_title_illustration"
        case imageSEOTitlePhoto = "image:seo_title_photo"
        case imageSEOTitleVector = "image:seo_title_vector"
        case searchFiltersLabel = "search:filters_label"
    }
}

// MARK: - SearchBar
struct SearchBar: Codable {
    var aiSearchTitle, commonActionsCancel, commonActionsClose, commonChooseFile: String?
    var commonFiltersImageTypeAll, commonFiltersImageTypeIllustration, commonFiltersImageTypePhoto, commonFiltersImageTypeVector: String?
    var commonImageSizeVector, commonLinksEditorial, commonLinksImage, commonLinksMusic: String?
    var commonLinksTemplates, entEditorialImage, entEditorialVideo, entSearchForEditorial: String?
    var imageReverseImageSearchPageTitle, licenseHistoryFilterButtonClosed, musicReverseAudioSearchPageTitle, searchErrorUnsupportedFileType: String?
    var searchRASSimilarAudios, searchRASDragAndDrop, searchRASDragAndDropVariant, searchRASLoadingHelpTextAudio: String?
    var searchRASSupportedHelpText, searchRisOr, searchRisSimilarImages, searchRisSimilarVideos: String?
    var searchRisDragAndDrop, searchRisDragAndDropVariant, searchRisDropAnywhere, searchRisErrorTextGeneric: String?
    var searchRisLoadingHelpText, searchRisLoadingHelpTextVideo, searchRisOrUpload, searchRisSupportedHelpText: String?
    var searchUploadingFile, siteHeaderSearchForAllImagesMobile, siteHeaderSearchForMusic, siteHeaderSearchForRecommendedImages: String?
    var siteHeaderSearchForSoundEffects, siteHeaderSearchForTemplates, siteHeaderSearchForVideos, siteHeaderSfx: String?
    var siteHeaderVideo: String?

    enum CodingKeys: String, CodingKey {
        case aiSearchTitle = "ai-search-title"
        case commonActionsCancel = "common:actions_cancel"
        case commonActionsClose = "common:actions_close"
        case commonChooseFile = "common:choose_file"
        case commonFiltersImageTypeAll = "common:filters_image_type_all"
        case commonFiltersImageTypeIllustration = "common:filters_image_type_illustration"
        case commonFiltersImageTypePhoto = "common:filters_image_type_photo"
        case commonFiltersImageTypeVector = "common:filters_image_type_vector"
        case commonImageSizeVector = "common:image_size_vector"
        case commonLinksEditorial = "common:links_editorial"
        case commonLinksImage = "common:links_image"
        case commonLinksMusic = "common:links_music"
        case commonLinksTemplates = "common:links_templates"
        case entEditorialImage = "ent:editorial_image"
        case entEditorialVideo = "ent:editorial_video"
        case entSearchForEditorial = "ent:search_for_editorial"
        case imageReverseImageSearchPageTitle = "image:reverse_image_search_page_title"
        case licenseHistoryFilterButtonClosed = "license-history:filter_button_closed"
        case musicReverseAudioSearchPageTitle = "music:reverse_audio_search_page_title"
        case searchErrorUnsupportedFileType = "search:error_unsupported_file_type"
        case searchRASSimilarAudios = "search:ras-similar-audios"
        case searchRASDragAndDrop = "search:ras_drag_and_drop"
        case searchRASDragAndDropVariant = "search:ras_drag_and_drop_variant"
        case searchRASLoadingHelpTextAudio = "search:ras_loading_help_text_audio"
        case searchRASSupportedHelpText = "search:ras_supported_help_text"
        case searchRisOr = "search:ris-or"
        case searchRisSimilarImages = "search:ris-similar-images"
        case searchRisSimilarVideos = "search:ris-similar-videos"
        case searchRisDragAndDrop = "search:ris_drag_and_drop"
        case searchRisDragAndDropVariant = "search:ris_drag_and_drop_variant"
        case searchRisDropAnywhere = "search:ris_drop_anywhere"
        case searchRisErrorTextGeneric = "search:ris_error_text_generic"
        case searchRisLoadingHelpText = "search:ris_loading_help_text"
        case searchRisLoadingHelpTextVideo = "search:ris_loading_help_text_video"
        case searchRisOrUpload = "search:ris_or_upload"
        case searchRisSupportedHelpText = "search:ris_supported_help_text"
        case searchUploadingFile = "search:uploading_file"
        case siteHeaderSearchForAllImagesMobile = "site-header:search_for_all_images_mobile"
        case siteHeaderSearchForMusic = "site-header:search_for_music"
        case siteHeaderSearchForRecommendedImages = "site-header:search_for_recommended_images"
        case siteHeaderSearchForSoundEffects = "site-header:search_for_sound_effects"
        case siteHeaderSearchForTemplates = "site-header:search_for_templates"
        case siteHeaderSearchForVideos = "site-header:search_for_videos"
        case siteHeaderSfx = "site-header:sfx"
        case siteHeaderVideo = "site-header:video"
    }
}

// MARK: - SearchIconButton
struct SearchIconButton: Codable {
    var commonActionsSearch: String?

    enum CodingKeys: String, CodingKey {
        case commonActionsSearch = "common:actions_search"
    }
}

// MARK: - VectorFormatTypeSelect
struct VectorFormatTypeSelect: Codable {
    var commonImageSizeVector, entSelectFormatTypeHeader: String?

    enum CodingKeys: String, CodingKey {
        case commonImageSizeVector = "common:image_size_vector"
        case entSelectFormatTypeHeader = "ent:select_format_type_header"
    }
}

// MARK: - VideoLicenseTypeSelect
struct VideoLicenseTypeSelect: Codable {
    var entMediaLicenseType, entMediaSelectLicenseType, entMediaSmLicenseType, entPlatformLicenseType: String?
    var entPremierLicenseType, entPremierSelectLicenseType, entPremierSmLicenseType, entSelectLicenseTypeHeader: String?

    enum CodingKeys: String, CodingKey {
        case entMediaLicenseType = "ent:media_license_type"
        case entMediaSelectLicenseType = "ent:media_select_license_type"
        case entMediaSmLicenseType = "ent:media_sm_license_type"
        case entPlatformLicenseType = "ent:platform_license_type"
        case entPremierLicenseType = "ent:premier_license_type"
        case entPremierSelectLicenseType = "ent:premier_select_license_type"
        case entPremierSmLicenseType = "ent:premier_sm_license_type"
        case entSelectLicenseTypeHeader = "ent:select_license_type_header"
    }
}

// MARK: - QueryClass
struct QueryClass: Codable {
    var imageType: ImageType?
    var page: String?
    var term: QueryEnum?

    enum CodingKeys: String, CodingKey {
        case imageType = "image_type"
        case page, term
    }
}

// MARK: - ServerRegionProps
struct ServerRegionProps: Codable {
    var region: String?
    var currencyData: CurrencyData?
}

// MARK: - CurrencyData
struct CurrencyData: Codable {
    var currency, isoCode, translationTag, name: String?

    enum CodingKeys: String, CodingKey {
        case currency
        case isoCode = "iso_code"
        case translationTag = "translation_tag"
        case name
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
