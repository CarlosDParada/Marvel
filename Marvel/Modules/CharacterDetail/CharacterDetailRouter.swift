//
//  CharacterDetailRouter.swift
//  Marvel
//
//  Created by Carlos Parada on 30/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit

protocol ICharacterDetailRouter: AnyObject {
	// do someting...
}

class CharacterDetailRouter: ICharacterDetailRouter {	
	weak var view: CharacterDetailViewController?
	
	init(view: CharacterDetailViewController?) {
		self.view = view
	}
}
