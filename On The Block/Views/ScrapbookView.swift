//
//  ScrapbookView.swift
//  Launch screen
//
//  Created by Abe Molina on 6/28/23.
//

import SwiftUI

import SwiftUI

struct ScrapbookView: View {
    @EnvironmentObject var vm: ViewModel
    @FocusState var nameField:Bool
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Scrapbook")
                    .font(.custom("RammettoOne-Regular", size: 40))
                    .bold()
                
                
                if !vm.isEditing {
                    imageScroll
                }
                selectedImage
                VStack {
                    if vm.image != nil {
                       editGroup
                    }
                    if !vm.isEditing {
                        pickerButtons
                    }
                }
                .padding()
                Spacer()
            }
            .task {
                if FileManager().docExist(named: fileName) {
                    vm.loadMyImagesJSONFile()
                }
            }
            .sheet(isPresented: $vm.showPicker) {
                ImagePicker(sourceType: vm.source == .library ? .photoLibrary : .camera, selectedImage: $vm.image)
                    .ignoresSafeArea()
            }
            .alert("Error", isPresented: $vm.showFileAlert, presenting: vm.appError, actions: { cameraError in
                cameraError.button
            }, message: { cameraError in
                Text(cameraError.message)
            })
//            .navigationTitle("My Images")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button {
                            nameField = false
                        } label : {
                            Image(systemName: "keyboard.chevron.compact.down")
                        }
                    }
                }
            }
        }
    }
}

struct ScrapbookView_Previews: PreviewProvider {
    static var previews: some View {
        ScrapbookView()
            .environmentObject(ViewModel())
            .environmentObject(LocationManager())
    }
}



