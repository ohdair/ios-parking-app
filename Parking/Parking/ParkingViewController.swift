//
//  ParkingViewController.swift
//  Parking
//
//  Created by 박재우 on 2023/05/19.
//

import UIKit
import NMapsMap
import CoreData

class ParkingViewController: UIViewController, NSFetchedResultsControllerDelegate {

    private var isLoading = true
    private lazy var persistentContainer: NSPersistentContainer = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate!.persistentContainer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink


        let context = persistentContainer.viewContext
        let request: NSFetchRequest<ParkingPlace> = ParkingPlace.fetchRequest()

        let data = try? context.fetch(request)

        print(data?.count ?? 0)



//        let mapView = NMFMapView(frame: view.frame)
//        view.addSubview(mapView)

//        do {
//            let bundle = Bundle(for: type(of: self))
//            guard let filePath = bundle.path(forResource: "전국주차장정보표준데이터", ofType: "json"),
//                  let data = try String(contentsOfFile: filePath).data(using: .utf8) else {
//                return
//            }
//
//            let decodedData = try JSONDecoder().decode(ParkingPlaceDTO.self, from: data)
//            let items = decodedData.convert()
//            items.interpolate()
//            print("------------교체 했습니다 ------------")
//            DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
//                for idx in 0...100 {
//                    print(items.items[idx])
//                }
//            }
//        } catch {
//            print(error)
//        }

//        let jibunAddress = "서울특별시 종로구 청진동9"
//        let endpoint = NaverGeocodingAPI(from: jibunAddress)
//        do {
//            NetworkRouter().fetchItem(with: try endpoint.urlRequest, model: NaverGeocodingDTO.self) { data, error in
//                if let error = error {
//                    print(error)
//                }
//                if let data = data {
//                    print(data.convert())
//                }
//            }
//        } catch {
//            print(error)
//        }
    }

    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .orange
//        let request = ParkingPlace.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: "number", ascending: true)]
//
//        let controller = NSFetchedResultsController(fetchRequest: request,
//                                                    managedObjectContext: persistentContainer.viewContext,
//                                                    sectionNameKeyPath: nil, cacheName: nil)
//        controller.delegate = self
//        try? controller.performFetch()
//        let fetchedObject = controller.fetchedObjects
//
//        while isLoading, let number = fetchedObject?.count {
//            if number > 900 {
//                isLoading = false
//            }
//            print("entitiy's count is ", number)
//
//        }
//        while isLoading, let number = try? persistentContainer.viewContext.count(for: request) {
//            if number > 900 {
//                isLoading = false
//            }
//            print("entitiy's count is ", number)
//
//        }

//        let context = persistentContainer.viewContext
//        let request: NSFetchRequest<ParkingPlace> = ParkingPlace.fetchRequest()
//
//        while isLoading, let data = try? context.fetch(request) {
//            let number = data.count
//            if number > 900 {
//                isLoading = false
//            }
//            print("entitiy's count is ", number)
//
//        }

        view.backgroundColor = .systemYellow
    }
}
