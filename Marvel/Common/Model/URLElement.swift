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
    let url: String?
}
