//
//  File.swift
//  
//
//  Created by Rodney Dyer on 1/10/22.
//

import Foundation

/// A ViewModel object for displaying Genetic Diversity parametes by locus and stratum.
public class \el {
    
    /// Parameters for each stratum level
    var parameters: [String: DiversityViewModel] = [:]
    
    /// The locus being examined
    var locus: String
    
    /// Designated Initializer
    init( stratum: Stratum, level: String, locus: String ) {
        self.locus = locus
        let freqs = FrequencyViewModel(stratum: Stratum, level: level, locus: locus)
        for (key,val) in freqs.parameters {
            parameters[key] = DiversityParameters(frequencies: val )
        }
    }
    
}
