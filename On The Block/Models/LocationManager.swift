//
//  LocationManager.swift
//  Launch screen
//
//  Created by Abe Molina on 5/23/23.
//

import CoreLocation
import UserNotifications
import UIKit
import MapKit

class LocationManager: NSObject, ObservableObject {
    
    @Published private var userRegion =  MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.3309, longitude: -83.0479), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @Published var userLocation: CLLocation?
    @Published var places = stores
    @Published var nearBusiness = false
    let notificationCenter = UNUserNotificationCenter.current()
    //  1
    override init() {
        super.init()
        //    2
        notificationCenter.delegate = self
        locationManager.delegate = self
        places = stores
        scheduleAllStoreNotifications(for: stores)
    }
    
    
    //  1
    lazy var locationManager = makeLocationManager()
    //  2
    private func makeLocationManager() -> CLLocationManager {
        //    3
        let manager = CLLocationManager()
        manager.delegate = self
        //    4
        //    Allows notifcations to update while app is suspended
        manager.allowsBackgroundLocationUpdates = true
        
        return manager
    }
    
    
//    Schedules the notification based off of the stores coordinates
    func scheduleAllStoreNotifications(for stores: [Store]) {
        stores.forEach { store in
//            Bases the store region off of the coordinates in the data model
            let region = makeStoreRegion(from: store.coordinate)
            Task {
                await self.registerNotification(for: region)
            }
        }
        
    }
    
    //  1
    private func makeStoreRegion(from location: CLLocationCoordinate2D) -> CLCircularRegion {
        //    2
        let region = CLCircularRegion(center: location, radius: 8, identifier: UUID().uuidString)
        //    3
        region.notifyOnEntry = true
        //    4
        return region
    }
    
    func requestLocation() {
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined, .restricted, .denied:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            return
        case .authorizedWhenInUse:
            return
        @unknown default:
            fatalError()
        }
    }
    
//    This function filters out the array pf stores based on the stores proximity to the user
    func sortByDistance(stores: [Store]) -> [Store] {
        var newStores: [Store] = []
        stores.forEach { store in
            var store = store
            let storeLocation = CLLocation(latitude: store.latitude, longitude: store.longitude)
            // TODO: don't force unwrap this.
            guard let userLocation = userLocation else {
                newStores.append(store)
                return
            }
            store.distanceFromUser = userLocation.distance(from: storeLocation)
            newStores.append(store)
        }
        newStores.sort {
            $0.distanceFromUser! < $1.distanceFromUser!
            // i think the less than sign is correct???? but it might be greater than???? idk....
        }
        return newStores
    }
    
    //  1
    func requestNotificationAuthorization() async {
        //    2
        let options: UNAuthorizationOptions = [.sound, .alert]
        //    3
        do {
            try await notificationCenter.requestAuthorization(options: options)
        } catch {
            print(error.localizedDescription)
        }
        
        //            notificationCenter.requestAuthorization(options: options) {
        //                [weak self] result, _ in
        //                //        4
        //                print("Notification Auth Request result: \(result)")
        //                if result {
        //                    self?.registerNotification()
        //                }
        //            }
    }
    
    //  1
    private func registerNotification(for region: CLCircularRegion) async {
        do {
            
            //  2 This is the notification text that pops up when the background location is used
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "On The Block"
            notificationContent.body = "A business is on your block!!"
            notificationContent.sound = .default
            
            //    3
            let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
            
            //    4
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
            
            //    5
            try await notificationCenter.add(request)
        } catch {
            print(error.localizedDescription)
        }
        //        notificationCenter
        //            .add(request) { error in
        //                if error != nil {
        //                    print("Error: \(String(describing: error))")
        //                }
        //            }
    }
    
}

extension LocationManager: UNUserNotificationCenterDelegate {
    
    //  1
    func userNotificationCenter(
        _ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        //    2
        print("Received Notification")
        //    3
        nearBusiness = true
        completionHandler()
    }
    
    //  4
    func userNotificationCenter(
        _ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        //    5
        print("Recieved Notification in Foreground")
        //    6
        nearBusiness = true
        completionHandler(.sound)
    }
    
    
    func openMaps(store:Store) {
        // If calling from API use this for optionals
        
        //        if let latitude = store.latitude,
        //            let longitude = store.longitude {
        
        let url = URL(string: "maps://?saddr=&daddr=\(store.latitude),\(store.longitude)")
        
#if os(iOS)
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            
        }
#endif
    }
    
}


extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        Authorizes user location status
        switch status {
            
        case .notDetermined, .restricted, .denied:
            print("error")
            
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            userRegion = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            // i think this calls the locationmanager(:didupdateLocations) method....?????
            
        @unknown default:
            fatalError()
        }
    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        Sorts stores on homescreen
        self.userLocation = locations[0]
        self.places = sortByDistance(stores: stores)
    }
}

