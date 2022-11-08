//
//  ViewController.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/7/22.
//

import UIKit

class NewsListVC: UIViewController {
    
    var presenter: NewsListPresenter!
    private var adapter: NewsListAdapter!


    override func viewDidLoad() {
        super.viewDidLoad()
        adapter = NewsListAdapter()
    }

    override func awakeFromNib() {
        self.presenter = NewsListPresenter()
        self.presenter.output = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        presenter.eventLoadNewsList()
    }

}

extension NewsListVC: NewsListPresenterOutput {
    func show(newsList: [NewsViewModel]) {
        
    }
}

