//
//  CitySightsApp.swift
//  City Sights App
//
//  Created by Pouria Tolouei on 09/08/2022.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
