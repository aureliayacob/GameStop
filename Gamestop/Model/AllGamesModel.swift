//
//  AllGamesModel.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 30/09/22.
//

import Foundation

// MARK: - AllGame
struct AllGames: Codable {
    let count: Int?
    let next: String?
    let results: [Result]?
    let seoTitle, seoDescription, seoKeywords, seoH1: String?
    let noindex, nofollow: Bool?
    let allGameDescription: String?
    let filters: Filters?
    let nofollowCollections: [String]?

    enum CodingKeys: String, CodingKey {
        case count, next,  results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow
        case allGameDescription = "description"
        case filters
        case nofollowCollections = "nofollow_collections"
    }
}

// MARK: - Filters
struct Filters: Codable {
    let years: [FiltersYear]?
}

// MARK: - FiltersYear
struct FiltersYear: Codable {
    let from, to: Int?
    let filter: String?
    let decade: Int?
    let years: [YearYear]?
    let nofollow: Bool?
    let count: Int?
}

// MARK: - YearYear
struct YearYear: Codable {
    let year, count: Int?
    let nofollow: Bool?
}

// MARK: - Result
struct Result: Codable {
    init(id: Int, slig: String, name: String, released: String, genre: [Genre], rating: Double, ratingTop: Int, ratings: [Rating], ratingsCount: Int, backgroundImage: String){
        self.id = id
        self.slug = slig
        self.name = name
        self.released = released
        self.rating = rating
        self.ratingTop = ratingTop
        self.ratings = ratings
        self.ratingsCount = ratingsCount
        self.backgroundImage = backgroundImage
        self.tba = nil
        self.reviewsTextCount = 0
        self.added = 0
        self.metacritic = 0
        self.playtime = 0
        self.suggestionsCount = 0
        self.updated = nil
        self.userGame = nil
        self.reviewsCount = 0
        self.saturatedColor = nil
        self.dominantColor = nil
        self.platforms = []
        self.parentPlatforms = []
        self.genres = genre
        self.stores = []
        self.clip = nil
        self.tags = []
        self.esrbRating = nil
        self.shortScreenshots = []
    }
    
    let id: Int?
    let slug, name, released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [Rating]?
    let ratingsCount, reviewsTextCount, added: Int?
    let metacritic, playtime, suggestionsCount: Int?
    let updated: String?
    let userGame: JSONNull?
    let reviewsCount: Int?
    let saturatedColor, dominantColor: ColorGame?
    let platforms: [PlatformElement]?
    let parentPlatforms: [ParentPlatform]?
    let genres: [Genre]?
    let stores: [Store]?
    let clip: JSONNull?
    let tags: [Genre]?
    let esrbRating: EsrbRating?
    let shortScreenshots: [ShortScreenshot]?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case platforms
        case parentPlatforms = "parent_platforms"
        case genres, stores, clip, tags
        case esrbRating = "esrb_rating"
        case shortScreenshots = "short_screenshots"
    }
}

enum ColorGame: String, Codable {
    case the0F0F0F = "0f0f0f"
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    let id: Int?
    let name, slug: String?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let domain: Domain?
    let language: Language?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}

enum Domain: String, Codable {
    case appsAppleCOM = "apps.apple.com"
    case epicgamesCOM = "epicgames.com"
    case gogCOM = "gog.com"
    case marketplaceXboxCOM = "marketplace.xbox.com"
    case microsoftCOM = "microsoft.com"
    case nintendoCOM = "nintendo.com"
    case playGoogleCOM = "play.google.com"
    case storePlaystationCOM = "store.playstation.com"
    case storeSteampoweredCOM = "store.steampowered.com"
}

enum Language: String, Codable {
    case eng = "eng"
}

// MARK: - ParentPlatform
struct ParentPlatform: Codable {
    let platform: EsrbRating?
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    let platform: PlatformPlatform?
    let releasedAt: String?
    let requirementsEn, requirementsRu: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    let id: Int
    let name, slug: String?
    let image, yearEnd: JSONNull?
    let yearStart: Int?
    let gamesCount: Int?
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - Requirements
struct Requirements: Codable {
    let minimum: String?
    let recommended: String?
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int
    let title: Title?
    let count: Int?
    let percent: Double?
}

enum Title: String, Codable {
    case exceptional = "exceptional"
    case meh = "meh"
    case recommended = "recommended"
    case skip = "skip"
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int
    let image: String?
}

// MARK: - Store
struct Store: Codable {
    let id: Int
    let store: Genre?
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
