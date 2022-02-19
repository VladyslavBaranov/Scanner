//
//  ContentView.swift
//  Scanner
//
//  Created by EgorM on 20.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CameraView(viewModel: .init())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
