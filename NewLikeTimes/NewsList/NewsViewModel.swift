//
//  NewsListViewModel.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/8/22.
//

import Foundation
import UIKit

struct NewsViewModel {
    var title: String
    var body: String
    var image: UIImage
    var lang: SupportLanguage
    
    static func createViewModelList(_ domainDataList: [NewsDomainModel]) -> [NewsViewModel] {
        var newsList = [NewsViewModel]()
        
        for domainData in domainDataList {
            let viewData = createViewModel(domainData)
            newsList.append(viewData)
        }
        
        return newsList
    }
    
    static func createViewModel(_ domainData: NewsDomainModel) -> NewsViewModel {
        // Get the first topImage and use it for both thumbnail and top image
        var topImage: UIImage?
        for imageBundle in domainData.images {
            if imageBundle.topImage {
                topImage = UIImage(url: imageBundle.url)
                break
            }
        }
        
        let viewData = NewsViewModel(title: domainData.title,
                                     body: domainData.body,
                                     image: topImage ?? UIImage(),
                                     lang: .en)
        return viewData
    }
    
}
