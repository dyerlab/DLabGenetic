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
//  AlleleFrequencies.swift
//
//  Created by Rodney Dyer on 10/27/21.
//  Copyright (c) 2021 Rodney J Dyer.  All Rights Reserved.
//

import Foundation

class AlleleFrequencies {
    
    private var counts = [String:Double]()
    private var n = 0.0
    private var numHets = 0.0
    private var numDiploid = 0.0
    
    var frequencies: [Double] {
        return frequenciesFor(alleles: self.alleles)
    }
    
    var A: Int {
        return counts.count
    }
    
    var A95: Int {
        var ret: Int = 0
        for f in self.frequencies {
            if f >= 0.05 {
                ret += 1
            }
        }
        return ret
    }
    
    var Ae: Double {
        let bot = self.He
        if bot == 0.0 {
            return 1.0
        } else {
            return 1.0 / (1.0 - bot)
        }
    }
    
    var Ho: Double {
        return numDiploid > 0 ? numHets / numDiploid : 0.0
    }
    
    var He: Double {
        let p = frequenciesFor(alleles: counts.keys.sorted() ).map{ $0 * $0 }
        return 1.0 - p.reduce(0.0, +)
    }
    
    var F: Double {
        let bot = self.He
        return bot != 0.0 ? 1.0 - Ho/bot : 0.0 
    }
    
    var alleles: [String] {
        get {
            return counts.keys.sorted {$0.localizedStandardCompare($1) == .orderedAscending}
        }
        set {
            for toAdd in Set(newValue).subtracting( counts.keys ) {
                counts[toAdd] = 0.0
            }
        }

    }
    
    
    
    
    init() {}
    
    init( loci: [Locus] ) {
        for locus in loci {
            self.addLocus(loc: locus )
        }
    }
    
    
    func addLocus( loc: Locus ) {
        
        if loc.ploidy > 1 {
            numDiploid += 1.0
            if loc.isHeterozygote {
                numHets += 1.0
            }
        }
        
        for allele in loc.alleles {
            if !allele.isEmpty {
                n += 1.0
                counts[allele, default: 0.0] += 1.0
            }
        }
    }
    
    func frequency( allele: String) -> Double {
        if n == 0.0 {
            return 0.0
        } else {
            return counts[allele, default: 0.0] / n
        }
    }
    
    func frequenciesFor( alleles: [String] ) -> [Double] {
        var ret = [Double]()
        
        for allele in alleles {
            ret.append( frequency(allele: allele ))
        }
        return ret
    }
}




extension AlleleFrequencies: CustomStringConvertible {
    
    var description: String {
        var ret = "Alleles = [" + self.alleles.joined(separator: ", ") + "]\n"
        ret += String("A: \(self.A)\n")
        ret += String("A95: \(self.A95)\n")
        ret += String("Ae: \(self.Ae)\n")
        ret += String("Ho: \(self.Ho)\n")
        ret += String("He: \(self.He)\n")
        ret += String("F: \(self.F)\n")
        return ret
    }
    
}




extension AlleleFrequencies {
    
    static func DefaultFrequencies() -> AlleleFrequencies {
        let loci = DefaultIndividuals().compactMap{ $0.loci["LTRS"] }
        let freqs = AlleleFrequencies(loci: loci )
        return freqs
    }
}

