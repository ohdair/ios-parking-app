//
//  FavoriteViewCell.swift
//  Parking
//
//  Created by 박재우 on 2023/05/31.
//

import UIKit

class FavoriteViewCell: UITableViewCell {
    static let identifier = "FavoriteViewCell"

    lazy var contentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()

    lazy var chargeTpyeAndNameStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.alignment = .leading
        return stackView
    }()

    let chargeTypeLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
 
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    let payLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()

    func configure(with parkingPlace: ParkingPlace) {
        let chargeType = ChargeType(rawValue: Int(parkingPlace.chargeType))
        if chargeType == .free {
            chargeTypeLabel.text = "무"
            chargeTypeLabel.textColor = UIColor(named: "MainColor")
            chargeTypeLabel.layer.borderWidth = 1
            chargeTypeLabel.layer.borderColor = UIColor(named: "MainColor")?.cgColor
        } else {
            chargeTypeLabel.text = "유"
            chargeTypeLabel.textColor = .white
            chargeTypeLabel.backgroundColor = UIColor(named: "MainColor")
        }

        var address = ""
        if let roadAddress = parkingPlace.roadAddress, !roadAddress.isEmpty {
            address = roadAddress
        } else if let jibunAddress = parkingPlace.jibunAddress {
            address = jibunAddress
        }

        var payTexts: [String] = []
        if parkingPlace.weekdayCloseTime == "23:59",
           parkingPlace.saturdayCloseTime == "23:59",
           parkingPlace.holidayCloseTime == "23:59" {
            payTexts.append("24시간 영업")
        }
        if chargeType == .paid {
            payTexts.append("기본 \(parkingPlace.baseChargeTime)분 \(parkingPlace.baseChargeAmount)원 / 추가 \(parkingPlace.additionalChargeTime)분 \(parkingPlace.additionalChargeAmount)원")
        } else {
            payTexts.append("무료 개방 주차장")
        }

        nameLabel.text = parkingPlace.name
        addressLabel.text = address
        payLabel.text = payTexts.joined(separator: " / ")

        chargeTpyeAndNameStack.addArrangedSubview(chargeTypeLabel)
        chargeTpyeAndNameStack.addArrangedSubview(nameLabel)
        contentsStackView.addArrangedSubview(chargeTpyeAndNameStack)
        contentsStackView.addArrangedSubview(addressLabel)
        contentsStackView.addArrangedSubview(payLabel)
        addSubview(contentsStackView)

        setAutoLayout()
    }

    func setAutoLayout() {
        contentsStackView.translatesAutoresizingMaskIntoConstraints = false
        chargeTypeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            contentsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])

        NSLayoutConstraint.activate([
            chargeTypeLabel.widthAnchor.constraint(equalToConstant: 20),
            chargeTypeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
