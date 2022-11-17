//
//  NewsListPageViewModel.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/14/22.
//

import UIKit

struct NewsListPageViewModel {
    var newsEntryList: [NewsEntryViewModel]
    var langBtnTitle: String
    
    init(newEntryList: [NewsEntryViewModel],
         langBtnTitle: String) {
        self.newsEntryList = newEntryList
        self.langBtnTitle = langBtnTitle
    }
    
    init() {
        self.init(newEntryList: [], langBtnTitle: "N/A")
    }
    
    static func createPageViewModel(domainDataList: [NewsDomainModel],
                                    langBtnTitle: String) -> NewsListPageViewModel {
        var newsListPage = NewsListPageViewModel()
        newsListPage.langBtnTitle = langBtnTitle
        var newsEntryList = [NewsEntryViewModel]()
        
        for domainData in domainDataList {
            let newsEntry = createEntryViewModel(domainData)
            //            newsListPage.newsEntryList.append(newsEntry)
            newsEntryList.append(newsEntry)
        }
        
        newsListPage.newsEntryList = newsEntryList
        
        return newsListPage
    }
    
    static func createEntryViewModel(_ domainData: NewsDomainModel) -> NewsEntryViewModel {
        // Get the first topImage and use it for both thumbnail and top image
        var topImage: UIImage?
        for imageBundle in domainData.images {
            if imageBundle.topImage {
                topImage = UIImage(url: imageBundle.url)
                break
            }
        }
        
        let entryData = NewsEntryViewModel(title: domainData.title,
                                           body: domainData.body,
                                           image: topImage ?? UIImage())
        return entryData
    }
}
