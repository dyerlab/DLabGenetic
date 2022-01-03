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

public class Stratum: Codable  {
    
    /// The name of this particular stratum
    public var label: String
    
    /// The stratigraific level of this stratum
    public var level: String
    
    /// The parent of this stratum
    public weak var parent: Stratum?
    
    /// Is this a sampling locale (e.g., has individuals)
    public var isLocale: Bool {
        return _individuals.count > 0
    }
    
    /// Number of children at next level
    public var childCount: Int {
        return substrata.count
    }
    
    /// Sublevel Labels
    public var childLevel: String {
        return self.substrata.first?.level ?? "No Labels"
    }
    
    /// Nested Levels
    public var nestedLevels: [String] {
        var ret = [ self.level ]
        for stratum in self.substrata {
            ret.append(contentsOf: stratum.nestedLevels )
        }
        return Set<String>(ret).unique()
    }
    
    
    /// All the substrata under this one.
    var substrata: [Stratum] = []
    
    /// Individuals at this level
    var _individuals: [Individual] = []
    
    /// All individuals at this level and all other levels.
    public var individuals: [Individual] {
        var ret = [Individual]()
        
        if substrata.isEmpty {
            ret = self._individuals
        } else {
            for substratum in substrata {
                ret.append(contentsOf: substratum.individuals)
            }
        }
        return ret
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
        if named == self.label { return self }
        
        for child in substrata {
            if let found = child.substratum(named: named ) {
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
     Find the vector of stratum names for a given level
     */
    
    func stratumIdentifierForIndividuals( targetLevel: String ) -> [String] {
        var ret = [String]()
        if targetLevel == self.level {
            ret.append(contentsOf: Array(repeating: self.label, count: self.individuals.count))
        } else {
            for substratum in substrata {
                ret.append( contentsOf: substratum.stratumIdentifierForIndividuals(targetLevel: targetLevel) )
            }
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

        var substrata = strata
        var sublevels = levels
        
        if substrata.count == 0 {
            self._individuals.append( individual )
        } else {
            
            let nextStratum = substrata.removeFirst()
            let nextLevel = sublevels.removeFirst()
            if let child = substratum(named: nextStratum ) {
                child.addIndividual(individual: individual, strata: substrata, levels: sublevels)
            }
            else {
                let child = Stratum(label: nextStratum, level: nextLevel)
                self.addSubstratum(stratum: child )
                child.addIndividual(individual: individual, strata: substrata, levels: sublevels)
            }
        }
    }
}

extension Stratum: CustomStringConvertible {
    
    /// Overloading of the
    public var description: String {
        var ret = "\(label) {"
        if !substrata.isEmpty {
            ret += substrata.map { $0.description }.joined(separator: ", ")
        } else {
            ret += "N = \(_individuals.count) "
        }
        ret += "} "
        return ret
    }
    
}




