//
//  customView.swift
//  pokedex
//
//  Created by Daniel Stagnaro on 7/24/16.
//  Copyright © 2016 Daniel Stagnaro. All rights reserved.
//

import UIKit

@IBDesignable
class customView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 6.0 {
        didSet{
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    
}












