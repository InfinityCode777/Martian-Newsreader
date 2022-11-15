//
//  RefreshControlAttaching.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/15/22.
//

import UIKit

protocol RefreshControlAttaching {}
extension RefreshControlAttaching where Self: UIViewController {
    func attachRefreshControl(to tableView: UITableView, onPull: Selector) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: onPull, for: .valueChanged)
        tableView.refreshControl = refreshControl
        return refreshControl
    }
}
