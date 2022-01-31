//
//  InfoView.swift
//  Marvel
//
//  Created by Carlos Parada on 30/01/22.
//

import UIKit

class InfoView: UIView {
    
    private var backgroundLayer: CAGradientLayer = {
        let backgroundLayer = CAGradientLayer()
        
        let colors: [UIColor] = [.chocolateCosmos, .cyanAzure, .fireEngineRed, .vividAuburn]
        backgroundLayer.colors = colors.map(\.cgColor)
        backgroundLayer.locations = [0, 0.33, 0.66, 1]
        backgroundLayer.transform = CATransform3DMakeRotation(-.pi / 2 , 0, 0, 1)
        
        return backgroundLayer
    }()
    private var textTitle : String
    private var textValue : String = "#"
    
    private lazy var contentItemView: UIStackView = {
        
        let titleLabel = UILabel()
        titleLabel.text = textTitle
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 10)
        
        let valueLabel = UILabel()
        valueLabel.text = textValue
        valueLabel.textAlignment = .left
        valueLabel.font = .systemFont(ofSize: 10)
        valueLabel.textColor = .darkGray
        
        //titleLabel.translatesAutoresizingMaskIntoConstraints = false
        // valueLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
        
        let contentStackView = UIStackView(arrangedSubviews: [titleLabel , valueLabel])
        contentStackView.axis = .horizontal
        contentStackView.spacing = 0
        contentStackView.distribution = .fillEqually
        return contentStackView
    }()
    
    required init(title: String, value: String) {
        self.textTitle = title
        self.textValue = value
        super.init(frame: .zero)
        setup()
    }
    
    required override init(frame: CGRect) {
        self.textTitle = "##"
        self.textValue = "#"
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.textTitle = "##"
        self.textValue = "#"
        super.init(coder: aDecoder)
    }
    
    fileprivate func setup() {
        layer.addSublayer(backgroundLayer)
        configureContent()
    }
    private func configureContent() {
        addSubview(contentItemView)
        
        contentItemView.translatesAutoresizingMaskIntoConstraints = false
        
        contentItemView.translatesAutoresizingMaskIntoConstraints = false
        contentItemView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 1).isActive = true
        contentItemView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1).isActive = true
        contentItemView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 1).isActive = true
        contentItemView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 1).isActive = true
    }
}
