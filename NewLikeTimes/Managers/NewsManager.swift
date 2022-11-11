//
//  NewsManager.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/8/22.
//

import Foundation

class NewsManager {
    private init() {}
    
    public static let shared = NewsManager()
        
    func loadAll(filename fileName: String,
                 bundle: Bundle = .main,
                 completion: @escaping (Result<[NewsDomainModel], DataFetchError>) -> ()){
        guard
            let url = bundle.url(forResource: fileName, withExtension: "json")
        else {
            completion(.failure(.failedToLocateFile))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let jsonData = try decoder.decode([NewsDomainModel].self, from: data)
            
            completion(.success(jsonData))
        } catch {
            print("error:\(error)")
            completion(.failure(.failedToDecodeJson))
        }
    }
}
