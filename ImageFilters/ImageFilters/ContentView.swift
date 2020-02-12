//
//  ContentView.swift
//  ImageFilters
//
//  Created by James on 2/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var imgBlur: CGFloat = 0{
        didSet{
            print("New Blur value is: \(imgBlur)")
        }
    }
    let blur = Binding<CGFloat>(
        get:{
            self.imgBlur
    },
        set: {
            self.imgBlur = $0
            print("New Blur value is: \(self.imgBlur)")
    }
    )
    
    var body: some View {
            VStack{
                Text("Image Filter")
                .blur(radius: imgBlur)
                Slider(value: blur, in: 0...20)
            }.padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
