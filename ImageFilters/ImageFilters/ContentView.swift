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


struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var showingFiltterSheet = false
    @State private var filterIntensity = 0.5
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
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
                        .fill(Color.white)
        if image != nil {
            image?
            .resizable()
            .scaledToFit()
        }else{
            Text("Pick an Image")
                .font(.headline)
                .foregroundColor(.blue)
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
                            self.showingFiltterSheet = true
                        }
                        Spacer()
                        Button("Save"){
                            guard let processedImage = self.processedImage else {return}
                             let imageSaver = ImageSaver()
                            imageSaver.successHandler = {
                                print("Image saved")
                            }
                            imageSaver.errorHandler={
                                print("Error saving picha:  \($0.localizedDescription)")
                            }
                            imageSaver.writeToPhotoAlbum(image: processedImage)
                            
                        }
                    }
        }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Image Manipulation")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                        ImagePicker(image: self.$inputImage)
                    }
            .actionSheet(isPresented: $showingFiltterSheet){
                ActionSheet(title: Text("select filter"), buttons: [
                    .default(Text("Grainy")){self.setFilter(CIFilter.crystallize())},
                    .default(Text("Darken")){self.setFilter(CIFilter.edges())},
                        .default(Text("Blur")){self.setFilter(CIFilter.gaussianBlur())},
                    .default(Text("Pixellate")){self.setFilter(CIFilter.pixellate())},
                    .default(Text("Vintage")){self.setFilter(CIFilter.sepiaTone())},
                        .default(Text("white balanced")){self.setFilter(CIFilter.unsharpMask())},
                    .default(Text("Sandy Brown")){self.setFilter(CIFilter.vignette())},
                        .cancel()
                    
                ])
            }
        }
    }
    func loadImage(){
        guard let inputImage = inputImage else {return}
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProccesing()
    }
    
    func applyProccesing(){
        let inputKey = currentFilter.inputKeys
        
//        set intensity values for respective filters
        if inputKey.contains(kCIInputIntensityKey) {currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)}
        if inputKey.contains(kCIInputRadiusKey) {currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)}
        if inputKey.contains(kCIInputScaleKey) {currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)}
//        set intensity values for respective types of filters
        
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
            }
        }
    func setFilter(_ filter: CIFilter){
        currentFilter = filter
        loadImage()
    }
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
