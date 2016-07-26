//
//  Pokemon.swift
//  pokedex
//
//  Created by Daniel Stagnaro on 7/18/16.
//  Copyright © 2016 Daniel Stagnaro. All rights reserved.
//

import UIKit
import Alamofire

class Pokemon {
    private var _name: String!                  // filled
    private var _pokedexId: String!             // filled
    private var _description: String!           // filled
    private var _types: String!                 // filled
    private var _defense: String!               // filled
    private var _height: String!                // filled
    private var _weight: String!                // filled
    private var _attack: String!                // filled
    private var _speed: String!                 // filled
    private var _nextEvolutionName: String!     // filled
    private var _nextEvolutionText: String!     // filled
    private var _nextEvolutionId: String!       // filled
    
    private var _pokemonUrl: String!            // filled // This is not with the rest above, because they arent needed in other classes
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    var pokedexId: String {
        if _pokedexId == nil {
            _pokedexId = ""
        }
        return _pokedexId
    }
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var types: String {
        if _types == nil {
            _types = ""
        }
        return _types
    }
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    var speed: String {
        if _speed == nil {
            _speed = ""
        }
        return _speed
    }
    var nextEvolutionText: String {
        if _nextEvolutionText == nil {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    init(name: String, pokedexId: String) {
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON{ response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                if let speed = dict["speed"] as? Int {
                    self._speed = "\(speed)"
                }
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let name = types[0]["name"] {
                        self._types = name.capitalizedString
                    }
                    if types.count > 1 {
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"] {
                                self._types! += " / \(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._types = ""
                }
                
                if let nextEvolution = dict["evolutions"] as? [Dictionary<String, AnyObject>] where nextEvolution.count > 0 {
                    self._nextEvolutionText = "Next Evolution:"
                    
                    if let evolveTo = nextEvolution[0]["to"] as? String {
                        if evolveTo.rangeOfString("mega") == nil {
                            self._nextEvolutionName = evolveTo
                            self._nextEvolutionText! += " \(evolveTo)"
                            
                            if let levelEvolve = nextEvolution[0]["level"] {
                                self._nextEvolutionText! += " Level \(levelEvolve)"
                            }
                            
                            if let uri = nextEvolution[0]["resource_uri"] as? String {
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionId = num
                            }
                        } else {
                            self._nextEvolutionText = "No further Evolution"
                        }
                        
                        if evolveTo == "Clefairy" || evolveTo == "Pikachu" || evolveTo == "Jigglypuff" || evolveTo == "Hitmonchan" || evolveTo == "Chansey" || evolveTo == "Mr-mime" || evolveTo == "Electabuzz" || evolveTo == "Magmar"{
                            self._nextEvolutionName = ""
                            self._nextEvolutionId = ""
                            self._nextEvolutionText = "No further Evolution"
                        }
                    }
                } else {
                    self._nextEvolutionText = "No further Evolution"
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>] where descriptions.count > 0 {
                    if let descrURL = descriptions[0]["resource_uri"] {
                        
                        let pokeDescURL = "\(URL_BASE)\(descrURL)"
                        let descURL = NSURL(string: pokeDescURL)!
                        Alamofire.request(.GET, descURL).responseJSON{ response in
                            
                            let descResult = response.result
                            
                            if let descDict = descResult.value as? Dictionary<String, AnyObject> {
                                if let desc = descDict["description"] as? String {
                                    let noPOKMON = desc.stringByReplacingOccurrencesOfString("POKMON", withString: "pokémon")
                                    let noPOKEMON = noPOKMON.stringByReplacingOccurrencesOfString("POKEMON", withString: "pokémon")
                                    let noPokmon = noPOKEMON.stringByReplacingOccurrencesOfString("Pokmon", withString: "pokémon")
                                    
        let noUpperCaseName = noPokmon.stringByReplacingOccurrencesOfString(self.name.uppercaseString, withString: self.name.capitalizedString)
                                    
                                    self._description = noUpperCaseName
                                }
                            }
                            completed()
                        }
                    }
                } else {
                    self._description = ""
                }
            }
        }
    }
}


















