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
    static let darkBlue = colorOrFail("Dark Blue")
    static let lightBlue = colorOrFail("Light Blue")
    static let darkGreen = colorOrFail("Dark Green")
    static let lightGreen = colorOrFail("Light Green")
    static let pastelGreen = colorOrFail("Pastel Green")
    static let aquamarineBlue = colorOrFail("Aquamarine Blue")
    static let progressBackground = colorOrFail("Progress Background")
}
