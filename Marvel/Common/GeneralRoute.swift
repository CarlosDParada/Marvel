//
//  GeneralRoute.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//

import Foundation
import UIKit

enum ApplicationRoutes : IRouter {
    case characterList
}

extension ApplicationRoutes {
    var module: UIViewController? {
        switch self {
        case .characterList:
            return CharacterListConfiguration.setup()
            
        }
    }
}
