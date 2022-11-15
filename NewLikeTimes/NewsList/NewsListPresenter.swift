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
    
//    func eventLoadNewsListPage(refreshData: Bool = false,
//                               lang: SupportLanguage = appState.lang) {
    func eventLoadNewsListPage(refreshData: Bool = false) {
        
        NewsManager.shared.loadAll(refreshData: refreshData,
                                   lang: appState.lang) {[weak self] result in
            guard
                let self = self
            else {
                fatalError("Failed to self in a guard closure")
            }
            
            let displayLang: SupportLanguage = self.appState.lang == .en ? .mr : .en
            
            switch result {
            case .success(let domainDataList):
                self.appState.domainDataList = domainDataList
                let newsListPage = NewsListPageViewModel.createPageViewModel(domainDataList: domainDataList, langBtnTitle: displayLang.description)
                self.output.showNewsListPage(newsListPage)
            case .failure(let error):
                self.output.showError(error)
                break
            }
        }
    }
    
    func eventViewReady() {
//        eventLoadNewsListPage(refreshData: true, lang: appState.lang)
        eventLoadNewsListPage(refreshData: true)
    }
    
    func eventItemSelected(selectedIdx: Int) {
        appState.selectedIdx = selectedIdx
        output.showNewsDetailPage()
    }
    
    func eventToggleLang() {
        appState.lang = appState.lang == .en ? .mr : .en
        eventViewReady()
    }
}
