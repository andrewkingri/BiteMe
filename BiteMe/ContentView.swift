//
//  ContentView.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .foregroundStyle(Color.coffee)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.cream)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
