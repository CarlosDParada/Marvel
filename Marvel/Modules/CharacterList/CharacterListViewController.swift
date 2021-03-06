//
//  CharacterListViewController.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit

protocol ICharacterListViewController: AnyObject {
    var router: ICharacterListRouter? { get set }
    var collectionView: UICollectionView! { get }
    func reloadData()
}

class CharacterListViewController: BaseViewController {
    var interactor: ICharacterListInteractor?
    var router: ICharacterListRouter?
    var style : StyleCollection?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationBar: NavigationBar!
    
    private var isSearching: Bool {
        if let text = navigationBar.searchTextField.text, !text.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        prepareBinding()
        setCells()
        style = .list
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.interactor?.addCharacters(page: 0)
    }
    
    private func setCells() {
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: CharacterListModel.Cells.listCell, bundle: nil),
                                forCellWithReuseIdentifier: CharacterListModel.Cells.listCell)
        collectionView.register(UINib(nibName:  CharacterListModel.Cells.cardCell, bundle: nil),
                                forCellWithReuseIdentifier:  CharacterListModel.Cells.cardCell)
    }
}

extension CharacterListViewController: ICharacterListViewController {
    func reloadData() {
        self.collectionView.reloadData()
    }
    
}

extension CharacterListViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let charClick = self.interactor?.characters[indexPath.row] {
            self.router?.navigateToDetail(charClick)
        }
    }
}

extension CharacterListViewController :  UICollectionViewDataSource ,
                                        UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.interactor?.characters.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if style == .list {
            return createListCell(indexPath)
        } else {
            return createCardCell(indexPath)
        }
    }
    
    func createListCell(_ indexPath: IndexPath) ->  UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterListModel.Cells.listCell,
                                                      for: indexPath) as? ListCollectionViewCell
        if let charItem = self.interactor?.characters[indexPath.row] {
                 cell?.loadCell(character: charItem)
        }
        return cell ?? UICollectionViewCell()
    }
    
    func createCardCell(_ indexPath: IndexPath) ->  UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterListModel.Cells.cardCell,
                                                      for: indexPath) as? CardCollectionViewCell
        //        cell?.character = self.interactor?.characters[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if style == .list {
            return CGSize(width: (collectionView.frame.size.width), height: 60)
            
        } else {
            return CGSize(width: (collectionView.frame.size.width/2), height: (collectionView.frame.size.height/2) - 10)
            //UITableViewDataSourcePrefetching
        }
    }
    
}

extension CharacterListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard !isSearching else { return }
        if indexPaths.contains(where: { $0.row >= ((self.interactor?.characters.count ?? 0) - 10 )}) {
            self.interactor?.addMoreCharacters()
        }
    }
}

extension CharacterListViewController {
    func prepareBinding() {
        self.interactor?.errorMessageInt.asObservable()
            .bind { value in
                let message = String(value.utf8)
                self.showMessageInAlert(message: message) {
                    self.interactor?.addCharacters(page: 0)
                }
            }.disposed(by: disposeBag)
    }
}
