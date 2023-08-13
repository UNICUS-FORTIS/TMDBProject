//
//  NetworkManager.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/12.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    let myHeader: HTTPHeaders = [
        Headers.authorization,
        Headers.accept
    ]
    
    func fetchData(type: Endpoint, completion: @escaping(JSON)-> Void ) {
        
        let url = type.requestURL+"language=ko-KR?page=1"
        print(url)
        
        AF.request(url, method: .get, headers: myHeader).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                completion(json)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
