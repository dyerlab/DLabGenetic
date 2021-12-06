//
//  AMOVAMatrix.swift
//  GeneticStudio
//
//  Created by Rodney Dyer on 11/28/21.
//

import Foundation
import DLabMatrix

extension Matrix {
    
    convenience init(individuals: [Individual]) {
        let N = individuals.count
        self.init(N,N,0.0)
        
        for i in 0 ..< N {
            for j in (i+1) ..< N {
                let dist = individuals[i] - individuals[j]
                self[i,j] = dist
                self[j,i] = dist
            }
        }
    }
    
    
    
    var SS: Double {
        get {
            let N = self.cols
            let tot = self.sum
            return tot / (2.0 * (Double(N) - 1.0 ))
        }
    }
    
}
