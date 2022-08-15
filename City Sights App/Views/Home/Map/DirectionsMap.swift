//
//  DirectionsMap.swift
//  City Sights App
//
//  Created by Pouria Tolouei on 15/08/2022.
//

import Foundation
import MapKit
import SwiftUI

struct DirectionsMap: UIViewRepresentable{
    
    @EnvironmentObject var model: ContentModel
    var business: Business
    
    
    var start: CLLocationCoordinate2D {
        
        return model.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    }
    
    var end: CLLocationCoordinate2D {
        
        if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
            return CLLocationCoordinate2D(latitude:  lat, longitude: long)
        }
        else {
            return CLLocationCoordinate2D()
        }
    }
    
    
    
    func makeUIView(context: Context) -> MKMapView {
        
        
        // Create map
        let mapView = MKMapView()
        
        mapView.delegate = context.coordinator
        
        // Show the user location
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        
        // Create directions request
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start ))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        
        // Create directions object
        let directions = MKDirections(request: request)
            
        
        // Calculate route
        directions.calculate { response, error in
            
            if error == nil && response != nil {
                
                // Plot the routes on the map
                for route in response!.routes {
                    
                    mapView.addOverlay(route.polyline)
                    
                    // Zoom into the region
                    mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100),animated: true)
                }
                
                
            }
        }
        
        // Place annotation for the end point
        let annotation = MKPointAnnotation()
        annotation.title = business.name ?? ""
        annotation.coordinate = end
        
        mapView.addAnnotation(annotation)
         
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
    }
    
    func makeCoordinator() -> Coordinator {
        
        return Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        
        // Tell the view how to render the overlays
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            // The 'as' keyword specifies that the overlay is a MKPolyline
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            
            return renderer
        }
       
    }
    
}

