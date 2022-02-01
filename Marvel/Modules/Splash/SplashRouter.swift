//
//  SplashRouter.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit

protocol ISplashRouter: AnyObject {
    func navigateToCharacterList ()
}


class SplashRouter: ISplashRouter {
    
	weak var view: SplashViewController!
	
	init(view: SplashViewController?) {
		self.view = view
	}

    func navigateToCharacterList() {
        
        view.navigate(type: .modal(withNav: false), module: ApplicationRoutes.characterList)
    }
}
