//
//  BottomSheetController.swift
//  Parking
//
//  Created by 박재우 on 2023/05/30.
//

import UIKit

class BottomSheetController: UIViewController {

    var parkingPlace: ParkingPlace?

    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedFavorite), for: .touchUpInside)
        return button
    }()

    let contentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()

    lazy var chargeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .leading
        return stackView
    }()

    let parkingNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()

    let payLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()

    let contactNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()

    func configure(with parkingPlace: ParkingPlace) {
        self.parkingPlace = parkingPlace
        let chargeType = ChargeType(rawValue: Int(parkingPlace.chargeType))
        let freeLabel = ChargeLabel()
        let paidLabel = ChargeLabel()
        freeLabel.configure(type: .free, filled: chargeType == .free)
        paidLabel.configure(type: .paid, filled: chargeType == .paid)
        chargeStackView.addArrangedSubview(freeLabel)
        chargeStackView.addArrangedSubview(paidLabel)

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

        if let number = parkingPlace.contactNumber, !number.isEmpty {
            let phoneImage = UIImage(systemName: "phone")
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = phoneImage
            let attributedText = NSMutableAttributedString()
            attributedText.append(NSAttributedString(attachment: imageAttachment))
            attributedText.append(NSAttributedString(string: number))
            contactNumberLabel.attributedText = attributedText
        }

        if parkingPlace.favorite {
            favoriteButton.setImage(UIImage(named: "Favorite"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "EmptiedFavorite"), for: .normal)
        }

        parkingNameLabel.text = parkingPlace.name
        addressLabel.text = address
        payLabel.text = payTexts.joined(separator: " / ")

        contentsStackView.addArrangedSubview(chargeStackView)
        contentsStackView.addArrangedSubview(parkingNameLabel)
        contentsStackView.addArrangedSubview(addressLabel)
        contentsStackView.addArrangedSubview(payLabel)
        contentsStackView.addArrangedSubview(contactNumberLabel)

        view.addSubview(favoriteButton)
        view.addSubview(contentsStackView)
        view.backgroundColor = .white

        setAutoLayout()
    }

    private func setAutoLayout() {

        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        contentsStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 13),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
            favoriteButton.widthAnchor.constraint(equalToConstant: 22),
            favoriteButton.heightAnchor.constraint(equalToConstant: 21)
        ])

        NSLayoutConstraint.activate([
            contentsStackView.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: 20),
            contentsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    @objc func tappedFavorite() {
        if let parkingPlace = parkingPlace {
            if parkingPlace.favorite {
                favoriteButton.setImage(UIImage(named: "EmptiedFavorite"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "Favorite"), for: .normal)
            }

            parkingPlace.favorite = !parkingPlace.favorite
            CoreDataManager.shared.saveContext()
        }
    }
}
