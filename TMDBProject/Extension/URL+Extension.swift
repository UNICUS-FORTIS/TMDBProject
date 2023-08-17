//
//  File.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/12.
//

import Foundation


extension URL {
    static let popularURL = "https://api.themoviedb.org/3/movie/popular?"
    static let nowPlayingURL = "https://api.themoviedb.org/3/movie/now_playing?"
    static let topRatedURL = "https://api.themoviedb.org/3/movie/top_rated?"
    static let upcommingURL = "https://api.themoviedb.org/3/movie/upcoming?"
    
    static func createRecommendationURL(for id: Int, key: String) -> URL? {
        let urlString = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(key)&language=ko-KR"
        
        return URL(string: urlString)
    }
    static func createRecommandationIMG(for path: String) -> URL? {
        let urlString =
        "https://image.tmdb.org/t/p/original\(path)"
        
        return URL(string: urlString)
    }
}

