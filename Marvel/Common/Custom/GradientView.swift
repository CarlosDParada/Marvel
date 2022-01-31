//
//  GradientView.swift
//  Marvel
//
//  Created by Carlos Parada on 30/01/22.
//

import Foundation
import UIKit

class GradientView: UIView {
    var colors: [UIColor] {
        get {
            guard let colors = backgroundLayer.colors as? [CGColor] else {
                return []
            }
            return colors.map { UIColor(cgColor: $0) }
        }

        set {
            backgroundLayer.colors = newValue.map(\.cgColor)
        }
    }

    var locations: [NSNumber] {
        get {
            backgroundLayer.locations ?? []
        }

        set {
            backgroundLayer.locations = newValue
        }
    }
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
    }
}
