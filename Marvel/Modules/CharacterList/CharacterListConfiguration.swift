//
//  CharacterListConfiguration.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import Foundation
import UIKit

class CharacterListConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = CharacterListViewController()
        let router = CharacterListRouter(view: controller)
        let presenter = CharacterListPresenter(view: controller)
        let manager = CharacterListManager()
        let interactor = CharacterListInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
