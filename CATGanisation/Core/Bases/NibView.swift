//
//  NibView.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 16.09.2021.
//

import UIKit

class NibView: UIView {
    var containerView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
}
private extension NibView {
    func xibSetup() {
        backgroundColor = UIColor.clear
        containerView = loadNib()
        containerView.frame = bounds

        embed(containerView)
    }
}

