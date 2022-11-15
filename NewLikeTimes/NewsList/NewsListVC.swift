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
    private var rightNavBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView = attachLoadingView()
        adapter = NewsListAdapter(presenter: presenter)
        setupNavBar()
        setupTableView()
//        addLangBtn()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Martian",
                                              style: .plain,
                                              target: self,
                                              action: #selector(eventToggleLang))
        self.rightNavBtn = navigationItem.rightBarButtonItem
    }
    
    @objc
    private func eventToggleLang() {
        loadingView.show()
        rightNavBtn.isEnabled = false
        presenter.eventToggleLang()
    }
    
    private func setupNavBar() {
        navigationItem.title = "For You"
        addLangBtn()
    }
    
}

extension NewsListVC: NewsListPresenterOutput {
    func showNewsDetailPage() {
        let newsDetailVC = Coordinator.getNewsDetailVC()
        navigationController?.pushViewController(newsDetailVC, animated: true)
    }
    
    func showNewsListPage(_ newsPage: NewsListPageViewModel) {
        adapter.newsList = newsPage.newsEntryList
        DispatchQueue.main.async { [ weak self] in
            self?.tableView.reloadData()
            self?.navigationItem.rightBarButtonItem?.title = newsPage.langBtnTitle
            self?.loadingView.dismiss()
            self?.rightNavBtn.isEnabled = true
        }
    }
    
    func showError(_ error: LocalizedError) {
        print("Error: \(error.localizedDescription)")
    }
}

