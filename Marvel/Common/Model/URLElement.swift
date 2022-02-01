//
//  URLElement.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//

import Foundation

// MARK: - URLElement
struct URLElementArray: Decodable {
    let urls: [URLElement]?
    
}

struct URLElement: Decodable {
    let type: String?
    let urlUnq: String?
    
    enum CodingKeys: String, CodingKey {
        case type
        case urlUnq = "url"
    }
}
