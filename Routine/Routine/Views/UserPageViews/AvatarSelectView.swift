//
//  AvatarSelectView.swift
//  Routine
//
//  Created by Dajun Xian on 11/18/22.
//

import SwiftUI

struct AvatarSelectView: View {
    
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct AvatarSelectView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarSelectView()
    }
}
