//
//  File.swift
//  
//
//  Created by Rodney Dyer on 1/10/22.
//

import Foundation

public class DiversitySummary {
    
    
    /// Parameters for each stratum level
    var parameters: [String: DiversitySummary] = [:]
    
    /// The locus being examined
    var locus: String
    
    
    /// Designated Initializer
    init( strata: Stratum, level: String, locus: String ) {
        
        self.locus = locus
        
        for stratum in strata.substrataAtLevel( named: level ) {
            if let site = strata.substratum(named: stratum ) {
                let loci = site.individuals.compactMap { $0.loci[locus] }
                let freqs = AlleleFrequencies(loci: loci )
                parameters[ stratum ] = DiversityParameters( frequencies: freqs )
            }
        }
        
    }
    
}
