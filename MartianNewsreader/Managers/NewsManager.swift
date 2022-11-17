//
//  NewsManager.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/8/22.
//

import Foundation

class NewsManager {
    private init() {}
    
    private static var BASE_URL_STR: String { return "https://s1.nyt.com/ios-newsreader/candidates/test/articles.json" }
    
    public private(set) var model = [NewsDomainModel]()
    
    public static let shared = NewsManager()
    
    private let dataAccessQ = DispatchQueue(label: "com.newLikeTimes.dataAccessQ", qos: .userInitiated)
        
    func loadAll(filename fileName: String,
                 refreshData: Bool = false,
                 lang: SupportLanguage = .en,
                 bundle: Bundle = .main,
                 completion: @escaping (Result<[NewsDomainModel], DataFetchError>) -> ()){
        
        if !refreshData {
            if model.isEmpty {
                completion(.failure(.emptyModel))
            } else {
                completion(.success(model))
            }
            return
        }
        
        guard
            let url = bundle.url(forResource: fileName, withExtension: "json")
        else {
            completion(.failure(.failedToLocateFile))
            return
        }
        
        dataAccessQ.async { [weak self] in
            guard let self = self else { fatalError("Failed to get instance of \(NewsManager.self)")}
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                var jsonData = try decoder.decode([NewsDomainModel].self, from: data)
                
                // Simulate that we can get info from backend
                for idx in 0..<jsonData.count {
                    jsonData[idx].lang = lang.rawValue
                }
                
                if (lang != .en) {
                    let tranlatedJsonData = self.translateDomainModel(jsonData, to: lang)
                    self.model = tranlatedJsonData
                    completion(.success(tranlatedJsonData))
                } else {
                    self.model = jsonData
                    completion(.success(jsonData))
                }
            } catch {
                print("error:\(error)")
                completion(.failure(.failedToDecodeJson))
            }
        }
    }
    
    func loadAll(urlStr: String = NewsManager.BASE_URL_STR,
                 refreshData: Bool = false,
                 lang: SupportLanguage = .en,
                 completion: @escaping (Result<[NewsDomainModel], DataFetchError>) -> ()) {
        guard
            let url = URL(string: urlStr)
        else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let session = URLSession(configuration: .default,
                                 delegate: nil,
                                 delegateQueue: nil)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) {[weak self] (data, response, error ) in
            guard let self = self else {
                fatalError("Failed to get instance of \(NewsManager.self)")
            }
            
            self.dataAccessQ.async {
                guard
                    error == nil
                else {
                    completion(.failure(.genericError(error)))
                    return
                }
                
                guard
                    let response = response as? HTTPURLResponse
                else {
                    completion(.failure(.invalidUrlResponse))
                    return
                }
                
                guard
                    response.statusCode == 200
                else {
                    completion(.failure(.statusCodeNot200))
                    return
                }
                
                guard
                    let data = data
                else {
                    completion(.failure(.invalidData))
                    return
                }

                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    var jsonData = try decoder.decode([NewsDomainModel].self, from: data)
                    
                    // Simulate that we can get info from backend
                    for idx in 0..<jsonData.count {
                        jsonData[idx].lang = lang.rawValue
                    }
                    
                    if (lang != .en) {
                        let tranlatedJsonData = self.translateDomainModel(jsonData, to: lang)
                        self.model = tranlatedJsonData
                        completion(.success(tranlatedJsonData))
                    } else {
                        self.model = jsonData
                        completion(.success(jsonData))
                    }
                } catch {
                    print("error:\(error)")
                    completion(.failure(.failedToDecodeJson))
                }
                
            }
            
        }
        task.resume()
    }
    
    private func translateDomainModel(_ model: [NewsDomainModel],
                                      to lang: SupportLanguage) -> [NewsDomainModel] {
        var res = [NewsDomainModel]()
        
        for news in model {
            let translatedTitle = TextTranslator.shared.getTranslation(news.title,
                                                                       fromLang: .en,
                                                                    toLang: lang)
            let translatedBody = TextTranslator.shared.getTranslation(news.body,
                                                                      fromLang: .en,
                                                          toLang: lang)
            
            let translation = NewsDomainModel(title: translatedTitle,
                                              body: translatedBody,
                                              images: news.images)
            res.append(translation)
        }
        
        return res
    }
}


