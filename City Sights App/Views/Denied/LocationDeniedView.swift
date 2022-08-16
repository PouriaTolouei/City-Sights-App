//
//  LocationDeniedView.swift
//  City Sights App
//
//  Created by Pouria Tolouei on 16/08/2022.
//

import SwiftUI

struct LocationDeniedView: View {
    
    private let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
       
        VStack (spacing: 20) {
            
            Spacer()
            
            Text("Whoops!")
                .font(.title)
            
            Text("We need to access your location to provide you with the best sights in the city. You can change your decision at any time in Settings.")
            
            Spacer()
            
            Button {
                
                // Open settings by getting the settings url
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    
                    if UIApplication.shared.canOpenURL(url) {
                        
                        // If we can open this settings url, then open it
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
                
            } label: {
                
                ZStack {
                    
                    Rectangle()
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text("Go to Settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                        .padding()
                }
            }
            .padding(.horizontal, 40)

            
            Spacer()
        }
        .padding(.horizontal, 20)
        .foregroundColor(.white)
        .multilineTextAlignment(.center)
        .background(backgroundColor)
        .ignoresSafeArea()
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
