//
//  MapView.swift
//  Launch screen
//
//  Created by Abe Molina on 6/28/23.
//

import SwiftUI
import MapKit
import Combine

struct MapView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    @State private var userRegion =  MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.3304, longitude: -83.0479), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    var store:Store
    
    @State var showSheet = false
    @State private var selectedPlace: Store?
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            Map(coordinateRegion: $userRegion, interactionModes: .all, showsUserLocation: true, userTrackingMode: nil, annotationItems: stores){
                
                place in
                MapAnnotation(coordinate: place.coordinate) {
                    HStack {
                        Image(systemName: "fork.knife.circle.fill")
                        Text(place.storeName)
                    }
                    .onTapGesture {
                        selectedPlace = place
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                SheetView()
                    .presentationDetents([.medium])
            }
            
            .ignoresSafeArea(.all)
            
            Button {
                showSheet.toggle()
            } label: {
                
                VStack {
                    
                    Image(systemName: "list.bullet")
                        .resizable()
                        .frame(maxWidth: 40, maxHeight: 30, alignment: .bottomTrailing)
                        .foregroundColor(.primary)
                        .bold()
                    Text("Nearby")
                        .foregroundColor(.primary)
                        .bold()
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom)
            .sheet(isPresented: $showSheet) {
                SheetView()
                    .presentationDetents([.medium])
            }
            
            Spacer()
            //                ZStack(alignment: .bottomTrailing) {
            //                    ForEach(locationManager.places) { store in
            ////                        if store.coordinate = store {
            //                            LocationPreview(store: .example)
            //                        }
            //                    }
        }
        .sheet(item: $selectedPlace) { place in
            BusinessView(store: place)
                .presentationDetents([.medium])
        }
        
    }
}
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(store: .example)
            .environmentObject(LocationManager())
    }
}
