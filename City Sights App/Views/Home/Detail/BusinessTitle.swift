//
//  BusinessTitle.swift
//  City Sights App
//
//  Created by Pouria Tolouei on 15/08/2022.
//

import SwiftUI

struct BusinessTitle: View {
    
    var business: Business
    
    var body: some View {
        
        VStack(alignment: .leading) {
            // Name
            Text(business.name ?? "")
                .font(.title2)
                .bold()
            
            // Loop through display address
            if business.location?.displayAddress != nil {
                
                ForEach(business.location!.displayAddress!, id: \.self) { displayLine in
                    
                    Text(displayLine)
                }
            }
            
            // Rating
            Image("regular_\(business.rating ?? 0.0)")
        }
    }
}
