//
//  RoundedShadow.swift
//  UtilitiesModule
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import UIKit

public class RoundedShadowView: UIView {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        // Apply corner rounding
        layer.cornerRadius = 10
        
        // Apply shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        
        // To improve performance, add rasterization
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
