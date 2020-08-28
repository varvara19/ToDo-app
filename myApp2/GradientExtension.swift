//
//  GradientExtension.swift
//  myApp2
//
//  Created by Sunrise Sunrise on 8/25/20.
//  Copyright © 2020 Sunrise Sunrise. All rights reserved.
//

import UIKit

extension UIView {
    
    func setGradientBackground() {
        clipsToBounds = true
        let colorBottom =  UIColor(red: 143.0/255.0, green: 109.0/255.0, blue: 253.0/255.0, alpha: 1.0).cgColor
        let colorTop = UIColor(red: 220.0/255.0, green: 134.0/255.0, blue: 229.0/255.0, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds

        self.layer.insertSublayer(gradientLayer, at:0)
        
        
    }
    
}
