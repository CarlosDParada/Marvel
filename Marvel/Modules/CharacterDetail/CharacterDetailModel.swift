//
//  CharacterDetailModel.swift
//  Marvel
//
//  Created by Carlos Parada on 30/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit

struct CharacterDetailModel {
    
    struct Cells {
        static let detail = "DetailViewCell"
        static let storie = "StorieViewCell"
        static let title = "SectionTitleViewCell"
    }

}

enum StatsSections: Int, CaseIterable , Comparable {
    
    
    case comics = 0
    case series
    case stories
    case events
    case other
    
    var sectionTitle: String {
            switch self {
            case .comics: return "Comics ⚔️"
            case .series: return "Series 🎥"
            case .stories: return "Stories 🎉"
            case .events: return "Events 🥂"
            case .other: return "Other 💩"
            }
        }
    static func == (lhs: StatsSections, rhs: StatsSections) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    
    static func < (lhs: StatsSections, rhs: StatsSections) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

