//
//  StorieViewCell.swift
//  Marvel
//
//  Created by Carlos Parada on 30/01/22.
//

import UIKit

class StorieViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!

    var summary : GenericItem? {
        didSet {
            setTitleInCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitleInCell() {
        self.titleLabel.text = summary?.name?.capitalized
        self.typeLabel.text = getTitleType(typ: summary?.type ?? "")
    }
    
    func getTitleType(typ: String) -> String {
        let type = TypeStorie.withLabel(typ)
        return type?.rawValue ?? "Other"
    }
}

enum TypeStorie: String, CaseIterable {
    case interiorStory = "Interior Story"
    case cover = "Cover"
    
    static func withLabel(_ label : String) -> TypeStorie? {
        return self.allCases.first { "\($0)" == label }
    }
}
