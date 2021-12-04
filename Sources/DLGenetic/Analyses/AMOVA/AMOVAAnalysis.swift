//
//  File.swift
//  GeneticStudio
//
//  Created by Rodney Dyer on 11/28/21.
//

import Foundation
import DLMatrix

class AMOVAAnalysis {
    var individuals: [Individual]
    var name: String  = "Analysis of Molecular Variance"
    var D: Matrix
    var count: Int {
        return individuals.count
    }
    
    var partitionName: String {
        didSet {
            var ss: Double = 0.0
            for (_, inds) in self.individuals.partition(by: self.partitionName ) {
                ss += Matrix(individuals: inds ).SS
            }
            self.SSModel = ss
        }
    }
    
    var dfTotal: Int {
        return self.count - 1
    }
    
    var dfModel: Int {
        return individuals.levelsForStratum(key: partitionName).count - 1
    }
    
    var dfError: Int {
        return dfTotal - dfModel
    }
    
    var SSTotal: Double {
        if count < 1 {
            return Double.infinity
        }
        return D.SS
    }
    
    var SSModel: Double
    
    var SSError: Double {
        return SSTotal - SSModel
    }
    
    var MSModel: Double {
        if dfModel == 0 {
            return Double.infinity
        }
        return SSModel / Double(dfModel)
    }
    
    var MSError: Double {
        if dfError == 0 {
            return Double.infinity
        }
        return SSError / Double(dfError)
    }
    
    
    init( individuals: [Individual] ) {
        self.individuals = individuals
        D = Matrix(individuals: individuals)
        self.SSModel = 0.0
        self.partitionName = individuals.strataKeys.first!
        
        print( D.submatrix( [1,2,3,4,5,6,7,8,9,10], [1,2,3,4,5,6,7,8,9,10]))
    }
    
    
    func partitionBy( stratum: String) -> String {
        self.partitionName = stratum
        return stratum.capitalized
    }
}
