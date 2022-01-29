//
//  Utils.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//

import UIKit

struct ScreenSize {
    static let screenWidth         = UIScreen.main.bounds.width
    static let screenHeight        = UIScreen.main.bounds.height
    static let screenMaxLength    = max(ScreenSize.screenWidth, ScreenSize.screenHeight)
    static let screenMinLength    = min(ScreenSize.screenWidth, ScreenSize.screenHeight)
}

struct DeviceType {
    static let isIphone6OrLess = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength <= 667.0
}
