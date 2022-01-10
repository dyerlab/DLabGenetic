//
//  File.swift
//  
//
//  Created by Rodney Dyer on 1/10/22.
//

import Foundation

/// A ViewModel for Allele Frequency Materials
public class FrequencyViewModel {
    
    /// The name of the locus
    var locus: String
    
    /// The allele frequency components
    var parameters: [String: AlleleFrequencies] = [:]
    
    /// The initializer
    init( stratum: Stratum, level: String, locus: String ) {
        
        self.locus = locus
        
        for stratum in strata.substrataAtLevel( named: level ) {
            if let site = strata.substratum(named: stratum ) {
                let loci = site.individuals.compactMap { $0.loci[locus] }
                parameters[ stratum ] = AlleleFrequencies(loci: loci )
            }
        }
    }
    
    
}
