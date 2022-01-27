//
//  Stories.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//

import Foundation

struct Stories: Decodable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}


