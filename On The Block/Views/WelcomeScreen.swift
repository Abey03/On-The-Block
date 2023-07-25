//
//  WelcomeScreen.swift
//  Launch screen
//
//  Created by Abe Molina on 5/31/23.
//

import SwiftUI

struct WelcomeScreen: View {

    @EnvironmentObject private var locationManager: LocationManager
    @State private var orderPlaced = false
    @State private var activateLink = false
    @State var tapped = false
    @State var showHomeScreen = false
    
    var body: some View {
        
        if showHomeScreen {
            homeScreenView(store: .example)
        } else {
            GeometryReader { geo in
                NavigationView {
                    VStack {
                        Image("overlaypics")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 388)
//                            .padding(.top)

                        Text("Explore your city like never before")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 40))
                            .bold()

                        Text("Discover the hidden gems of your city with ON THE BLOCK showcasing the best local minority owned businesses!")
                            .padding()
                            .font(.title2)
                            .bold()
                        
                        Text("Tap anywhere to continue")
                            .foregroundColor(.blue)
                            .font(.title3)
                            .padding()
                        
                    }
                    .onTapGesture {
                        withAnimation {
                            tapped.toggle()
                            UserDefaults.standard.welcomeScreenShown = true
                            showHomeScreen = true
                        }
                    }
                }
                .onAppear(perform: {
                    UserDefaults.standard.welcomeScreenShown = true
                })
            }
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
            .environmentObject(LocationManager())
    }
}
