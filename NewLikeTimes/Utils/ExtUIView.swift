//
//  ExtUIView.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/14/22.
//

import UIKit
import Anchorage

public extension UIView {
    func roundCorners() {
        self.layer.cornerRadius = {
            let cornerRadius: CGFloat = self.bounds.width / 6.0
            return cornerRadius
        }()
    }

    func addSubview(_ subview: UIView, constrainedTo anchorsView: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false

        subview.centerAnchors == anchorsView.centerAnchors
        subview.sizeAnchors == anchorsView.sizeAnchors

    }
}
