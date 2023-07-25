//
//  ContentView.swift
//  Launch screen
//
//  Created by Joshua M. Escobedo on 5/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        
        if UserDefaults.standard.welcomeScreenShown{
            homeScreenView(store: .example)
        } else {
            WelcomeScreen()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LocationManager())
    }
}

