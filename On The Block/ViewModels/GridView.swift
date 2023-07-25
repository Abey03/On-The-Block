//
//  GridView.swift
//  Launch screen
//
//  Created by Abe Molina on 5/26/23.
//

import SwiftUI

// This view holds all the code for the GridView on the homeScreemView

struct GridView: View {
    
    @State var store:Store
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        
        ForEach(locationManager.places) { store in
        
            HStack {
                
                NavigationLink {
                    
                    BusinessView(store: store)
                    
                }label: {
            
                        VStack {
                            Image(store.image)
                                .resizable()
                                .frame(width: 300, height: 300)
                                .cornerRadius(20)
//                                .padding(.horizontal, 3)
                                .overlay(alignment: .bottomLeading) {
                                    HStack {
                                        Text(store.storeName)
                                            .foregroundColor(.primary)
                                            .background()
                                            .padding()
                                        }
                                    }
                        }
                    }
                }
            }
        }
    }

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(store: .example)
            .environmentObject(LocationManager())
    }
}
