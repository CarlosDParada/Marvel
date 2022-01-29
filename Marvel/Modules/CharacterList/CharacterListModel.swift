//
//  CharacterListModel.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit

struct CharacterListModel {
    
    struct Constants {
        static let limitSize = 50
        static let logoFooter = "img_city"
    }
    
	struct Request {
		// do someting...

		func parameters() -> [String: Any]? {
			// do someting...
			return nil
		}
	}

	struct Cells {
        static let listCell = "ListCollectionViewCell"
        static let cardCell = "CardCollectionViewCell"
	}
}

enum StyleCollection: Int {
    case list = 0
    case card
}
