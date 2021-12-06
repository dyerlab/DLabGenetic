//
//  DiversityMeasures.swift
//  GeneticStudio
//
//  Created by Rodney Dyer on 10/30/21.
//  Copyright © 2021 Rodney J Dyer. All rights reserved.
//

import Foundation

struct DiversityMeasures: Codable, Hashable, Identifiable {
    var id = UUID()
    var stratum: String
    var A: Int
    var A95: Int
    var Ae: Double
    var Ho: Double
    var He: Double
    var F: Double
}
