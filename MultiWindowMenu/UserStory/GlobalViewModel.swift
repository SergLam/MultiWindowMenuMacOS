//
//  GlobalViewModel.swift
//  MultiWindowMenuMacOS
//
//  Created by Serhii Liamtsev on 6/19/23.
//

import AppKit
import Combine
import Foundation
import SwiftUI

/// Global model for NSWindows tracking
final class GlobalViewModel : NSObject, ObservableObject {
    
    // all currently opened windows
    @Published var windows = Set<NSWindow>()
    
    // all view models that belong to currently opened windows
    // Use windowNumber as a key
    // https://developer.apple.com/documentation/appkit/nswindow/1419068-windownumber
    @Published var viewModels : [Int: ViewModel] = [:]
    
    // currently active aka selected aka key window
    @Published var activeWindow: NSWindow?
    
    // currently active view model for the active window
    @Published var activeViewModel: ViewModel?
    
    override init() {
        super.init()
        // deallocate a window when it is closed
        // thanks for this Maciej Kupczak 🙏
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onWillCloseWindowNotification(_:)),
            name: NSWindow.willCloseNotification,
            object: nil
        )
    }
    
    func addWindow(window: NSWindow) {
        window.delegate = self
        windows.insert(window)
    }
    
    // associates a window number with a view model
    func addViewModel(_ viewModel: ViewModel, forWindowNumber windowNumber: Int) {
        viewModels[windowNumber] = viewModel
    }
    
    // MARK: - Private
    
    @objc
    private func onWillCloseWindowNotification(_ notification: NSNotification) {
        guard let window = notification.object as? NSWindow else {
            return
        }
        var viewModels = self.viewModels
        viewModels.removeValue(forKey: window.windowNumber)
        self.viewModels = viewModels
    }
}

// MARK: - NSWindowDelegate

extension GlobalViewModel : NSWindowDelegate {
    
    func windowWillClose(_ notification: Notification) {
        if let window = notification.object as? NSWindow {
            windows.remove(window)
            viewModels.removeValue(forKey: window.windowNumber)
            print("Open Windows", windows)
            print("Open Models", viewModels)
            // windows = windows.filter { $0.windowNumber != window.windowNumber }
        }
    }
    
    func windowDidBecomeKey(_ notification: Notification) {
        if let window = notification.object as? NSWindow {
            print("Activating Window", window.windowNumber)
            activeWindow = window
            activeViewModel = viewModels[window.windowNumber]
        }
    }
}
