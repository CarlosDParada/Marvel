//
//  BaseViewController.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit
import RxSwift
import RxCocoa

protocol IBaseViewController: AnyObject {
    func showActivityIndicator (show:Bool)
}

class BaseViewController: UIViewController {
    
    
    var disposeBag: DisposeBag = DisposeBag()
	override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}

extension BaseViewController {
    func showMessageInAlert(message: String ,
                            completion: (()-> Void)?) {
        self.showError(errorMessage: message, completion: completion)
    }
}

extension BaseViewController: IBaseViewController {
    
    func showActivityIndicator (show:Bool) {
        DispatchQueue.main.async {
            if let currentWindow:UIWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) {
                if show {
                    if let viewIndicator = currentWindow.viewWithTag(99) {
                        viewIndicator.removeFromSuperview()
                    }
                    let viewContainer = UIView(frame: CGRect(x: 0, y: 0,
                                                             width: ScreenSize.screenWidth,
                                                             height: ScreenSize.screenHeight))
                    viewContainer.tag = 99
                    viewContainer.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 0.50)
                    viewContainer.frame.origin = CGPoint(x: 0, y: 0)
                    let activityIndicator = UIActivityIndicatorView(style: .large)
                    activityIndicator.color = .systemRed
                    activityIndicator.startAnimating()
                    activityIndicator.center = viewContainer.center
                    viewContainer.addSubview(activityIndicator)
                    currentWindow.addSubview(viewContainer)
                } else {
                    let viewIndicator = currentWindow.viewWithTag(99)
                    viewIndicator?.removeFromSuperview()
                }
            }
        }
    }
}
