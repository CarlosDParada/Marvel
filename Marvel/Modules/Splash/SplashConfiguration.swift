//
//  SplashConfiguration.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import Foundation
import UIKit

class SplashConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = SplashViewController()
        let router = SplashRouter(view: controller)
        let presenter = SplashPresenter(view: controller)
        let manager = SplashManager()
        let interactor = SplashInteractor(presenter: presenter, manager: manager)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
