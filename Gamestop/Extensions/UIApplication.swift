//
//  UIApplication.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 05/10/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
