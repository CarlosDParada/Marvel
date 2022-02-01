//
//  Character.swift
//  Marvel
//
//  Created by Carlos Parada on 27/01/22.
//
import UIKit

struct CharacterElement: Decodable ,Equatable {
    
    let id: Int?
    let name, description: String?
    let thumbnail: Image?
    let resourceURI: String?
    let comics: Comics?
    let series : SeriesList?
    let stories: StoryList?
    let events: Comics?
    let urls: [URLElement]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case description
        case thumbnail, resourceURI, comics, series, stories, events, urls
    }
    // swiftlint:disable identifier_name superfluous_disable_command
    static func == (lhs: CharacterElement, rhs: CharacterElement) -> Bool {
        return lhs.id == rhs.id 
    }
}
