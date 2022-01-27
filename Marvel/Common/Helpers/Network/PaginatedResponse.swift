//
//  PaginatedResponse.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//

import Foundation

struct PrincipalResponse<Type: Decodable>: Decodable {
    let code: Int
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    var data: PaginatedResponse<Type>
}

struct PaginatedResponse<Type: Decodable>: Decodable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    var results: [Type]
}
