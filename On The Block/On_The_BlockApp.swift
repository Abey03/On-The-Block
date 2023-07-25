//
//  On_The_BlockApp.swift
//  On The Block
//
//  Created by Abe Molina on 7/24/23.
//

import SwiftUI

@main
struct On_The_BlockApp: App {
    
    @StateObject private var locationManager = LocationManager()
    @StateObject var vm = ViewModel()
    
    var body: some Scene {
//        Enables main views
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(vm)
        }
//        Enables scrapbook view and it's user defaults
        WindowGroup {
                ScrapbookView()
                .environmentObject(vm)
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }

               
        }
    }
}
