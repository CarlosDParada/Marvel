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
    func addMoreCharacters()
    var errorMessageInt:PublishRelay<String> {get}
    
}

class CharacterListInteractor: ICharacterListInteractor {
    var characters: [CharacterElement]
    var presenter: ICharacterListPresenter?
    var manager: ICharacterListManager?
    var parameters: [String : Any]?
    var errorMessageInt:PublishRelay<String>
    
    private var isLoadingPokemons = false
    private var page = 1
    private var isLastPage = false

    init(presenter: ICharacterListPresenter, manager: ICharacterListManager) {
    	self.presenter = presenter
    	self.manager = manager
        self.errorMessageInt = PublishRelay<String>()
        self.characters = [CharacterElement]()
    }
    
    func addCharacters(page:Int) {
        isLoadingPokemons = true
        self.presenter?.showActivityIndicator(state: true)
        let group = DispatchGroup()
        group.enter()
        self.manager?.loadCharacters(page: page, response: { globalResp in
            if ((page + 1) * CharacterListModel.Constants.limitSize) >= globalResp.data?.total ?? 0 {
                self.isLastPage = true
            }
            let chras : [CharacterElement] = globalResp.data?.results ?? [CharacterElement]()
            self.characters.append(contentsOf: chras)
            

            group.leave()
        })
        group.notify(queue: .main) {
//            DispatchQueue.main.async {
                self.presenter?.reloadCollectionView()
//                self.presenter?.showActivityIndicator(state: false)
                self.isLoadingPokemons = false
                self.presenter?.showActivityIndicator(state: false)
//            }
        }
    }
    func addMoreCharacters() {
        guard !isLoadingPokemons && !isLastPage else { return }
        addCharacters(page: page)
        page += 1
    }
}
