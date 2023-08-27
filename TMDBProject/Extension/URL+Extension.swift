//
//  File.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/12.
//

import Foundation


extension URL {
    static let popularURL = "https://api.themoviedb.org/3/movie/popular?language=ko-KR?page=1"
    static let nowPlayingURL = "https://api.themoviedb.org/3/movie/now_playing?language=ko-KR?page=1"
    static let topRatedURL = "https://api.themoviedb.org/3/movie/top_rated?language=ko-KR?page=1"
    static let upcommingURL = "https://api.themoviedb.org/3/movie/upcoming?language=ko-KR?page=1"
    static let trendingTVURL = "https://api.themoviedb.org/3/trending/tv/"
    
    static let popularTVURL = "https://api.themoviedb.org/3/tv/popular?language=ko-KR&page=1"
    
    static let topratedTVURL = "https://api.themoviedb.org/3/tv/top_rated?language=ko-KR&page=1"
    
    static func createRecommendationURL(for id: Int, key: String) -> URL? {
        let urlString = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(key)&language=ko-KR"
        
        return URL(string: urlString)
    }
    
    static func getMovieImage(for path: String) -> URL? {
        let urlString =
        "https://image.tmdb.org/t/p/original\(path)"
        
        return URL(string: urlString)
    }
    
    static func createTredingTVURL(for term: String) -> String {
        let tvURLString = Self.trendingTVURL+"\(term)?language=ko-KR"

        return tvURLString
    }
    
}

