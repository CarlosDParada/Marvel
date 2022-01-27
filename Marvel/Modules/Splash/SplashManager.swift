//
//  SplashManager.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import Foundation

typealias SuccessCheckAPICallback = (PrincipalResponse<CharacterElement>) -> Void

protocol ISplashManager: AnyObject {
    func checkAPIState(success: @escaping SuccessCheckAPICallback)
}

class SplashManager: ISplashManager {
    func checkAPIState( success: @escaping SuccessCheckAPICallback) {
        let checkAPI = ApiRequest(resource: CharactersListResource(limit: 1, offset:0))
        checkAPI.load { result in
            switch result {
            case .success(let data):
                success(data)
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
    
}
