//
//  MultiWindowMenuApp.swift
//  MultiWindowMenuApp
//
//  Created by Ondrej Kvasnovsky on 7/3/21.
//

import SwiftUI

// https://ondrej-kvasnovsky.medium.com/multi-window-swiftui-macos-app-working-with-menu-commands-4aff7d6c3bd6
@main
struct MultiWindowMenuApp: App {
    
    @State var globalViewModel = GlobalViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.globalViewModel)
        }
        .commands {
            MenuCommands(globalViewModel: self.globalViewModel)
        }
        
        Settings {
            VStack {
                Text("My Settings View")
            }
        }
    }
}
