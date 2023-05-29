//
//  AppDelegate.swift
//  Parking
//
//  Created by 박재우 on 2023/05/19.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ParkingPlaces")
        let defaultDirectoryURL = NSPersistentContainer.defaultDirectoryURL()

        let parkingPlaceStoreURL = defaultDirectoryURL.appendingPathComponent("ParkingPlaces.sqlite")
        let parkingPlaceStoreDescription = NSPersistentStoreDescription(url: parkingPlaceStoreURL)
        parkingPlaceStoreDescription.configuration = "ParkingPlace"

        let favoriteStoreURL = defaultDirectoryURL.appendingPathComponent("Favorites.sqlite")
        let favoriteStoreDescription = NSPersistentStoreDescription(url: favoriteStoreURL)
        favoriteStoreDescription.configuration = "Favorite"

        container.persistentStoreDescriptions = [parkingPlaceStoreDescription, favoriteStoreDescription]

        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("###\(#function): Failed to load persistent stores:\(error)")
        })

        container.viewContext.automaticallyMergesChangesFromParent = true
        generateDataIfNeeded(context: container.newBackgroundContext())

        return container
    }()

    private func generateDataIfNeeded(context: NSManagedObjectContext) {
        // Asynchronously performs the specified closure on the context’s queue.
        // This method encapsulates an autorelease pool and a call to processPendingChanges().
        context.perform {
            guard let number = try? context.count(for: ParkingPlace.fetchRequest()),
                  number == 0 else { return }

            let bundle = Bundle(for: type(of: self))
            guard let filePath = bundle.path(forResource: "전국주차장정보표준데이터", ofType: "json"),
                  let data = try? String(contentsOfFile: filePath).data(using: .utf8),
                  let decodedData = try? JSONDecoder().decode(ParkingPlaceDTO.self, from: data) else {
                return
            }

            decodedData.createParkingPlaceContext(context: context)
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

