//
//  CSKorMedApp.swift
//  CSKorMed
//
//  Created by Sung Park on 7/1/23.
//

import SwiftUI
import MaleBody

@main
struct CSKorMedApp: App {
    @State var viewModel = ViewModel()
    
    init() {
        MaleBody.PointComponent.registerComponent()
        PointRuntimeComponent.registerComponent()
    }
    
    var body: some Scene {
        ImmersiveSpace {
            ContentView(viewModel: viewModel)
        }
    }
}
