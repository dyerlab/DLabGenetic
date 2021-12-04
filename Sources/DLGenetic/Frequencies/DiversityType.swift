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
//  DiversityType.swift
//
//  Created by Rodney Dyer on 10/28/21.
//  Copyright (c) 2021 Rodney J Dyer.  All Rights Reserved.
//

import Foundation

/**
 An enum for specifying the diversity analysis so I can use a single ``DiversityForStrata`` implementation
    to cover all the potentaial 
 */
enum DiversityType: String {
    case Frequency
    case Allelic
    case Genotype
    case Spatial
}