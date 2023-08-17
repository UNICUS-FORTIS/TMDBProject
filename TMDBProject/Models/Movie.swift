//
//  Movie.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/12.
//

import Foundation

//struct Movie: Codable {
//    let title: String
//    let rate: Double
//    let poster: String
//    let backdrop: String
//    let released: String
//    let overview: String
//}

// MARK: - MovieData Struct
struct MovieData: Codable {
    let page: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page, results
    }
}

struct Movie: Codable {
    let backdropPath: String
    let overview: String
    let id: Int
    let posterPath, releaseDate, title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case overview
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}

// MARK: - RecommandData Struct
struct RecommandData: Codable {
    let totalPages, page, totalResults: Int
    let results: [Recommand]

    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case page
        case totalResults = "total_results"
        case results
    }
}

struct Recommand: Codable {
    let title: String
    let backdropPath: String?
    let originalTitle: String
    let posterPath: String?
    let mediaType: MediaType
    let releaseDate: String
    let video: Bool
    let id: Int
    let voteAverage: Double
    let genreIDS: [Int]
    let adult: Bool
    let overview: String
    // 없는 언어 존재해서 타입을 OriginalLanguage -> String 으로 변경
    let originalLanguage: String

    enum CodingKeys: String, CodingKey {
        case title
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case releaseDate = "release_date"
        case video, id
        case voteAverage = "vote_average"
        case genreIDS = "genre_ids"
        case adult, overview
        case originalLanguage = "original_language"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case fr = "fr"
//    case ja = "ja"
//}
