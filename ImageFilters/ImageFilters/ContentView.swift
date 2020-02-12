//
//  ContentView.swift
//  ImageFilters
//
//  Created by James on 2/12/20.
//  Copyright © 2020 James. All rights reserved.
//

// Import core image and Filter builtIns
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var myImage: Image?
    @State private var showingImagePicker = false
    var body: some View {
        VStack{
            myImage?
                .resizable()
                .scaledToFit()
            Button("Select Image"){
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker){
            ImagePicker()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
