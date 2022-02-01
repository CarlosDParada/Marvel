//
//  SplashViewController.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit
import RxSwift

protocol ISplashViewController : IBaseViewController {
    var router: ISplashRouter? {get set}
    
    func writeLegalInfo(legal: String)
}

class SplashViewController: BaseViewController {
    var interactor: ISplashInteractor?
    var router: ISplashRouter?
    
    @IBOutlet weak var labelData: UILabel!
    let logoHeader = UIImageView(image: UIImage(named: SplashModel.Constants.logoHeader))
    let logoFooter = UIImageView(image: UIImage(named: SplashModel.Constants.logoFooter))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareBinding()
        startSplashValidation()
    }
    
    func startSplashValidation() {
        interactor?.initSplash()
    }
}

extension SplashViewController: ISplashViewController {
    func writeLegalInfo(legal: String) {
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.main.sync {
                labelData.text=legal
            group.leave()
        }
        group.notify(queue: .main) {
            self.router?.navigateToCharacterList()
        }
    }
    
}

extension SplashViewController {
    func prepareBinding() {
        self.interactor?.errorMessageInt.asObservable()
            .bind { value in
                let message = String(value.utf8)
                print(">> Error un baseVC \(message)")
                self.showMessageInAlert(message: message) {
                    self.startSplashValidation()
                }
            }.disposed(by: disposeBag)
    }
}
