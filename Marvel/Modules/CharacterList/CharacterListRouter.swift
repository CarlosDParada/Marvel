//
//  CharacterListRouter.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit

protocol ICharacterListRouter: AnyObject {
	// do someting...
}

class CharacterListRouter: ICharacterListRouter {	
	weak var view: CharacterListViewController?
	
	init(view: CharacterListViewController?) {
		self.view = view
	}
}
