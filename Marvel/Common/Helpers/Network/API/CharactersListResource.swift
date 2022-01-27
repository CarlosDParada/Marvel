//
//  CharactersListResource.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//

import Foundation

struct CharactersListResource: ApiResource {
    typealias ModelType = PrincipalResponse<CharacterElement>

    var limit: Int
    var offset: Int
    var endpoint = "characters"

    init(limit: Int = 50, offset: Int = 0) {
        self.limit = limit
        self.offset = offset
    }

    var parameters: [String : String] {
        return ["limit": "\(limit)", "offset": "\(offset)"]
    }
}
