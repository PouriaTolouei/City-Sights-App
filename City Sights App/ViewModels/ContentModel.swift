//
//  ContentModel.swift
//  City Sights App
//
//  Created by Pouria Tolouei on 10/08/2022.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    override init() {
        
        // Init method of NSObject
        super.init()
        
        // Set content model as the delegate of the location manager
        locationManager.delegate = self
       
        // Request permission from the user
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK - Location Manager Delegate Mehods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // We have permission
            // Start geolocating the user after we get permission
            locationManager.startUpdatingLocation()
        }
        else if locationManager.authorizationStatus == .denied {
            
            // We don't have permission
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us the location of the user
        print(locations.first ?? "no location")
        
        // Stop requesting tthe location after we get it once
        locationManager.stopUpdatingLocation()
        
        // TODO: if we have the coordinates of the user, send into Yelp API
    }
        
}
