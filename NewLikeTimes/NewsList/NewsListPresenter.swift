//
//  NewsListPresenter.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/8/22.
//

import UIKit

class NewsListPresenter {
    weak var output: NewsListPresenterOutput!
    var appState: AppState
    
    init(appState: AppState = .shared) {
        self.appState = appState
    }
    
    func eventLoadNewsList(refreshData: Bool = false,
                           lang: SupportLanguage = .en) {
        NewsManager.shared.loadAll(filename: "news_data",
                                   lang: lang,
                                   refreshData: refreshData) {[weak self] result in
            guard
                let self = self
            else {
                fatalError("Failed to self in a guard closure")
            }
            
            switch result {
            case .success(let domainData):
                self.appState.domainDataList = domainData
                let newsList = NewsViewModel.createViewModelList(domainData)
                self.output.showNewsList(newsList)
            case .failure(let error):
                self.output.showError(error)
                break
            }
        }
    }
    
    func eventViewReady() {
        eventLoadNewsList(refreshData: true)
    }
    
    func eventItemSelected(selectedIdx: Int) {
        appState.selectedIdx = selectedIdx
        output.showNewsDetailPage()
    }
    
    func eventLangBtnTapped() {
        eventLoadNewsList(refreshData: true, lang: .mr)
    }
}
