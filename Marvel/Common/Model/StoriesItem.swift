//
//  StoriesItem.swift
//  Marvel
//
//  Created by Carlos Parada on 28/01/22.
//

import Foundation

struct StoriesItem: Decodable {
    let resourceURI: String?
    let name: String?
    let type: TypeEnum?
}

enum TypeEnum: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}
