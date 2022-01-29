//
//  VCAlertExtension.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//  Copyright (c) 2022 CARL. All rights reserved.


import UIKit


/**
 * If it is necessary, it might be changed the message at the button(s), title or message
 */
extension UIViewController {
    /**
     * It may be used to show native alert to information in the application. Each UIAlertAction can override its behavior.
     * 
     * - Precondition: if both bottons are nil, it will be showed an only button without action and 'Ok' as title of the button.
     * - Parameters:
     *      - title: Title of the alert
     *      -  message: Mesage of the alert
     *      - leftAction: Left button appareance and behaivor.
     *      - rightAction: Left button appareance and behaivor.
     */
    func showMessage(title: String? = nil, message: String? = nil, leftAction: UIAlertAction? = nil, rightAction: UIAlertAction? = nil) {
       let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
       
       if let leftAction = leftAction {
           alert.addAction(leftAction)
       }
       
       if rightAction == nil {
           let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
           alert.addAction(defaultAction)
       } else {
           alert.addAction(rightAction!)
       }
       
       DispatchQueue.main.async(execute: {
           self.present(alert, animated: true)
       })
    }
       
    /**
     * Show an alert error
     *
     * - Parameters:
     *      - errorMessage: Body message of the alert.
     *      - completion: Cloasure to define the action of the botton.
     */
    func showError(errorMessage: String? = nil, completion: (()-> Void)? = nil) {
        let message = errorMessage == nil ?  "A system error has occurred, try again later" : errorMessage
        showMessage(title: "Error",
                    message: message,
                    rightAction: UIAlertAction(title: "Accept",
                                               style: .cancel,
                                               handler: { (action) in
                       completion?()
                    }))
   }
}
