//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Carlos Parada on 30/01/22.
//  Copyright (c) 2022 Carlos Parada. All rights reserved.

import UIKit

protocol ICharacterDetailViewController: IBaseViewController {
	var router: ICharacterDetailRouter? { get set }
}

class CharacterDetailViewController: BaseViewController {
	var interactor: ICharacterDetailInteractor?
	var router: ICharacterDetailRouter?

    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var bigTitleLabel: UILabel!
    @IBOutlet weak var descriptionStackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var whiteViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var smallTitleLabel: UILabel!
    
	override func viewDidLoad() {
        super.viewDidLoad()
		
        configureViewStyle()
        configureTableView()
        loadData()
    }
    
    private func configureViewStyle() {
        whiteView.layer.cornerRadius = 48
        characterImageView.layer.magnificationFilter = .nearest
        characterImageView.layer.minificationFilter = .nearest
    }

    private func configureTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.allowsSelection = false
//        tableView.separatorStyle = .none
        registerCells()
    }
    private func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "test")
//        tableView.register(UINib(nibName: "DetailInfoViewCell", bundle: nil), forCellReuseIdentifier: Constants.CellIds.infoCell)
   
    }
    
    private func loadData() {
//        self.interactor.loadImage(into: pokemonImageView)
        loadImage()
        smallTitleLabel.text = self.interactor?.character?.name
        bigTitleLabel.text = self.interactor?.character?.name
       
        if  self.interactor?.character?.description != "" {
            let infoLabel = UILabel()
            infoLabel.textAlignment = .left
            infoLabel.font = .systemFont(ofSize: 12)
            infoLabel.textColor = .white
            if let description = self.interactor?.character?.description{
                infoLabel.text = description
                infoStackView.addArrangedSubview(infoLabel)
            }
        }
        
    }
    
}

extension CharacterDetailViewController: ICharacterDetailViewController {
	// do someting...
}

extension CharacterDetailViewController {
    private func loadImage() {
        let urlString = "\(self.interactor?.character?.thumbnail?.path ?? "").\(self.interactor?.character?.thumbnail?.thumbnailExtension ?? "")"
        DispatchQueue.main.async {
            ImageRequest.shared.load(imageUrlString: urlString, inViewImage: self.characterImageView)
        }
    }
}


//extension CharacterDetailViewController : UITableViewDelegate {
//	// do someting...
//}
//
//extension CharacterDetailViewController : UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//}
