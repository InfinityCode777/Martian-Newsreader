//
//  ViewController.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/7/22.
//

import UIKit

class NewsListVC: UIViewController, LoadingViewAttaching {
    @IBOutlet var tableView: UITableView!
    var presenter: NewsListPresenter!
    private var adapter: NewsListAdapter!
    private var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView = attachLoadingView()
        adapter = NewsListAdapter(presenter: presenter)
        setupTableView()
        addLangBtn()
        loadingView.show()
        presenter.eventViewReady()
    }
    
    override func awakeFromNib() {
        self.presenter = NewsListPresenter()
        self.presenter.output = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        presenter.eventViewReady()
    }
    
    private func setupTableView() {
        tableView.delegate = adapter
        tableView.dataSource = adapter
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func addLangBtn() {
        let rightNavbBarBtn = UIBarButtonItem(title: "Martian",
                                              style: .plain,
                                              target: self,
                                              action: #selector(eventLangBtnTapped))
        navigationItem.rightBarButtonItem = rightNavbBarBtn
    }
    
    @objc
    private func eventLangBtnTapped() {
        loadingView.show()
        presenter.eventLangBtnTapped()
//        _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self]
//             timer in
//            self?.loadingView.dismiss()
//        }
    }
    
}

extension NewsListVC: NewsListPresenterOutput {
    func showDetail(news: NewsViewModel) {
        let newsDetailVC = Coordinator.getNewsDetailVC()
        newsDetailVC.news = news
        navigationController?.pushViewController(newsDetailVC, animated: true)
    }
    
    func show(newsList: [NewsViewModel]) {
        adapter.newsList = newsList
        DispatchQueue.main.async { [ weak self] in
            //            self?.spinnerView.stopAnimating()
            self?.tableView.reloadData()
            self?.loadingView.dismiss()
        }
    }
    
    func showError(error: LocalizedError) {
        print("Error: \(error.localizedDescription)")
    }
}

