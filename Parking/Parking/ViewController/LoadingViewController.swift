//
//  LoadingViewController.swift
//  Parking
//
//  Created by 박재우 on 2023/05/30.
//

import UIKit
import CoreData
import FirebaseDatabase

class LoadingViewController: UIViewController {
    private lazy var persistentContainer: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate!.persistentContainer
    }()

    lazy var movingView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Loading")
        return view
    }()

    private var ref: DatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        view.addSubview(movingView)
        view.backgroundColor = UIColor(red: 7 / 256, green: 69 / 256, blue: 191 / 256, alpha: 1)
        movingView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            movingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            movingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movingView.widthAnchor.constraint(equalToConstant: 150),
            movingView.heightAnchor.constraint(equalToConstant: 150)
        ])

        startMovingAnimation()

        generateDataIfNeeded(context: persistentContainer.viewContext)
    }

    private func startMovingAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.movingView.transform = CGAffineTransform(translationX: 0, y: 20)
        }, completion: nil)
    }

    private func generateDataIfNeeded(context: NSManagedObjectContext) {
        context.perform {
            guard let number = try? context.count(for: ParkingPlace.fetchRequest()),
                  number == 0 else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    let newViewController = ParkingViewController()
                    let navigationController = UINavigationController(rootViewController: newViewController)
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true, completion: nil)
                }
                return
            }

            self.ref?.child("data").observe(.value) { snapshot in
                guard let snapshot = snapshot.value as? [String] else {
                    print("Error: 서버에 문제가 발생했습니다")
                    return
                }

                DispatchQueue.main.async {
                    snapshot.forEach { dataString in
                        if let data = dataString.data(using: .utf8),
                           let decodedData = try? JSONDecoder().decode(ParkingPlaceDTO.self, from: data) {
                            decodedData.createParkingPlaceContext(context: context)
                        }
                    }

                    do {
                        try context.save()
                    } catch {
                        let nserror = error as NSError
                        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                    }

                    let newViewController = ParkingViewController()
                    let navigationController = UINavigationController(rootViewController: newViewController)
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true, completion: nil)
                }
            }
        }
    }
}
