//
//  SplashInteractor.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit



protocol ISplashInteractor: AnyObject {
	var parameters: [String: Any]? { get set }
    func initSplash()
}

class SplashInteractor: ISplashInteractor {

    
    var presenter: ISplashPresenter?
    var manager: ISplashManager?
    var parameters: [String: Any]?

    init(presenter: ISplashPresenter, manager: ISplashManager) {
    	self.presenter = presenter
    	self.manager = manager
    }
    
    func initSplash() {
        self.manager?.checkAPIState(success: { principal in
            self.presenter?.loadData(legal: principal.attributionText ?? SplashModel.String.loading)
        })
    }
}
