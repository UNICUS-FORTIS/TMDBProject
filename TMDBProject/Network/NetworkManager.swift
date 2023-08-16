//
//  NetworkManager.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/12.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    let myHeader: HTTPHeaders = [
        Headers.authorization,
        Headers.accept
    ]
    
    
    public func fetchData(type: Endpoint, completion: @escaping (MovieData)-> Void ) {
        
        let url = type.requestURL+"language=ko-KR?page=1"
        print(url)
        
        AF.request(url, method: .get, headers: myHeader).validate().responseDecodable(of: MovieData.self) { response in
            
            guard let value = response.value else { return }
            completion(value)
        }
    }
}
