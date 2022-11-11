//
//  NewsDetailVC.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/7/22.
//

import UIKit

class NewsDetailVC: UIViewController {
    // This should not be stored here
    var news: NewsViewModel!
    var presenter: NewsDetailPresenter!
    
    @IBOutlet var titelLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var bodyTextView: UITextView!

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
        titelLabel.text = news.title
        bodyTextView.text = news.body
        imageView.image = news.image
    }
}
