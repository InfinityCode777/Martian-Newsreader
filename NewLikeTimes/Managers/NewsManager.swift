//
//  NewsManager.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/8/22.
//

import Foundation

class NewsManager {
    private init() {}
    
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


