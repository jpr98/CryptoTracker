//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Juan Pablo Ramos on 29/10/21.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
