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
    var summary : StorySummary?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func actionOpenLink(_ sender: UIButton) {
        
    }
    
}
