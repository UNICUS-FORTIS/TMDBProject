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

// MARK: - MyCodable
struct MovieData: Codable {
    let page: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page, results
    }
}

// MARK: - Result
struct Movie: Codable {
    let backdropPath: String
    let overview: String
    let posterPath, releaseDate, title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
