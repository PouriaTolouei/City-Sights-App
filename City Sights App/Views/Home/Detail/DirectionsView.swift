//
//  DirectionView.swift
//  City Sights App
//
//  Created by Pouria Tolouei on 15/08/2022.
//

import SwiftUI

struct DirectionsView: View {
    
    var business: Business
    
    var body: some View {
       
        VStack (alignment: .leading) {
            
            // Business title
            HStack {
                BusinessTitle(business: business)
                Spacer()
                
                if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude, let name = business.name?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(name)") {
                    Link("Open in maps", destination: url)
                }
            }
            .padding()
            
            // Directions map
            DirectionsMap(business: business)
                .ignoresSafeArea(.all, edges: .bottom)
            
        }
    }
}

