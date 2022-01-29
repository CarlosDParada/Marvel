//
//  Thumbnail.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//

import Foundation

struct Image: Decodable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
