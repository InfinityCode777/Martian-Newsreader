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
    var images: [newImageBundle]
}

struct newImageBundle: Codable {
    var topImage: Bool
    var url: URL
    var width: CGFloat
    var height: CGFloat
}
