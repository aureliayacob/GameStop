//
//  SearchResultModel.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 05/10/22.

import Foundation

// MARK: - SearchResultRoot
struct SearchResultRoot: Codable {
    let count: Int
    let results: [SearchResultItem]

    enum CodingKeys: String, CodingKey {
        case count, results
    }
}

// MARK: - SearchResultItem
struct SearchResultItem: Codable {
    let id: Int?
    let slug, name, released: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [Rating]?
    let ratingsCount: Int?
    let genres: [Genre]?
    enum CodingKeys: String, CodingKey {
        case id, slug, name, released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case genres
    }
}

enum Name: String, Codable {
    case adultsOnly = "Adults Only"
    case mature = "Mature"
}

enum NameRu: String, Codable {
    case с17Лет = "С 17 лет"
    case толькоДляВзрослых = "Только для взрослых"
}

enum Slug: String, Codable {
    case adultsOnly = "adults-only"
    case mature = "mature"
}
