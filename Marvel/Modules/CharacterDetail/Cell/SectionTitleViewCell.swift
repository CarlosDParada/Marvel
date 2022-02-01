//
//  SectionTitleViewCell.swift
//  Marvel
//
//  Created by Carlos Parada on 31/01/22.
//

import UIKit

class SectionTitleViewCell: UITableViewCell {
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    var title: String? {
        didSet {
            loadCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadCell() {
        titleLabel.text = title
        let colors: [UIColor] = [.chocolateCosmos, .cyanAzure, .fireEngineRed, .vividAuburn]
        baseView.backgroundColor = colors[Int.random(in: 0..<3)]
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
       
    }
    
}
