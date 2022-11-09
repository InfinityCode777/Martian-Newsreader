//
//  NewsListCell.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/8/22.
//

import UIKit

class NewsListCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var thumbnailImgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
