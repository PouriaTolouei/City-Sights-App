//
//  BusinessSearch.swift
//  City Sights App
//
//  Created by Pouria Tolouei on 11/08/2022.
//

import Foundation

struct BusinessSearch: Decodable {
    
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    
    var center = Coordinate()
}
