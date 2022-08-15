//
//  BusinessDetail.swift
//  City Sights App
//
//  Created by Pouria Tolouei on 13/08/2022.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Business
    @State private var showDirections = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack(alignment: .leading, spacing: 0) {
            
                GeometryReader { geo in
                    
                    // Business Image
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                }
                .ignoresSafeArea(.all, edges: .top)
                
                // Open / Closed Indicator
                ZStack(alignment: .leading) {
                    
                    Rectangle()
                        .foregroundColor((business.isClosed ?? true) ? .gray : .blue)
                        .frame(height: 36)
                    
                    Text((business.isClosed ?? false) ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                }
            }
            
            // Business Details
            Group {
                
                BusinessTitle(business: business)
                    .padding()
                
                Divider()
                
                // Phone
                HStack {
                    
                    Text("Phone: ")
                        .bold()
                    
                    Text(business.displayPhone ?? "")
                    
                    Spacer()
                    
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")") ?? URL(fileURLWithPath: ""))
                }
                .padding()
                
                Divider()
                
                // Reviews
                HStack {
                    
                    Text("Reviews: ")
                        .bold()
                    
                    Text(String(business.reviewCount ?? 0))
                    
                    Spacer()
                    
                    Link("Read", destination: URL(string: business.url ?? "") ?? URL(fileURLWithPath: ""))
                }
                .padding()
                
                Divider()
                
                // Website
                HStack {
                   
                    Text("Website: ")
                        .bold()
                    
                    Text(business.url ?? "")
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Link("Visit", destination: URL(string: business.url ?? "") ?? URL(fileURLWithPath: ""))
                }
                .padding()
                
                Divider()
            }
            
            // Get directions button
            Button {
               
                // Show direcitons
                showDirections = true
                
            } label: {
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .padding()
            .sheet(isPresented: $showDirections) {
                DirectionsView(business: business)
            }

        }
    }
}

