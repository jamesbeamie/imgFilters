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

//Custom image saver class
class ImageSaver: NSObject{
    func writeToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error:Error?, contextInfo: UnsafeRawPointer ){
        // log
        print("Saved")
    }
}

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var filterIntensity = 0.5
    @State private var inputImage: UIImage?
    @State var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    var body: some View {
        
        let intensity = Binding<Double>(
            get:{
                self.filterIntensity
        },
            set:{
                self.filterIntensity = $0
                self.applyProccesing()
        }
        )
        return NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color.secondary)
        if image != nil {
            image?
            .resizable()
            .scaledToFit()
        }else{
            Text("Pick an Image")
                .font(.headline)
                .foregroundColor(.white)
                }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                HStack{
                    Text("Adjust")
                    Slider(value: intensity)
                    }
                .padding(.vertical)
                HStack{
                        Button("Apply Filter"){
                        }
                        Spacer()
                        Button("Save"){
                        }
                    }
        }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Image Manipulation")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                        ImagePicker(image: self.$inputImage)
                    }
        }
    }
    func loadImage(){
        guard let inputImage = inputImage else {return}
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProccesing()
//        let imageSaver = ImageSaver()
//        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
    
    func applyProccesing(){
        currentFilter.intensity = Float(filterIntensity)
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
