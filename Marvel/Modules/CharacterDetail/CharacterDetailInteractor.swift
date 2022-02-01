//
//  CharacterDetailInteractor.swift
//  Marvel
//
//  Created by Carlos Parada on 30/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit
import RxSwift
import RxCocoa

protocol ICharacterDetailInteractor: AnyObject {
	var character: CharacterElement? { get set }
    var errorMessageInt:PublishRelay<String> {get}
    func getNumberOfRows(by section: Int) -> Int
    func getSections() -> Int
    func getItemDetail(by sectionPath: IndexPath) -> GenericItem
    func getProductType(by section: Int) -> StatsSections
}

class CharacterDetailInteractor: ICharacterDetailInteractor {
    var presenter: ICharacterDetailPresenter?
    var manager: ICharacterDetailManager?
    var disposeBag: DisposeBag = DisposeBag()
    var errorMessageInt:PublishRelay<String>
    
    var character: CharacterElement? {
        didSet{
            setNumberSection()
        }
    }
    private var sectionKeys = [StatsSections]()
    private var sections = [StatsSections: [GenericItem]]() {
        didSet { sectionKeys = Array(sections.keys.sorted()) }
    }
    init(presenter: ICharacterDetailPresenter, manager: ICharacterDetailManager) {
    	self.presenter = presenter
    	self.manager = manager
        self.errorMessageInt = PublishRelay<String>()
    }
    
    
}

extension CharacterDetailInteractor {
    
    /// load the sections
    func setNumberSection(){
        if character?.comics?.available ?? 0 > 0 {
            sections[.comics] = self.character?.comics?.items
        }
        if character?.series?.available ?? 0 > 0 {
            sections[.series] = self.character?.series?.items
        }
        if character?.stories?.available ?? 0 > 0 {
            sections[.stories] = self.character?.stories?.items
        }
        if character?.events?.available ?? 0 > 0 {
            sections[.events] = self.character?.events?.items
        }
        
    }
    
    func getSections() -> Int {
        sectionKeys.count
    }
    
    func getItemDetail(by sectionPath: IndexPath) -> GenericItem {
        let section = sectionPath.section
        let productKeys = sectionKeys[section]
        let detailKey : StatsSections = StatsSections(rawValue: productKeys.rawValue) ?? .other
        let item : GenericItem = sections[detailKey]?[sectionPath.row] ?? GenericItem.init(resourceURI: "", name: "Marvel", type: "Marvel") 
        return item
    }
    
    func getNumberOfRows(by section: Int) -> Int {
        let productKeys = sectionKeys[section]
        let detailKey : StatsSections = StatsSections(rawValue: productKeys.rawValue) ?? .other
        return sections[detailKey]?.count ?? 0
    }
    
    func getProductType(by section: Int) -> StatsSections {
        let productKeys = sectionKeys[section]
        let detailKey : StatsSections = StatsSections(rawValue: productKeys.rawValue) ?? .other
        return detailKey 
    }
}
