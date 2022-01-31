//
//  ComicsItem.swift
//  Marvel
//
//  Created by Carlos Parada on 28/01/22.
//

import Foundation

struct GenericItem {
    let resourceURI: String?
    let name: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case name
        case type
    }
}

extension GenericItem: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.type = try container.decodeIfPresent(String.self, forKey: .type)
    }
}

extension GenericItem: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(resourceURI, forKey: .resourceURI)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(type, forKey: .type)
    }
}
