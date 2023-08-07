//
//  RandomBusinessView.swift
//  Launch screen
//
//  Created by Alejandro Miguel Fuentes-Noguez on 7/31/23.
//

import SwiftUI

struct RandomBusinessView: View {
    
    @State var store:Store
    
    func generateRandomBusiness() {
        
        if let randomBusiness = stores.randomElement() {
            self.store = randomBusiness
            
        }
    }
    
    var body: some View {
        VStack {
            
            Text("RANDOM BUSINESS BELOW")
                .bold()
            
          
            Text(store.storeName)
            Text(store.bio)
            Image(store.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                generateRandomBusiness()
            } label: {
                Text("generate")
            }
            .buttonStyle(.bordered)

        }
    }
    
}

struct RandomBusinessView_Previews: PreviewProvider {
    static var previews: some View {
        RandomBusinessView(store: .example)
    }
}
