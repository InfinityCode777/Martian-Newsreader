//
//  NewsListCell.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/8/22.
//

import UIKit

class NewsListCell: UITableViewCell {
    override var reuseIdentifier: String? {
        return "\(NewsListCell.self)"
    }
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
}

