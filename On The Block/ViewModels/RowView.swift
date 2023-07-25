//
//  RowView.swift
//  Launch screen
//
//  Created by Abe Molina on 5/29/23.
//

import SwiftUI

struct RowView: View {
    
    var store:Store
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        
        ForEach(locationManager.places) { store in
            
            VStack {
                
                NavigationLink {
                    
                    BusinessView(store: store)
                    
                }label: {
                    
                    HStack {
                        Image(store.image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                        
                        
                        VStack(alignment: .leading) {
                            Text(store.storeName)
                                .bold()
                                .foregroundColor(.primary)
                            Text(store.bio)
                                .frame(height: 50)
                                .foregroundColor(.primary)
//                            Text(store.address)
//                                .foregroundColor(.primary)
//                            if let distanceFormatted = store.distanceFormatted {
//                                Text(distanceFormatted)
//                                    .foregroundColor(.primary)
//                            }
                        }
                    }
                }
            }
        }
    }
}
struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(store: .example)
            .environmentObject(LocationManager())
    }
}
