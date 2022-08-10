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
        let userLocation = locations.first
       
        if userLocation != nil {
            
            // We have a location
            // Stop requesting tthe location after we get it once
            locationManager.stopUpdatingLocation()
            
            // if we have the coordinates of the user, send into Yelp API
            //getBusinessrd(category: "arts", location: userLocation!)
            getBusinessrd(category: "restaurants", location: userLocation!)
        }
    }
    
    // MARK: - Yelp API methods
    
    func getBusinessrd(category: String, location: CLLocation) {
        
        // Create URL
        /*
        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitide=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        let url = URL(string: urlString)
         */
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: String(category)),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlComponents?.url
        
        if let url = url {
            
            // Create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer GA5UeHnCMc9BIqNplYw2QHi4LfmBtkO4GTa_ga86kupSF8LQrOWQOCglnOufhWOIL-P2YZHnNvKSS3quiQeR8ZkrY3CpiFTjAU3ZonbmFR1q8R9V_7bKHiRIiE_zYnYx", forHTTPHeaderField: "Authorization")
            
            // Get URL Session
            let session = URLSession.shared
            
            // Create Data Task
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                // Check that there isn't an error
                if error == nil {
                    print(response)
                }
            }
            
            // Start the Data Task
            dataTask.resume()
        }
    }
}
