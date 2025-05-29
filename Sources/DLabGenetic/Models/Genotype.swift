//
//  Genotype.swift
//  DLabGenetic
//
//  Created by Rodney Dyer on 5/29/25.
//

import SwiftData
import Foundation

@available(macOS 14, *)
@Model
public class Genotype {
    @Relationship var individual: Individual
    @Relationship var locus: Locus
    
    var leftAllele: String
    var rightAllele: String
    
    init(individual: Individual, locus: Locus, leftAllele: String, rightAllele: String) {
        self.individual = individual
        self.locus = locus
        self.leftAllele = leftAllele
        self.rightAllele = rightAllele
    }
    
}
