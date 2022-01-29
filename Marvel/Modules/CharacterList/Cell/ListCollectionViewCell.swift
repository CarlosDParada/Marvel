//
//  ListCollectionViewCell.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {

    var character : CharacterElement? {
        didSet{
            loadCell()
        }
    }
    @IBOutlet weak var imageChar: UIImageView!
    @IBOutlet weak var nameChar: UILabel!
    @IBOutlet weak var descriptionChar: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadCell(){
        nameChar.text = character?.name
        descriptionChar.text = character?.description
    }
    
//    func setupCellWith(character:CharacterElement ){
//        self.character = character
//        nameChar.text = character.name
//        descriptionChar.text = character.description
//    }
}
