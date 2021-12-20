//
//  File.swift
//  
//
//  Created by Rodney Dyer on 12/20/21.
//

import Foundation
import DLabMatrix


func AMOVADistance( ind1: Individual, ind2: Individual) -> Double {
    var dist: Double = 0.0
    
    for locus in Array(ind1.loci.keys) {
        
        if let lhs = ind1.loci[locus],
           let rhs = ind2.loci[locus] {
            
            dist += AMOVADistance(loc1: lhs, loc2: rhs)

        }
    }
    
    return dist
}


func AMOVADistance( loc1: Locus, loc2: Locus) -> Double {
    
    if loc1.isEmpty || loc2.isEmpty || loc1 == loc2 {
        return 0.0 
    }
    var allAlleles = loc1.alleles
    allAlleles.append(contentsOf: loc2.alleles )
    let allelesToSet: [String] = Set<String>( allAlleles ).unique()
    
    let x = loc1.asVector(alleles: allelesToSet )
    let y = loc2.asVector(alleles: allelesToSet )
    return ((x - y).map { $0 * $0 }).sum / 2.0
}

