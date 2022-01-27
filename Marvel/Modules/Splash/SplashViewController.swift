//
//  SplashViewController.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit

protocol ISplashViewController where Self : UIViewController {
    var router: ISplashRouter? {get set}
    
    func writeLegalInfo(legal: String)
}

class SplashViewController: UIViewController {
    var interactor: ISplashInteractor?
    var router: ISplashRouter?
    
    @IBOutlet weak var labelData: UILabel!
    let logoHeader = UIImageView(image: UIImage(named: SplashModel.Constants.logoHeader))
    let logoFooter = UIImageView(image: UIImage(named: SplashModel.Constants.logoFooter))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.initSplash()
    }
}

extension SplashViewController: ISplashViewController {
    func writeLegalInfo(legal: String) {
        DispatchQueue.main.sync {
            if isViewLoaded {
                labelData.text=legal
            }
        }
    }
    
}

extension SplashViewController {
    
}
