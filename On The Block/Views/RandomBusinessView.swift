import SwiftUI

struct RandomBusinessView: View {
    
    @State var store:Store
    @EnvironmentObject var locationManager: LocationManager
    
    func generateRandomBusiness() {
        
        if let randomBusiness = stores.randomElement() {
            self.store = randomBusiness
        }
    }
    
    var body: some View {
        
        NavigationView {
            
                VStack {
                    
                    Text("RANDOM BUSINESS BELOW")
                        .font(.title2)
                        .bold()
                        .padding()
                    
                    NavigationLink {
                        
                        BusinessView(store: store)
                        
                    }label: {
                        
                        VStack {
                            
                            Image(store.image)
                                .resizable()
                                .frame(width: 400, height: 400)
                                .cornerRadius(20)
                                .padding(.horizontal)
                                .overlay(alignment: .bottomLeading) {
                                    HStack {
                                        Text(store.storeName)
                                            .foregroundColor(.primary)
                                            .background()
                                            .padding()
                                    }
                                }
                            
                            Button {
                                generateRandomBusiness()
                            } label: {
                                Text("Generate")
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .buttonStyle(.bordered)
                            
                            Spacer()
                            
                        }
                    }
                    
//                    Add a checklist under the generate button?
                    
                }
        }
    }
}
        
        struct RandomBusinessView_Previews: PreviewProvider {
            static var previews: some View {
                RandomBusinessView(store: .example)
                .environmentObject(LocationManager())    }
        }
