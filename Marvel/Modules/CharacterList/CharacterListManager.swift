//
//  CharacterListManager.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import Foundation
import UIKit

typealias SuccessListCallback = (PrincipalResponse<CharacterElement>) -> Void

protocol ICharacterListManager: IBaseManager {
    func loadCharacters(page: Int, response: @escaping SuccessListCallback)
}

class CharacterListManager: BaseManager, ICharacterListManager {
    
    private var page = 1
    private var isLastPage = false
    private var searchList = [PrincipalResponse<CharacterElement>]()
    private var lastSearchRequest: UUID? // Kepp track of the last request to update search results only one time
    
    func loadCharacters(page: Int, response: @escaping SuccessListCallback) {
        let pageSize = CharacterListModel.Constants.limitSize
        let charactersRequest = ApiRequest(resource:
                                            CharactersListResource(limit:pageSize,
                                                                   offset:page * pageSize))
        charactersRequest.load { result in
            switch result {
            case .success(let responseData):
                if (page + 1) * pageSize >= responseData.data?.count ?? 0 {
                    self.isLastPage = true
                }
                response(responseData)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError(error: error)
                }
            }
        }
    }

}
