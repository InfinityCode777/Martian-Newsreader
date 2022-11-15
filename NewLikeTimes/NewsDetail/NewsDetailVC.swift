//
//  NewsDetailVC.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/7/22.
//

import UIKit

class NewsDetailVC: UIViewController, LoadingViewAttaching {
    // This should not be stored here
//    var news: NewsViewModel!
    var presenter: NewsDetailPresenter!
    
    @IBOutlet var titelLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var bodyTextView: UITextView!
    private var loadingView: LoadingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView = attachLoadingView()
        presenter.eventViewReady()
    }
    
    override func awakeFromNib() {
        self.presenter = NewsDetailPresenter()
        self.presenter.output = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension NewsDetailVC: NewsDetailPresenterOutput {
    func showNewsDetail(_ news: NewsViewModel) {
        titelLabel.text = news.title
        bodyTextView.text = news.body
        imageView.image = news.image
    }
}
