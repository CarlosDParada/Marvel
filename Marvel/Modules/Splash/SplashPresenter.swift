//
//  SplashPresenter.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit

protocol ISplashPresenter: IBasePresenter {
    func loadData(legal: String)
}

class SplashPresenter: BasePresenter, ISplashPresenter {
    
	weak var view: ISplashViewController?
	
	init(view: ISplashViewController?) {
		self.view = view
	}
    
    func loadData(legal: String) {
        self.view?.writeLegalInfo(legal: legal)
    }

    
}
