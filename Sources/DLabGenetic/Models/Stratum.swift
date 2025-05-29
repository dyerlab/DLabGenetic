//
//  Stratum.swift
//  DLabGenetic
//
//  Created by Rodney Dyer on 5/29/25.
//

import SwiftData
import Foundation

@available(macOS 14, *)
@Model
public class Stratum {
    var name: String
    
    
    @Relationship var individuals: [Individual]
    
    init(name: String, individuals: [Individual] = [] ) {
        self.name = name
        self.individuals = individuals
    }
}
