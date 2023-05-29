//
//  IconButton.swift
//  Parking
//
//  Created by 박재우 on 2023/05/29.
//

import UIKit

enum IconButtonType {
    case favorite
    case currentLocation

    var image: UIImage? {
        switch self {
        case .favorite:
            return UIImage(named: "favorite")
        case .currentLocation:
            return UIImage(named: "currentLocation")
        }
    }
}

class IconButton: UIButton {
    private var type: IconButtonType

    init(type: IconButtonType) {
        self.type = type
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 30
        clipsToBounds = true

        backgroundColor = .white
        setImage(type.image, for: .normal)

        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 2)
        layer.shadowOpacity = 0.5

        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
