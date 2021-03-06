//
//  NavigationBar.swift
//  Marvel
//
//  Created by Carlos Parada on 29/01/22.
//

import Foundation
import UIKit

class NavigationBar: UIView {
    private var backgroundLayer: CAGradientLayer = {
        let backgroundLayer = CAGradientLayer()

        let colors: [UIColor] = [.chocolateCosmos, .cyanAzure, .fireEngineRed, .vividAuburn]
        backgroundLayer.colors = colors.map(\.cgColor)
        backgroundLayer.locations = [0, 0.33, 0.66, 1]
        backgroundLayer.transform = CATransform3DMakeRotation(-.pi / 2 , 0, 0, 1)

        return backgroundLayer
    }()

    private var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()

    private var opaqueView: UIView = {
        let opaqueView = UIView()

        opaqueView.backgroundColor = .white
        opaqueView.alpha = 0.8

        return opaqueView
    }()

    var titleImage: UIImageView = {
        let image = UIImage(named: SplashModel.Constants.logoHeader)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()

        titleLabel.text = "MARVEL"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .red
        titleLabel.font = .boldSystemFont(ofSize: 20)

        return titleLabel
    }()

    var searchTextField: UITextField = {
        let searchTextField = UITextField()

        searchTextField.autocorrectionType = .no
        searchTextField.spellCheckingType = .no
        searchTextField.heightAnchor.constraint(equalToConstant: 36).isActive = true
        searchTextField.backgroundColor = UIColor.black.withAlphaComponent(0.12)
        searchTextField.layer.cornerRadius = 18
        searchTextField.placeholder = "Search"
        searchTextField.leftViewMode = .always

        let leftView = UIView()
        let searchImageView = UIImageView(image: UIImage(named: "search-icon"))

        leftView.addSubview(searchImageView)
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        searchImageView.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 11).isActive = true
        searchImageView.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 15).isActive = true
        searchImageView.trailingAnchor.constraint(equalTo: leftView.trailingAnchor, constant: -11).isActive = true
        searchImageView.bottomAnchor.constraint(equalTo: leftView.bottomAnchor, constant: -11).isActive = true

        searchTextField.leftView = leftView

        return searchTextField
    }()

    private lazy var contentStackView: UIStackView = {
        let contentStackView = UIStackView(arrangedSubviews: [titleImage])
        contentStackView.axis = .vertical
        contentStackView.spacing = 0
        contentStackView.distribution = .fillProportionally
        return contentStackView
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundLayer.frame = bounds
    }

    private func sharedInit() {
        layer.addSublayer(backgroundLayer)
        configureBlur()
        configureContent()
    }

    private func configureBlur() {
        addSubview(blurEffectView)
        addSubview(opaqueView)

        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true

        opaqueView.translatesAutoresizingMaskIntoConstraints = false
        opaqueView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        opaqueView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        opaqueView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        opaqueView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
    }

    private func configureContent() {
        addSubview(contentStackView)

        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
}
