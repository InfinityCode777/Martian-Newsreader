//
//  NewsDetailPresenter.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/10/22.
//

import Foundation

class NewsDetailPresenter {
    weak var output: NewsDetailPresenterOutput!
    
    func eventLoadDetailedNews() {
        output.showNewsDetail()
    }

    func eventViewReady() {
        eventLoadDetailedNews()
    }
}
