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
    case characterDetail(character: CharacterElement)
}

extension ApplicationRoutes {
    var module: UIViewController? {
        switch self {
        case .characterList:
            return CharacterListConfiguration.setup()
        case .characterDetail(let characterSingle):
            return CharacterDetailConfiguration.setup(character: characterSingle)
            
        }
    }
}
