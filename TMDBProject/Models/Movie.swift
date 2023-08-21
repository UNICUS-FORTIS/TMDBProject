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
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
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
    case tv = "tv"
}
// MARK: - TV Trending

struct TVData: Codable {
    let page: Int
    let results: [TV]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TV: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let name: String
    let originalLanguage: String
    let originalName, overview, posterPath: String
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let firstAirDate: String
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [String]
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
    }
}


// MARK: - TV TopRated

struct TopRatedData: Codable {
    let page: Int
    let results: [TVTopRated]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TVTopRated: Codable {
    let backdropPath, firstAirDate: String
    let genreIDS: [Int]
    let id: Int
    let name: String
    let originCountry: [String]
    let originalLanguage: String
    let originalName, overview: String
    let popularity: Double
    let posterPath: String
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - TV Popular
struct PopularTVData: Codable {
    let page: Int
    let results: [PopularTV]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct PopularTV: Codable {
    let backdropPath: String?
    let firstAirDate: String
    let genreIDS: [Int]
    let id: Int
    let name: String
    let originCountry: [OriginCountry]
    let originalLanguage: OriginalLanguage
    let originalName, overview: String
    let popularity: Double
    let posterPath: String?
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginCountry: String, Codable {
    case de = "DE"
    case fr = "FR"
    case originCountryIN = "IN"
    case us = "US"
}

enum OriginalLanguage: String, Codable {
    case de = "de"
    case en = "en"
    case fr = "fr"
    case hi = "hi"
}
