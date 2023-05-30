//
//  SearchBar.swift
//  Parking
//
//  Created by 박재우 on 2023/05/30.
//

import UIKit

class SearchBar: UIView {

    private let textField = UITextField()
    private let searchButton = UIButton(type: .system)

    init() {
        super.init(frame: .zero)
        configure()
        setAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        textField.placeholder = "주차장 이름, 주소를 검색해보세요!"
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        textField.borderStyle = .none

        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = UIColor(named: "MainColor")

        addSubview(textField)
        addSubview(searchButton)
    }

    private func setAutoLayout() {
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            textField.widthAnchor.constraint(equalToConstant: 278)
        ])

        NSLayoutConstraint.activate([
            searchButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            searchButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
    }

    override func layoutSubviews() {
        backgroundColor = .white
        layer.cornerRadius = 20
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 2)
        layer.shadowOpacity = 0.5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
