//
//  NewsListPresenter.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/8/22.
//

import UIKit

class NewsListPresenter {
    weak var output: NewsListPresenterOutput!
    
    func eventLoadNewsList() {
        NewsManager.shared.loadAll(filename: "news_data") {[weak self] result in
            guard let self = self else {
                // TODO: bubble up the error
                return
            }
            
            switch result {
            case .success(let domainData):
                let newsList = self.createViewModelList(domainData)
                self.output.show(newsList: newsList)
            case .failure(_):
                // TODO: bubble up the error
                break
            }
        }
    }
    
    func eventViewReady() {
        eventLoadNewsList()
    }
    
    func eventItemSelected(news: NewsViewModel) {
        // Router, use VC for now
        output.showDetail(news: news)
    }
    
    private func createViewModelList(_ domainDataList: [NewsDomainModel]) -> [NewsViewModel] {
        var newsList = [NewsViewModel]()
        var topImage: UIImage?
        for domainData in domainDataList {
            // Get the first topImage and use it for both thumbnail and top image
            for imageBundle in domainData.images {
                if imageBundle.topImage {
                    topImage = UIImage(url: imageBundle.url)
                    break
                }
            }
            
            let viewData = NewsViewModel(title: domainData.title,
                                         body: domainData.body,
                                         image: topImage ?? UIImage())
            newsList.append(viewData)
        }
        
        return newsList
    }
    
    private func getImage(with url: URL) -> UIImage {
        return UIImage()
    }
}

extension UIImage {
  convenience init?(url: URL?) {
    guard let url = url else { return nil }
            
    do {
      self.init(data: try Data(contentsOf: url))
    } catch {
      print("Cannot load image from url: \(url) with error: \(error)")
      return nil
    }
  }
}
