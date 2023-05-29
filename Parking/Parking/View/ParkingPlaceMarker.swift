//
//  ParkingPlaceMarker.swift
//  Parking
//
//  Created by 박재우 on 2023/05/29.
//

import UIKit

class ParkingPlaceMarker: UIView {
    private let circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    private let pLabel: UILabel = {
        let label = UILabel()
        label.text = "P"
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center

        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    init() {
        super.init(frame: .zero)
        configure()
        setAutoLayout()
    }

    init(name: String) {
        super.init(frame: .zero)
        configure()
        setAutoLayout()
        updateLabelText(text: name)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateLabelText(text: String) {
        nameLabel.text = text
    }

    private func configure() {
        layer.cornerRadius = 18
        clipsToBounds = true
        backgroundColor = .blue

        circleView.addSubview(pLabel)
        addSubview(circleView)
        addSubview(nameLabel)
    }

    private func setAutoLayout() {
        circleView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        pLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            circleView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            circleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            circleView.widthAnchor.constraint(equalToConstant: 20),
            circleView.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            pLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            pLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor)
        ])
    }

    func convertToImage() -> UIImage? {
//        let renderer = UIGraphicsImageRenderer(bounds: bounds)
//        return renderer.image { rendererContext in
//            layer.render(in: rendererContext.cgContext)
//        }
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
}
