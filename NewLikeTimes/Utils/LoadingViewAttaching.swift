//
//  LoadingViewAttaching.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/14/22.
//

import UIKit

protocol LoadingViewAttaching {}
extension LoadingViewAttaching where Self: UIViewController {
    func attachLoadingView() -> LoadingView {
        let loadingView = LoadingView(frame: self.view.frame)
        view.addSubview(loadingView, constrainedTo: self.view)
        loadingView.dismiss()
        return loadingView
    }
}
