//
//  SheetView.swift
//  Launch screen
//
//  Created by Abe Molina on 7/3/23.
//

import SwiftUI

struct SheetView: View {
    
    @EnvironmentObject private var locationManager: LocationManager

    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                LazyVStack {
                    Text("What's near you")
                        .font(.title2)
                        .padding(.trailing, 220)
                        .bold()
                    
                    LazyVStack(alignment: .leading) {
                        RowView(store: .example)
                    }
                    .padding()
                }
                .padding(.top)
            }
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
            .environmentObject(LocationManager())
    }
}
