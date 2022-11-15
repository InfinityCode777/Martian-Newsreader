//
//  NewsDetailPresenter.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/10/22.
//

import UIKit

class NewsDetailPresenter {
    weak var output: NewsDetailPresenterOutput!
    var appState: AppState
    
    init(appState: AppState = .shared) {
        self.appState = appState
    }

    func eventLoadNewsDetail() {
        guard
            let domainData = appState.selectedDomainData
        else {
            return
        }
        
        let news = NewsViewModel.createViewModel(domainData)
        output.showNewsDetail(news)
    }
    
    func eventViewReady() {
        eventLoadNewsDetail()
    }
}
