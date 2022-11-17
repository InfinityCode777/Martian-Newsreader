//
//  NewsDomainModel.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/8/22.
//

import UIKit

struct NewsDomainModel: Codable {
    var title: String
    var body: String
    var images: [newsImageBundle]
    var lang: String?
}

struct newsImageBundle: Codable {
    var topImage: Bool
    var url: URL
    var width: CGFloat
    var height: CGFloat
}
