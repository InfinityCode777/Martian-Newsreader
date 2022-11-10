//
//  ViewController.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/7/22.
//

import UIKit

class NewsListVC: UIViewController {
    @IBOutlet var tableView: UITableView!
    var presenter: NewsListPresenter!
    private var adapter: NewsListAdapter!

    override func viewDidLoad() {
        super.viewDidLoad()
        adapter = NewsListAdapter()
        tableView.delegate = adapter
        tableView.dataSource = adapter
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
        adapter.newsList = newsList
        DispatchQueue.main.async { [ weak self] in
//            self?.spinnerView.stopAnimating()
            self?.tableView.reloadData()
        }
    }
}

