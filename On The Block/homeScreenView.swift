import SwiftUI
import CoreLocation

struct homeScreenView: View {
    
    @State var store:Store
    let stores = Store.example
    @EnvironmentObject private var locationManager: LocationManager
    @State private var query = ""
    @State var searchText: String = ""
    
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                
                LazyVStack {
                    
                    HStack(alignment: .center, spacing: 50) {
                        
                        NavigationLink {
                            MapView(store: .example)
                        } label: {
                            Image(systemName: "globe.americas")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.primary)
                        }
                        
                        Text("ON THE BLOCK")
                            .padding(.top)
                        //                    .font(.largeTitle)
                            .font(.custom("RammettoOne-Regular", size: 20))
                            .bold()
                        
                        NavigationLink {
                            RandomBusinessView(store: .example)
                        } label: {
                            Image(systemName:"photo.stack")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.primary)
                        }
                    }
                    
//                    Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Find a business", text: $searchText)
                    }
                    .padding(13)
                    .background(Color(.systemGray5))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .font(.headline)
                    
//                    Main View
                    Text("Popular locations")
                        .padding(.top, 5)
                        .bold()
                        .font(.title2)
                    //                    .bold()
                        .padding(.trailing, 200)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 10) {
                            
                            GridView(store: .example)
                            
                        }
                    }
                    .padding(.horizontal, 13)
                    
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
            //            .navigationBarTitle("On the Block", displayMode: .inline)
        }
        
        .onAppear{
            requestNotification()
        }
        //        .searchable(text: $query, prompt: "Find a business")
        //        .onChange(of: query) { newQuery in
        //            store.
        //        }
    }
    
    func requestNotification() {
        Task {
            locationManager.requestLocation()
            await locationManager.requestNotificationAuthorization()
        }
    }
}


struct HomeScreen_Preview: PreviewProvider {
    static var previews: some View {
        homeScreenView(store: .example)
            .environmentObject(LocationManager())
            .environmentObject(ViewModel())
    }
}


