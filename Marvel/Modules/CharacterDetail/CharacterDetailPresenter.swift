//
//  CharacterDetailPresenter.swift
//  Marvel
//
//  Created by Carlos Parada on 30/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit

protocol ICharacterDetailPresenter: IBasePresenter {
	// do someting...
}

class CharacterDetailPresenter: BasePresenter, ICharacterDetailPresenter {	
	weak var view: ICharacterDetailViewController?
	
	init(view: ICharacterDetailViewController?) {
		self.view = view
	}
}
