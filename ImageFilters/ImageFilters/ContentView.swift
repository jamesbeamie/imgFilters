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
        // Console
        print("Saved")
    }
}

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var filterIntensity = 0.5
    @State private var inputImage: UIImage?
    var body: some View {
        NavigationView{
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
//                .onTapGesture {
//                   pick
//                }
                HStack{
                    Text("Adjust")
                    Slider(value: self.$filterIntensity)
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
        }
    }
//        VStack{
//            image?
//                .resizable()
//                .scaledToFit()
//            Button("Select Image"){
//                self.showingImagePicker = true
//            }
//            }.padding()
//        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
//            ImagePicker(image: self.$inputImage)
//        }
//    }
//    func loadImage(){
//        guard let inputImage = inputImage else {return}
//        image = Image(uiImage: inputImage)
//        let imageSaver = ImageSaver()
//        imageSaver.writeToPhotoAlbum(image: inputImage)
//    }
//}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
