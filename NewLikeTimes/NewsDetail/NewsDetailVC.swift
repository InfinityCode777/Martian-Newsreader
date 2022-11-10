//
//  NewsDetailVC.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/7/22.
//

import UIKit

class NewsDetailVC: UIViewController {
    var news: NewsViewModel!
    var presenter: NewsDetailPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func awakeFromNib() {
        self.presenter = NewsDetailPresenter()
        self.presenter.output = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.eventViewReady()
    }
}

extension NewsDetailVC: NewsDetailPresenterOutput {
    func showNewsDetail() {
//    func show(newsDetail: NewsViewModel) {
        print("ahaha >>> Title >>> \(news.title)")
    }
}
