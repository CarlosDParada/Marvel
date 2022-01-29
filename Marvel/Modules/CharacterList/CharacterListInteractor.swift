//
//  CharacterListInteractor.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit
import RxSwift
import RxCocoa

protocol ICharacterListInteractor: AnyObject {
	var parameters: [String: Any]? { get set }
    var characters: [CharacterElement] { get set }
    func addCharacters(page:Int)
    var errorMessageInt:PublishRelay<String> {get}
}

class CharacterListInteractor: ICharacterListInteractor {
    var characters: [CharacterElement]
    var presenter: ICharacterListPresenter?
    var manager: ICharacterListManager?
    var parameters: [String : Any]?
    var errorMessageInt:PublishRelay<String>

    init(presenter: ICharacterListPresenter, manager: ICharacterListManager) {
    	self.presenter = presenter
    	self.manager = manager
        self.errorMessageInt = PublishRelay<String>()
        self.characters = [CharacterElement]()
    }
    
    func addCharacters(page:Int) {
        let group = DispatchGroup()
        group.enter()
        self.manager?.loadCharacters(page: page, response: { globalResp in
            let chras : [CharacterElement] = globalResp.data?.results ?? [CharacterElement]()
            self.characters.append(contentsOf: chras)
//            DispatchQueue.main.async {
//                self.presenter?.reloadCollectionView()
//            }
            group.leave()
        })
        group.notify(queue: .main) {
            DispatchQueue.main.async {
                self.presenter?.reloadCollectionView()
            }
        }
    }
}
