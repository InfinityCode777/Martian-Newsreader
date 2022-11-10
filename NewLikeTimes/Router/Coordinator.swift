//
//  Coordinator.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/10/22.
//

import UIKit

class Coordinator {
    static func getNewsListVC() -> NewsListVC {
        let sb = UIStoryboard(name: "NewsList", bundle: .main)
        guard
            let vc = sb.instantiateViewController(withIdentifier: "\(NewsListVC.self)") as? NewsListVC
        else {
            fatalError()
        }
        
        return vc
    }
    
    static func getNewsDetailVC() -> NewsDetailVC {
        let sb = UIStoryboard(name: "NewsDetail", bundle: .main)
        guard
            let vc = sb.instantiateViewController(withIdentifier: "\(NewsDetailVC.self)") as? NewsDetailVC
        else {
            fatalError()
        }
        
        return vc
    }
}
