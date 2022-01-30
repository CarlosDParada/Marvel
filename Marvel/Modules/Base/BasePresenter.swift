//
//  BasePresenter.swift
//  Marvel
//
//  Created by Carlos Parada on 30/01/22.
//

import Foundation
import UIKit

protocol IBasePresenter: AnyObject {
    func showActivityIndicator(state: Bool)
}

class BasePresenter: IBasePresenter {
    
    func showActivityIndicator(state: Bool) {
        DispatchQueue.main.async {
            let sceneDelegate = UIApplication.shared.connectedScenes
                   .first!.delegate as! SceneDelegate
            if let currentVC = sceneDelegate.window?.rootViewController as? BaseViewController {
                currentVC.showActivityIndicator(show: state)
            }
        }
    }
    
}
