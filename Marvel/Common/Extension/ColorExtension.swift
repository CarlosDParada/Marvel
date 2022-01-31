//
//  ColorExtension.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//

import Foundation
import UIKit

extension UIColor {
    static func colorOrFail(_ name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            fatalError("Cannot find color named \(name)")
        }
        return color
    }

    static let textColor = colorOrFail("TextColor")
    
    static let chocolateCosmos = colorOrFail("Chocolate Cosmos")
    static let vividAuburn = colorOrFail("Vivid Auburn")
    static let fireEngineRed = colorOrFail("Fire Engine Red")
    static let x11Gray = colorOrFail("X11 Gray")
    static let cyanAzure = colorOrFail("Cyan Azure")
    static let yankeesBlue = colorOrFail("Yankees Blue")
    
    static let progressBackground = colorOrFail("Progress Background")
}
