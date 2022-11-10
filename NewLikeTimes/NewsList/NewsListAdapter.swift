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
    var presenter: NewsListPresenter
    
    init(newsList: [NewsViewModel], presenter: NewsListPresenter) {
        self.newsList = newsList
        self.presenter = presenter
    }
    
    convenience init(presenter: NewsListPresenter) {
        self.init(newsList: [], presenter: presenter)
    }

}

extension NewsListAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(NewsListCell.self)",
                                                 for: indexPath) as! NewsListCell
        let row = indexPath.row
        cell.titleLabel.text = newsList[row].title
        cell.bodyLabel.text = newsList[row].body
        cell.thumbnailImageView.image = newsList[row].image

        return cell
    }
}

extension NewsListAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.eventItemSelected(news: newsList[indexPath.row])
    }
}
