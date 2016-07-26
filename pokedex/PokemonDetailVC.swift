//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Daniel Stagnaro on 7/21/16.
//  Copyright © 2016 Daniel Stagnaro. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIDLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var nextEvoTopLabel: UILabel!
    @IBOutlet weak var currentEvoLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoLabel: UILabel!
    @IBOutlet weak var nextEvoImage: UIImageView!
    
    @IBOutlet weak var loadingView: UIView!
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadingView.alpha = 0.7
        
        let pokeName = pokemon.name.capitalizedString
        let pokeImg = UIImage(named: "\(pokemon.pokedexId)")
        
        nameLabel.text = pokeName
        
        let idAsInt = Int(pokemon.pokedexId)
        let idWithZeros = String(format: "%03d", idAsInt!)
        
        pokedexIDLabel.text = "\(idWithZeros)"

        pokeImage.image = pokeImg

        descriptionLabel.text = "..."
        typesLabel.text = "..."
        defenseLabel.text = "..."
        heightLabel.text = "..."
        weightLabel.text = "..."
        baseAttackLabel.text = "..."
        speedLabel.text = "..."
        nextEvoTopLabel.text = "..."
        
        currentEvoLabel.text = pokeName
        currentEvoImage.image = pokeImg
        
        nextEvoLabel.text = ""
        nextEvoImage.image = UIImage(named: "")
        
        pokemon.downloadPokemonDetails { () -> () in
            // will be run later
            self.descriptionLabel.text = self.pokemon.description
            self.typesLabel.text = self.pokemon.types
            self.defenseLabel.text = self.pokemon.defense
            self.heightLabel.text = self.pokemon.height
//            self.pokedexIDLabel.text = "\(self.pokemon.pokedexId)"
            self.weightLabel.text = self.pokemon.weight
            self.baseAttackLabel.text = self.pokemon.attack
            self.speedLabel.text = self.pokemon.speed
            self.nextEvoTopLabel.text = self.pokemon.nextEvolutionText
            self.nextEvoLabel.text = self.pokemon.nextEvolutionName
            self.nextEvoImage.image = UIImage(named: "\(self.pokemon.nextEvolutionId)")
            
            self.loadingView.alpha = 0.0
            
        }
        
    }
    
    @IBAction func backPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
