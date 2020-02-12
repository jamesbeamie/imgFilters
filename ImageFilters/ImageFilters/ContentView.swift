//
//  ContentView.swift
//  ImageFilters
//
//  Created by James on 2/12/20.
//  Copyright © 2020 James. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingActionSheet = false
    @State private var bgColor = Color.white
    var body: some View {
        Text("Tap to change background")
            .frame(width:300, height: 300)
        .background(bgColor)
            .onTapGesture {
                self.showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet){
            ActionSheet(title: Text("Change background"), message: Text("select new color"), buttons: [
                .default(Text("Red")) {self.bgColor = Color.red},
                .default(Text("Green")) {self.bgColor = Color.green},
                .default(Text("Blue")) {self.bgColor = Color.blue},
                .cancel()
            ]
            )
            
//            ActionSheet(title: Text("Action"), message: Text("Quote mark"), buttons: [.default(Text("Show Sheet"))])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
