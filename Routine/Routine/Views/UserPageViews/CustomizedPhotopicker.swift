//
//  CustomizedPhotopicker.swift
//  Routine
//
//  Created by Dajun Xian on 11/18/22.
//

import SwiftUI
import PhotosUI
struct CustomizedPhotopicker: View {
    @State private var selectedItem: PhotosPickerItem? = nil
        @State private var selectedImageData: Data? = nil
        
        var body: some View {
            
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    Text("Select a photo")
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        // Retrieve selected asset in the form of Data
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                        }
                    }
                }
            
            if let selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
}

struct CustomizedPhotopicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomizedPhotopicker()
    }
}
