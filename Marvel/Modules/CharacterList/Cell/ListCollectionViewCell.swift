//
//  ListCollectionViewCell.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//

import UIKit

struct CellsModel {
    
    struct Title {
        static let movies:String = "movies_title"
        static let comics:String = "comics_title"
        static let events:String = "events_title"
        static let stories:String = "stories_title"
        static let series:String = "series_title"
    }
}


class ListCollectionViewCell: UICollectionViewCell {
    
    var characterLocal : CharacterElement?
    @IBOutlet weak var imageChar: UIImageView!
    @IBOutlet weak var nameChar: UILabel!
    @IBOutlet weak var stackTop: UIStackView!
    @IBOutlet weak var stackBottom: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func loadCell(character :CharacterElement? ){
        characterLocal = character
        nameChar.text = characterLocal?.name
        loadImage()
        loadStackViewInfo()
    }
    
    func loadStackViewInfo(){
        stackTop.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        stackBottom.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        stackBottom.isHidden = false
        stackTop.isHidden = false
        if characterLocal?.comics?.available ?? 0 > 0 {
            let title =  CellsModel.Title.comics.localized(usingFile: StringsFiles.info)
            addViewInStack(title: title, value: String(characterLocal?.comics?.available ?? 0), stackView: stackBottom)
        }
        if characterLocal?.series?.available ?? 0 > 0 {
            let title =  CellsModel.Title.series.localized(usingFile: StringsFiles.info)
            addViewInStack(title: title, value: String(characterLocal?.series?.available ?? 0), stackView: stackBottom)
            
        }
        if characterLocal?.stories?.available ?? 0 > 0 {
            let title =  CellsModel.Title.stories.localized(usingFile: StringsFiles.info)
            addViewInStack(title: title, value: String(characterLocal?.stories?.available ?? 0), stackView: stackBottom)
            
        }
        if characterLocal?.comics?.available ?? 0 == 0 && characterLocal?.series?.available ?? 0 == 0 && characterLocal?.stories?.available ?? 0 == 0  {
            stackBottom.isHidden = true
        }
        if characterLocal?.events?.available ?? 0 > 0 {
            let title =  CellsModel.Title.events.localized(usingFile: StringsFiles.info)
            addViewInStack(title: title, value: String(characterLocal?.events?.available ?? 0), stackView: stackTop)
            
        }else{
            stackTop.isHidden = true
        }
        
    }
    
    func addViewInStack(title : String, value : String, stackView: UIStackView){
        let infoView = InfoView(title: title, value: value)
        stackView.addArrangedSubview(infoView)
    }
    
    func loadImage(){
        let urlString = "\(characterLocal?.thumbnail?.path ?? "").\(characterLocal?.thumbnail?.thumbnailExtension ?? "")"
        if let url = URL(string: urlString) {
            ImageRequest.shared.load(with: urlString) { result in
                if let image = try? result.get() {
                    DispatchQueue.main.async {
                        self.imageChar.image = image
                    }
                }else{
                    print(">> Error Load Image \(url.absoluteString)")
                }
            }
        }
    }
}
