//
//  FavoriteViewController.swift
//  Parking
//
//  Created by 박재우 on 2023/05/30.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    private lazy var persistentContainer: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate!.persistentContainer
    }()

    var data = [ParkingPlace]()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    weak var delegate: FavoriteViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        data = CoreDataManager.shared.fetchFavorites()
        view.backgroundColor = .white
        title = "즐겨찾기"

        let backButtonImage = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(tappedBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .black

        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = 10
        tableView.sectionFooterHeight = 0
        tableView.register(FavoriteViewCell.self, forCellReuseIdentifier: "FavoriteViewCell")
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc func tappedBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension FavoriteViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteViewCell", for: indexPath) as? FavoriteViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: data[indexPath.section])

        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data[indexPath.section].favorite = false
            CoreDataManager.shared.saveContext()
            data = CoreDataManager.shared.fetchFavorites()
            tableView.deleteSections(IndexSet([indexPath.section]), with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
        let coordinate = Coordinate(latitude: data[indexPath.section].latitude, longitude: data[indexPath.section].longitude)
        delegate?.cameraUpdate(with: coordinate)
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
}

protocol FavoriteViewControllerDelegate: NSObject {
    func cameraUpdate(with: Coordinate)
}
