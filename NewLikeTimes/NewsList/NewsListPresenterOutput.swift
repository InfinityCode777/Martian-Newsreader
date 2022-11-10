//
//  NewsListPresenterOutput.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/8/22.
//

import Foundation

protocol NewsListPresenterOutput: AnyObject {
    func show(newsList: [NewsViewModel])
}