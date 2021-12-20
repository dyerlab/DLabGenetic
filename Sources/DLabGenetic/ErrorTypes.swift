//
//  File.swift
//  
//
//  Created by Rodney Dyer on 12/20/21.
//

import Foundation


struct DLabGeneticErrors: Error {
    
    enum GeneticErrorType {
        case notFound
        case notComptable
    }
    
    let message: String
    let type: GeneticErrorType
}
