//
//  ViewModel.swift
//  multi-window-menu
//
//  Created by Ondrej Kvasnovsky on 7/3/21.
//

import Combine
import Foundation

public class ViewModel: ObservableObject {
    
    @Published var inputText: String = "" {
        didSet {
            print("content was updated...")
        }
    }
}
