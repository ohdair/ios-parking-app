//
//  CoreDataManager.swift
//  Parking
//
//  Created by 박재우 on 2023/05/30.
//

import UIKit
import CoreData

class CoreDataManager {
    static let shared: CoreDataManager = CoreDataManager()

    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var container = appDelegate?.persistentContainer
    lazy var context = container?.viewContext

    func fetchParkingPlaces() -> [ParkingPlace] {
        var models: [ParkingPlace] = [ParkingPlace]()
        let request = ParkingPlace.fetchRequest()
        guard let context = context else {
            return models
        }
        do {
            let fetchResult = try context.fetch(request)
            models = fetchResult
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return models
    }

    func fetchFavorites() -> [ParkingPlace] {
        var object: [ParkingPlace] = [ParkingPlace]()
        guard let context = context,
              let request = container?.managedObjectModel.fetchRequestTemplate(forName: "favorites") as? NSFetchRequest<ParkingPlace> else {
            return object
        }

        do {
            object = try context.fetch(request)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }

        return object
    }

    func fetchLocation(with searchText: String) -> Coordinate? {
        var coordinate: Coordinate?
        let request: NSFetchRequest<ParkingPlace> = ParkingPlace.fetchRequest()
        let predicate = NSPredicate(format: "name CONTAINS %@", searchText)
        request.predicate = predicate

        guard let context = context else {
            return coordinate
        }
        do {
            let items = try context.fetch(request)
            guard let latitude = items.first?.latitude,
                  let longitude = items.first?.longitude else {
                return coordinate
            }
            coordinate = Coordinate(latitude: latitude, longitude: longitude)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return coordinate
    }

    func saveContext() {
        if let context = context, context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
