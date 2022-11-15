//
//  AppState.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/14/22.
//

import Foundation

class AppState {
    static var shared = AppState()
    private init() {}
    var selectedIdx: Int? {
        didSet {
            selectedDomainData = domainDataList[selectedIdx!]
        }
    }
    var domainDataList = [NewsDomainModel]()
    var selectedDomainData: NewsDomainModel?
}
