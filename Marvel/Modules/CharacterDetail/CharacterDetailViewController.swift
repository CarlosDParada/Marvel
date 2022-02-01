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
    
    private let minHeight: CGFloat = 64
    private let maxHeight: CGFloat = 300
    private var previousScrollOffset: CGFloat = 0
    private let whiteViewMaxHeight: CGFloat = 180
    
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        registerCells()
    }
    private func registerCells() {
        tableView.register(UINib(nibName: CharacterDetailModel.Cells.detail, bundle: nil),
                           forCellReuseIdentifier: CharacterDetailModel.Cells.detail)
        tableView.register(UINib(nibName:  CharacterDetailModel.Cells.storie, bundle: nil),
                           forCellReuseIdentifier:  CharacterDetailModel.Cells.storie)
        tableView.register(UINib(nibName:  CharacterDetailModel.Cells.title, bundle: nil),
                           forCellReuseIdentifier:  CharacterDetailModel.Cells.title)
        
    }
    @IBAction func actionGoBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func loadData() {
        loadImage()
        smallTitleLabel.text = self.interactor?.character?.name
        bigTitleLabel.text = self.interactor?.character?.name
        
        if  self.interactor?.character?.description != "" {
            let infoLabel = UILabel()
            infoLabel.textAlignment = .left
            infoLabel.font = .systemFont(ofSize: 12)
            infoLabel.textColor = .white
            infoLabel.numberOfLines = 0
            infoLabel.backgroundColor = UIColor.chocolateCosmos.withAlphaComponent(0.1)
            if let description = self.interactor?.character?.description{
                infoLabel.text = description
                infoStackView.addArrangedSubview(infoLabel)
            }
        }
        
    }
    
    private func progressCollapse(_ newHeight: CGFloat) {
        let spaceRemaining = newHeight - minHeight
        let total = maxHeight - minHeight
        let progress = total - spaceRemaining
        characterImageView.alpha = 1 - (progress / (total - 100))
        whiteView.layer.cornerRadius = 48 * (1 - (progress / (total - 100)))
        whiteViewHeightConstraint.constant = whiteViewMaxHeight * (1 - (progress / (total - 50)))
        infoStackView.alpha = 1 - (progress / (total - 100))
        smallTitleLabel.alpha = (progress / (total - 100))
    }
}

extension CharacterDetailViewController: ICharacterDetailViewController {
    func writeLegalInfo(legal: String) {
        DispatchQueue.main.sync {
            if isViewLoaded {
                self.actionGoBack(UIButton.init())
            }
        }
    }
}
extension CharacterDetailViewController {
    private func loadImage() {
        let urlString = "\(self.interactor?.character?.thumbnail?.path ?? "").\(self.interactor?.character?.thumbnail?.thumbnailExtension ?? "")"
        DispatchQueue.main.async {
            ImageRequest.shared.load(imageUrlString: urlString, inViewImage: self.characterImageView)
        }
    }
}


extension CharacterDetailViewController : UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Implementing a collapsable header functionality was harder than expected.
        // Fortunately I found an article describing how to do it.
        // Thanks to Ahmed Bahgat
        // https://medium.com/@ahmedbahgatnabih/how-to-make-expandable-and-collapsible-header-for-tableview-in-swift-8ca82075acaa
        let scrollDiff = (scrollView.contentOffset.y - previousScrollOffset)
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
        if canAnimateHeader(scrollView) {
            var newHeight = headerHeightConstraint.constant
            if isScrollingDown {
                newHeight = max(minHeight, headerHeightConstraint.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(maxHeight, headerHeightConstraint.constant + abs(scrollDiff))
            }
            if newHeight != headerHeightConstraint.constant {
                headerHeightConstraint.constant = newHeight
                setScrollPosition()
                previousScrollOffset = scrollView.contentOffset.y
                progressCollapse(newHeight)
                view.layoutIfNeeded()
            }
        }
    }

    private func canAnimateHeader (_ scrollView: UIScrollView) -> Bool {
        let scrollViewMaxHeight = scrollView.frame.height + headerHeightConstraint.constant - minHeight
        return scrollView.contentSize.height > scrollViewMaxHeight
    }

    private func setScrollPosition() {
        self.tableView.contentOffset = CGPoint(x:0, y: 0)
    }
}

extension CharacterDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = self.interactor?.getNumberOfRows(by: section)
        return number ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.interactor?.getSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (self.interactor?.getProductType(by: indexPath.section) ?? .other != .stories){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailModel.Cells.detail) as? DetailViewCell else {
                fatalError("Cannor dequeue cell with reusable identifier \(CharacterDetailModel.Cells.detail)")
            }
            cell.item = self.interactor?.getItemDetail(by: indexPath)
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailModel.Cells.storie) as? StorieViewCell else {
                fatalError("Cannor dequeue cell with reusable identifier \(CharacterDetailModel.Cells.storie)")
            }
            cell.summary = self.interactor?.getItemDetail(by: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailModel.Cells.title) as? SectionTitleViewCell else {
            fatalError("Cannor dequeue cell with reusable identifier")
        }
        let type =  self.interactor?.getProductType(by: section)
        cell.title = type?.sectionTitle
        return cell
    }
    
}



