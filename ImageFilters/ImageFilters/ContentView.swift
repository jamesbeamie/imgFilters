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
    var body: some View {
        VStack{
            myImage?
            .resizable()
            .scaledToFit()
        }
    .onAppear(perform: loadImage)
    .padding()
    }
    func loadImage(){
//        image = Image("hunter-newton-BgZFS8DPg0I-unsplash")
        guard let pickedImage = UIImage(named: "hunter-newton-BgZFS8DPg0I-unsplash") else {return}
//        creating a CI Image from a UI Image
        let convertedImage = CIImage(image: pickedImage)
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = convertedImage
        currentFilter.intensity = 1
        
        // reading a CG Image as output image from our filter, a CIImage
        guard let outPutImage = currentFilter.outputImage else {return}
        //get a CG image from a CI image
        if let convtd = context.createCGImage(outPutImage, from: outPutImage.extent){
            //Converting it into a UI image
            let uiPicha = UIImage(cgImage: convtd)
            //Convert the UI image into a swiftUI image
            myImage = Image(uiImage: uiPicha)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
