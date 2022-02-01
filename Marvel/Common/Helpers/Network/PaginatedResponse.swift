//
//  PaginatedResponse.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//

import Foundation

struct PrincipalResponse<Type: Decodable> {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let etag: String?
    var data: PaginatedResponse<Type>?
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case copyright
        case attributionText
        case attributionHTML
        case data
        case etag
    }
    
}

extension PrincipalResponse: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decodeIfPresent(Int.self, forKey: .code)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.copyright = try container.decodeIfPresent(String.self, forKey: .copyright)
        self.attributionText = try container.decodeIfPresent(String.self, forKey: .attributionText)
        self.attributionHTML = try container.decodeIfPresent(String.self, forKey: .attributionHTML)
        self.data = try container.decodeIfPresent(PaginatedResponse<Type>.self, forKey: .data)
        self.etag = try container.decodeIfPresent(String.self, forKey: .etag)
    }
}

extension PrincipalResponse: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(code, forKey: .code)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(copyright, forKey: .copyright)
        try container.encodeIfPresent(attributionText, forKey: .attributionText)
        try container.encodeIfPresent(attributionHTML, forKey: .attributionHTML)
        try container.encodeIfPresent(data, forKey: .data)
        try container.encodeIfPresent(etag, forKey: .etag)
    }
}




struct PaginatedResponse<Type: Decodable> {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    var results: [Type]?
    
    enum CodingKeys: String, CodingKey {
        case offset
        case limit
        case total
        case count
        case results
    }
}

extension PaginatedResponse: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.offset = try container.decodeIfPresent(Int.self, forKey: .offset)
        self.limit = try container.decodeIfPresent(Int.self, forKey: .limit)
        self.total = try container.decodeIfPresent(Int.self, forKey: .total)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        self.results = try container.decodeIfPresent([Type].self, forKey: .results)
    }
}

extension PaginatedResponse: Encodable {
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(offset, forKey: .offset)
        try container.encodeIfPresent(limit, forKey: .limit)
        try container.encodeIfPresent(total, forKey: .total)
        try container.encodeIfPresent(count, forKey: .count)
//        try container.encodeIfPresent(results, forKey: .results)
    }
}
