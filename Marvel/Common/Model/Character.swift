//
//  Character.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//
import UIKit

struct CharacterElement: Decodable {
    let id: Int?
    let name, characterDescription: String?
    let thumbnail: Thumbnail?
    let resourceURI: String?
    let comics, series: Comics?
    let stories: Stories?
    let events: Comics?
    let urls: [URLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case characterDescription
        case thumbnail, resourceURI, comics, series, stories, events, urls
    }
}
