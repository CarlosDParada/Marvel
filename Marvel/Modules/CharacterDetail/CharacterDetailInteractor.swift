//
//  CharacterDetailInteractor.swift
//  Marvel
//
//  Created by Carlos Parada on 30/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit

protocol ICharacterDetailInteractor: AnyObject {
	var character: CharacterElement? { get set }
}

class CharacterDetailInteractor: ICharacterDetailInteractor {
    var presenter: ICharacterDetailPresenter?
    var manager: ICharacterDetailManager?
    var character: CharacterElement?

    init(presenter: ICharacterDetailPresenter, manager: ICharacterDetailManager) {
    	self.presenter = presenter
    	self.manager = manager
    }
}
