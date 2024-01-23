//
//  ColorGenerator.swift
//  Gamestop
//
//  Created by Aurelia Yacob on 23/01/24.
//

import SwiftUI

class ColorGenerator {
    public static func getColor(for genre: String) -> Color {
        switch genre {
        case "action":
            return Color("Fire")
        case "strategy":
            return Color("Poison")
        case "rpg":
            return Color("Water")
        case "shooter":
            return Color("Electric")
        case "adventure":
            return Color(.systemPurple)
        case "puzzle":
            return Color(.systemOrange)
        case "racing":
            return Color(.systemBrown)
        case "sports":
            return Color("Sky")
        default:
            return Color.theme.gray
        }
    }
}
