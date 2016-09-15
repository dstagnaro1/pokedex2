//
//  PokeCell.swift
//  pokedex
//
//  Created by Daniel Stagnaro on 7/18/16.
//  Copyright © 2016 Daniel Stagnaro. All rights reserved.
//

import UIKit

@IBDesignable
class PokeCell: UICollectionViewCell {
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
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
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        
        let idAsInt = Int(pokemon.pokedexId)
        let idWithZeros = String(format: "%03d", idAsInt!)
        
//        nameLabel.text = "\(pokemon.name.capitalizedString) (\(pokemon.pokedexId))"
        nameLabel.text = "\(pokemon.name.capitalizedString) (\(idWithZeros))"


        pokeImage.image = UIImage(named: "\(pokemon.pokedexId)")
        ////
//        pokeImage.hidden = true ////
        ////
    }
}
