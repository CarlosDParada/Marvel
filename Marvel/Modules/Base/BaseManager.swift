//
//  BaseManager.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation
import RxSwift
import RxCocoa

protocol IBaseManager: AnyObject {
    var errorMessage:PublishRelay<String> {get}
}

class BaseManager: IBaseManager {
    var errorMessage: PublishRelay<String> = PublishRelay<String>()
    
    func showError(error: Error) {
        validateCoreError(coreError: error)
    }
    
    func validateCoreError(coreError:Error?){
        if let coreError = coreError {
            let message = String(format: BaseModel.Message.badConnection.localized(usingFile: StringsFiles.base), "MARVEL APP\n\(coreError.localizedDescription)")
            let error = ErrorResult.network(string: message, code: BaseModel.Constants.badConnection)
            self.errorMessage.accept(error.localizedDescription)
        }
    }
}
