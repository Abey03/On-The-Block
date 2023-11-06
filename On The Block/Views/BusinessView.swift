import SwiftUI

// This is the individual business view

struct BusinessView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var store:Store
    
    var body: some View {
        
            ScrollView(showsIndicators: false) {
               
                LazyVStack(alignment: .leading) {
                    
                    Text(store.storeName)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    HStack {
                        Text(store.address)
                        
                        Divider()
                            .overlay(.primary)
                        
                        if let distanceFormatted = store.distanceFormatted {
                            Text(distanceFormatted)
                                .foregroundColor(.primary)
                        }
                    }
                    Spacer()
            
                    Text("store hours by day of")
                        .bold()
                    Spacer()
                    
                    Divider()
                        .overlay(.primary)
                        .padding(.top)
            
                    Text(store.bio)
                        .padding(.top)
                    
//                    Divider()
//                        .overlay(.primary)
//
                    
                            Image(store.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 375, height: 350)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(50)
                            
                    
                }
                .padding(.horizontal)
                
               
                
                Spacer()
                
                HStack {
                    
                    Link(destination: URL(string: store.website)!, label: {
                        VStack {
                            Image(systemName: "network")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("Website")
                        }.foregroundColor(.primary)
                            .padding()
                    })
                    
                    Divider()
                        .overlay(.primary)
                    
                    Button {
                        locationManager.openMaps(store: store)
                        
                    } label: {
                        VStack {
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("Directions")
                        }
                        .foregroundColor(.primary)
                        .padding()
                    }
                }
                .padding(.top)
            }
//            .navigationTitle(store.storeName)
        
        .padding(.horizontal)
        .padding(.top)
        .padding(.bottom)

        
    }
}


struct BusinessView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessView(store: .example)
    }
}
