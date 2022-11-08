//
//  NewsListAdapter.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/8/22.
//

//import Foundation
import UIKit

class NewsListAdapter: NSObject {
    var newsList: [NewsViewModel]
    
    init(newsList: [NewsViewModel]) {
        self.newsList = newsList
    }
    
    convenience override init() {
        self.init(newsList: [])
//        self.newsList = [NewsViewModel]()
    }

}

extension NewsListAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(NewsListCell.self)") as! NewsListCell
        let row = indexPath.row
        cell.titleLabel.text = newsList[row].title
        cell.bodyLabel.text = newsList[row].body
        cell.thumbnailImageView.image = UIImage(named: "")

        return UITableViewCell()
    }
}
