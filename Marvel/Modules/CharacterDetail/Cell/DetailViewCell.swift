//
//  DetailViewCell.swift
//  Marvel
//
//  Created by Carlos Parada on 30/01/22.
//

import UIKit

class DetailViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    var item : GenericItem? {
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
        self.titleLabel.text = item?.name?.capitalized
    }
    @IBAction func actionOpenLink(_ sender: UIButton) {
        guard let url = URL(string: item?.resourceURI ?? "wwww.marvel.com") else { return }
        UIApplication.shared.open(url)
    }
}
