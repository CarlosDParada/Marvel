//
//  CharacterListPresenter.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit

protocol ICharacterListPresenter: AnyObject {
    func reloadCollectionView()
}

class CharacterListPresenter: ICharacterListPresenter {

    var view: ICharacterListViewController?
    
    var characters = [CharacterElement]()
	
	init(view: ICharacterListViewController?) {
		self.view = view
	}
    
    func reloadCollectionView() {
        self.view?.reloadData()
    }
}
