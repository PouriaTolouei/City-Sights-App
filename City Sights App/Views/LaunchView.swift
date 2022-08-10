//
//  LaunchView.swift
//  City Sights App
//
//  Created by Pouria Tolouei on 09/08/2022.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
            .environmentObject(ContentModel())
    }
}
