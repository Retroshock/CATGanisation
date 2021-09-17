//
//  LoaderView.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 16.09.2021.
//

import UIKit

enum LoaderViewStyle: CaseIterable {
    case white
    case yellow
    case red
    case blue

    func color() -> UIColor {
        switch self {
        case .white:
            return .white
        case .yellow:
            return .yellow
        case .red:
            return .red
        case .blue:
            return .blue
        }
    }
    static var random: LoaderViewStyle {
        LoaderViewStyle.allCases.randomElement() ?? .white
    }
}

class LoaderView: NibView {

    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var textLabel: UILabel!

    func setup(with text: String) {
        self.textLabel.text = text
    }

    class func show(with message: String = "Loading...",
                    parent: UIView = UIApplication.shared.windows.first!,
                    style: LoaderViewStyle = LoaderViewStyle.random ) {
        hide(from: parent)
        let loaderView = LoaderView(frame: CGRect(x: 0, y: 0, width: parent.frame.width / 2, height: 75))
        loaderView.apply(style: style)
        parent.addSubview(loaderView)
        loaderView.setup(with: message)
        loaderView.center = parent.center
        parent.bringSubviewToFront(loaderView)
    }

    class func hide(from parent: UIView = UIApplication.shared.windows.first!) {
        parent.subviews.first { $0 is LoaderView }?.removeFromSuperview()
    }

    class func bringToFront(parent: UIView = UIApplication.shared.windows.first!) {
        if let loader = parent.subviews.first(where: { $0 is LoaderView }) {
            parent.bringSubviewToFront(loader)
        }
    }

    private func apply(style: LoaderViewStyle) {
        textLabel.textColor = style.color()
        activityIndicator.color = style.color()
    }
}

