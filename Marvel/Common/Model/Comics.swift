//
//  Comics.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//

import Foundation

struct Comics: Decodable {
    let available: Int?
    let collectionURI: String?
    let items: [ComicsItem]?
    let returned: Int?
}
