//
//  dyerlab.org                                          @dyerlab
//                      _                 _       _
//                   __| |_   _  ___ _ __| | __ _| |__
//                  / _` | | | |/ _ \ '__| |/ _` | '_ \
//                 | (_| | |_| |  __/ |  | | (_| | |_) |
//                  \__,_|\__, |\___|_|  |_|\__,_|_.__/
//                        |_ _/
//
//         Making Population Genetic Software That Doesn't Suck
//
//  GeneticStudio
//  Locus.swift
//
//  Created by Rodney Dyer on 12/17/21.
//  Copyright (c) 2021 Rodney J Dyer.  All Rights Reserved.
//

import Foundation

public class Stratum {
    
    /// The name of this particular stratum
    public var label: String
    
    /// The stratigraific level of this stratum
    public var level: String
    
    /// The parent of this stratum
    public weak var parent: Stratum?
    
    /// All the substrata under this one.
    var substrata: [Stratum] = []
    
    /// Individuals at this level
    var _individuals: [Individual] = []
    
    /// All individuals at this level and all other levels.
    public var individuals: [Individual] {
        if substrata.isEmpty {
            return self._individuals
        } else {
            var ret = [Individual]()
            for substratum in substrata {
                ret.append(contentsOf: substratum.individuals)
            }
            return ret
        }
    }
    
    /**
     Designated initializer.
     */
    public init(label: String, level: String = "Root" ) {
        self.label = label
        self.level = level
    }
        
    /**
     Add a substratum to this one.
     - Parameters:
        - stratum: The new stratum to add.
     */
    public func addSubstratum(stratum: Stratum) {
        stratum.parent = self
        self.substrata.append( stratum )
    }
    
    /**
     Return a substratum by name
     - Parameters:
        - named: The label of the Stratum being sought
     - Returns: The stratum or nil
     */
    public func substratum(named: String) -> Stratum? {
        if label == self.label { return self }
        
        for child in substrata {
            if let found = child.substratum(named: label ) {
                return found
            }
        }
        return nil
    }
    
    /**
     Returns substrata with passed names
     - Parameters:
        - named: A vector of names for strata
     - Returns: A Vector of Stratum
     */
    public func substrata( named: [String] ) -> [Stratum] {
        return named.compactMap{ self.substratum(named: $0) }
    }
    
    /**
     Just return individuals from named substrata
     - Parameters:
        - named: An array of named stratum from which to get individuals.
     - Returns: A single array of Individual objects
     */
    public func individualsFrom( named: [String] ) ->  [ Individual ] {
        var ret = [Individual]()
            
        for stratum in substrata(named: named) {
            ret.append(contentsOf: stratum.individuals )
        }
        
        return ret
    }
    
    
    /**
     Add individuals to this or some substratum.  This will automatically populate subgroups.
     - Parameters:
        - individual: The individual object class
        - stratum: A vector of strata names.
        - levels: A vector of level names.
     */
    public func addIndividual( individual: Individual, strata: [String], levels: [String] ) {
        
        if strata.count == 0 {
            self._individuals.append( individual )
        }
        else {
            var remainingStrata = strata
            var remainingLevels = levels
            
            let lvel = remainingLevels.removeFirst()
            let name = remainingStrata.removeFirst()
            
            
            if let stratum = self.substratum(named: name) {
                stratum.addIndividual(individual: individual,
                                      strata: remainingStrata,
                                      levels: remainingLevels)
            }
            else {
                let stratum = Stratum(label: name, level: lvel)
                stratum.addIndividual(individual: individual,
                                      strata: remainingStrata,
                                      levels: remainingLevels)
            }
        }
    }
    
    
    
}

extension Stratum: CustomStringConvertible {
    
    /// Overloading of the
    public var description: String {
        var ret = "\(label): with \(_individuals.count) ->\n"
        if !substrata.isEmpty {
            ret += " { " + substrata.map { $0.description }.joined(separator: ", ") + " } "
        }
        return ret
    }
    
}
