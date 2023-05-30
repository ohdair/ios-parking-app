//
//  LoadingViewController.swift
//  Parking
//
//  Created by 박재우 on 2023/05/30.
//

import UIKit
import CoreData

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

    override func viewDidLoad() {
        super.viewDidLoad()

//        print(fetchedResultsController.fetchedObjects?.count ?? 0)
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

    @objc func handleNotification(_ notification: Notification) {
        if let _ = notification.userInfo?["done"] as? Bool {
            print("도달했어요")
            let newViewController = ParkingViewController()
            present(newViewController, animated: true)
        }
    }

    private func generateDataIfNeeded(context: NSManagedObjectContext) {
        // Asynchronously performs the specified closure on the context’s queue.
        // This method encapsulates an autorelease pool and a call to processPendingChanges().
        context.perform {
            guard let number = try? context.count(for: ParkingPlace.fetchRequest()),
                  number == 0 else {
                let newViewController = ParkingViewController()
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true)
                return
            }

            let bundle = Bundle(for: type(of: self))
            guard let filePath = bundle.path(forResource: "전국주차장정보표준데이터", ofType: "json"),
                  let data = try? String(contentsOfFile: filePath).data(using: .utf8),
                  let decodedData = try? JSONDecoder().decode(ParkingPlaceDTO.self, from: data) else {
                return
            }
            Task {
                await decodedData.createParkingPlaceContext(context: context)
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
        
                let newViewController = ParkingViewController()
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true)
            }
        }
    }
}
