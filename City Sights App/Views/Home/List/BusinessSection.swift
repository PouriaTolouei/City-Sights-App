//
//  BusinessSection.swift
//  City Sights App
//
//  Created by Pouria Tolouei on 12/08/2022.
//

import SwiftUI

struct BusinessSection: View {
   
    var title: String
    var businesses: [Business]
    
    var body: some View {
        
        Section(header: BusinessSectionHeader(title: title)) {
            ForEach(businesses) { business in
                
                BusinessRow(business: business)
            }
        }
    }
}
