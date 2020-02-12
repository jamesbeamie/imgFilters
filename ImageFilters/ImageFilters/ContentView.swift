//
//  ContentView.swift
//  ImageFilters
//
//  Created by James on 2/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var imgBlur: CGFloat = 0
    var body: some View {
        VStack{
            Text("Image Filter")
            .blur(radius: imgBlur)
            Slider(value: $imgBlur, in: 0...20)
        }
    .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
