//
//  ViewController.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/7/22.
//

import UIKit

class NewsListVC: UIViewController, LoadingViewAttaching, RefreshControlAttaching {
    @IBOutlet var tableView: UITableView!
    var presenter: NewsListPresenter!
    private var adapter: NewsListAdapter!
    private var loadingView: LoadingView!
    private var refreshControl: UIRefreshControl!
    private var rightNavBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView = attachLoadingView()
        adapter = NewsListAdapter(presenter: presenter)
        setupNavBar()
        setupTableView()
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
        tableView.estimatedRowHeight = 216
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        refreshControl = attachRefreshControl(to: tableView, onPull: #selector(pullToRefresh))
    }
    
    @objc
    private func pullToRefresh() {
//        presenter.eventLoadNewsListPage()
        presenter.eventLoadNewsListPage(refreshData: true)
    }
    
    private func addLangBtn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Martian",
                                              style: .plain,
                                              target: self,
                                              action: #selector(eventToggleLang))
        self.rightNavBtn = navigationItem.rightBarButtonItem
        self.rightNavBtn.tintColor  = .black
    }
    
    @objc
    private func eventToggleLang() {
        loadingView.show()
        rightNavBtn.isEnabled = false
        presenter.eventToggleLang()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.tintColor = .black
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
            guard let self = self else { fatalError("Failed to get instance of \(NewsListVC.self)") }
            self.tableView.reloadData()
            self.navigationItem.rightBarButtonItem?.title = newsPage.langBtnTitle
            self.loadingView.dismiss()
            self.refreshControl.endRefreshing()
            self.rightNavBtn.isEnabled = true
        }
    }
    
    func showError(_ error: LocalizedError) {
        print("Error: \(error.localizedDescription)")
        self.loadingView.dismiss()
        self.refreshControl.endRefreshing()
        self.rightNavBtn.isEnabled = true
    }
}

