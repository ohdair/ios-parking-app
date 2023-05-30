//
//  ChargeLabel.swift
//  Parking
//
//  Created by 박재우 on 2023/05/30.
//

import UIKit

class ChargeLabel: UILabel {
    var isFilled: Bool = false

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = isFilled ? UIColor(named: "MainColor") : .white

        font = UIFont.boldSystemFont(ofSize: 12)
        textColor = isFilled ? .white : .gray
        textAlignment = .center

        layer.cornerRadius = 9
        clipsToBounds = true

        if !isFilled {
            layer.borderWidth = 1
            layer.borderColor = UIColor.gray.cgColor
        }

        widthAnchor.constraint(equalToConstant: 50).isActive = true
        heightAnchor.constraint(equalToConstant: 18).isActive = true
    }

    func configure(type: ChargeType, filled: Bool = false) {
        switch type {
        case .free:
            text = "무료"
        case .paid:
            text = "유료"
        }

        self.isFilled = filled
    }
}
