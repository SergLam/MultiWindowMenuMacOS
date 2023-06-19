//
//  ContentView.swift
//  multi-window-menu
//
//  Created by Ondrej Kvasnovsky on 7/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var globalViewModel : GlobalViewModel
    
    @StateObject var viewModel: ViewModel  = ViewModel()
    
    var body: some View {
        HostingWindowFinder { window in
            if let window = window {
                self.globalViewModel.addWindow(window: window)
                print("New Window", window.windowNumber)
                self.globalViewModel.addViewModel(self.viewModel, forWindowNumber: window.windowNumber)
            }
        }
        
        TextField("", text: $viewModel.inputText)
            .disabled(true)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
