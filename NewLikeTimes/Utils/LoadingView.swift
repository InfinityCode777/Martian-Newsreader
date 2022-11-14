//
//  LoadingView.swift
//  NewLikeTimes
//
//  Created by Jing Wang on 11/14/22.
//

import UIKit
import Anchorage

public class LoadingView: UIView {

    private var isUIDebug: Bool = false

    public var notifyText: String = "" {
        didSet {
            notifyLabel.text = notifyText
        }
    }

    lazy private var notifyLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 188, height: 21)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        label.textAlignment = .center
        label.backgroundColor = isUIDebug ?  #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) : .clear
        return label
    }()

    lazy private var spinnerView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.stopAnimating()
        view.hidesWhenStopped = true
        view.frame.origin = CGPoint.zero
        view.backgroundColor = isUIDebug ?  #colorLiteral(red: 1, green: 0.9423659817, blue: 0.3468376554, alpha: 0.7954034675) : .clear
        return view
    }()

    lazy private var blockView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = UIColor(hexString: "#FFFFFF", alpha:0.5)
        return view
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        blockView.addSubview(notifyLabel)
        blockView.addSubview(spinnerView)
        self.addSubview(blockView)
        notifyLabel.frame.size = CGSize(width: frame.width * 0.9, height: frame.height * 0.05)
        self.backgroundColor = isUIDebug ?  #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0.5371628853) : UIColor(hexString: "#FFFFFF", alpha:0.5)
    }

    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func didMoveToSuperview() {
        blockView.topAnchor == self.topAnchor
        blockView.bottomAnchor == self.bottomAnchor
        blockView.leadingAnchor == self.leadingAnchor
        blockView.trailingAnchor == self.trailingAnchor

        notifyLabel.sizeAnchors == notifyLabel.frame.size
        notifyLabel.centerXAnchor == blockView.centerXAnchor
        notifyLabel.centerYAnchor == blockView.centerYAnchor * 0.8

        spinnerView.startAnimating()
        spinnerView.sizeAnchors == spinnerView.frame.size
        spinnerView.centerAnchors == blockView.centerAnchors
    }

    public func show() {
        self.isHidden = false
        superview?.bringSubviewToFront(self)
    }

    public func dismiss() {
        self.isHidden = true
    }
}
