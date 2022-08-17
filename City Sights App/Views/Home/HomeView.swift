//
//  HomeView.swift
//  City Sights App
//
//  Created by Pouria Tolouei on 12/08/2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    @State var selectedBusiness: Business?
    
    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            NavigationView {
                
                // Determine if we should show list or map
                if !isMapShowing {
                    
                    // Show list
                    VStack(alignment: .leading) {
                        
                        HStack {
                            
                            Image(systemName: "location")
                            
                            Text(model.placemark?.locality ?? "")
                            
                            Spacer()
                            
                            Button("Switch to map view") {
                                self.isMapShowing = true
                            }
                        }
                        
                        Divider()
                        
                        ZStack(alignment: .top) {
                            
                            BusinessList()
                            
                            HStack {
                                
                                Spacer()
                                
                                YelpAttribution(link: "https://www.yelp.com")
                            }
                            .padding(.trailing, -20)
                            
                        }
                    }
                    .padding([.horizontal, .top])
                    .navigationBarHidden(true)
                }
                else {
                    
                    // Show map
                    ZStack (alignment: .top) {
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                
                                // Create a business detail view instance
                                // Pass in the selected business
                                BusinessDetail(business: business)
                        }
                        
                        // Rectangle overlay
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .frame(height: 48)
                            
                            HStack {
                                
                                Image(systemName: "location")
                                
                                Text(model.placemark?.locality ?? "")
                                
                                Spacer()
                                
                                Button("Switch to list view") {
                                    self.isMapShowing = false
                                }
                            }
                            .padding()
                        }
                        .padding(.horizontal)
                    }
                    .navigationBarHidden(true)
                    
                }
            }
        }
        else {
            
            // Still waiting for data, so show spinner
            ProgressView()
        }
    }
}
