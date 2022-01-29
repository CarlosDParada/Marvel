//
//  SplashInteractor.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit
import RxSwift
import RxCocoa


protocol ISplashInteractor: AnyObject {
    var parameters: [String: Any]? { get set }
    func initSplash()
    var errorMessageInt:PublishRelay<String> {get}
}

class SplashInteractor: ISplashInteractor{
    
    
    var presenter: ISplashPresenter?
    var manager: ISplashManager?
    var parameters: [String: Any]?
    var disposeBag: DisposeBag = DisposeBag()
    var errorMessageInt:PublishRelay<String>
    
    
    init(presenter: ISplashPresenter, manager: ISplashManager) {
        self.presenter = presenter
        self.manager = manager
        self.errorMessageInt = PublishRelay<String>()
        self.prepareCallback()
    }
    
    func initSplash() {
        self.presenter?.showActivityIndicator(state: true)
        self.manager?.checkAPIState(response: { principal in
            self.presenter?.showActivityIndicator(state: false)
            self.presenter?.loadData(legal: principal.attributionText ?? SplashModel.String.loading)
        })
    }
    
    func prepareCallback(){
        self.manager?.errorMessage.asObservable()
            .bind{value in
                let message = String(value.utf8)
                self.errorMessageInt.accept(message)
                self.presenter?.showActivityIndicator(state: false)
            }.disposed(by: disposeBag)
        
    }
}
