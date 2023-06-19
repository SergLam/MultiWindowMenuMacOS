//
//  HostingWindowFinder.swift
//  MultiWindowMenuMacOS
//
//  Created by Serhii Liamtsev on 6/19/23.
//

import AppKit
import SwiftUI

struct HostingWindowFinder: NSViewRepresentable {
    
    var callback: (NSWindow?) -> ()
    
    func makeNSView(context: Self.Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async { [weak view] in
            self.callback(view?.window)
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {}
}
