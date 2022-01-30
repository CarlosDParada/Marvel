//
//  CharacterDetailConfiguration.swift
//  Marvel
//
//  Created by Carlos Parada on 30/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import Foundation
import UIKit

class CharacterDetailConfiguration {
    static func setup(character: CharacterElement) -> UIViewController {
        let controller = CharacterDetailViewController()
        let router = CharacterDetailRouter(view: controller)
        let presenter = CharacterDetailPresenter(view: controller)
        let manager = CharacterDetailManager()
        let interactor = CharacterDetailInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor
        controller.router = router
        interactor.character = character
        return controller
    }
}
