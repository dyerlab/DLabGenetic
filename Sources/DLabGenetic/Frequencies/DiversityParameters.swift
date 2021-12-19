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
//  DiversityParameters.swift
//
//  Created by Rodney Dyer on 10/27/21.
//  Copyright (c) 2021 Rodney J Dyer.  All Rights Reserved.
//

import Foundation

struct DiversityParameters: Codable, Hashable {

    var A: Int
    var A95: Int
    var Ae: Double
    var Ho: Double
    var He: Double
    var F: Double
    
    init( frequencies: AlleleFrequencies ) {
        let alleles = frequencies.alleles
        let freqs = frequencies.frequenciesFor(alleles: alleles )
        
        A = alleles.count
        A95 = freqs.filter{ $0 >= 0.05 }.count
        
        let p = frequencies.frequenciesFor(alleles: alleles ).map{ $0 * $0 }
        He = 1.0 - p.reduce(0.0, +)
        Ho = frequencies.numDiploid > 0 ? frequencies.numHets / frequencies.numDiploid : 0.0
        
        Ae = A > 0 ? 1.0 / (1.0 - He) : 0.0
        F = He > 0 ? 1.0 - Ho / He : 0.0
    }
}


extension DiversityParameters: CustomStringConvertible {
    
    var description: String {
        var ret = "DiversityParameters: \n"
        ret += String("A: \(A)\n")
        ret += String("A95: \(A95)\n")
        ret += String("Ae: \(Ae)\n")
        ret += String("Ho: \(Ho)\n")
        ret += String("He: \(He)\n")
        ret += String("F: \(F)\n")
        return( ret )
    }
}



