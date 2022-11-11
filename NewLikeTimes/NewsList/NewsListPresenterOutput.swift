//
//  NewsListPresenterOutput.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/8/22.
//

import Foundation

protocol NewsListPresenterOutput: AnyObject {
    func show(newsList: [NewsViewModel])
    func showError(error: LocalizedError)

    // Navigation, should be in router, simplified and put it here for now
    func showDetail(news: NewsViewModel)
    
}
