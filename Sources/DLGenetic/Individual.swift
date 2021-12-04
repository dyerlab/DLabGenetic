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
//  Individual.swift
//
//  Created by Rodney Dyer on 10/27/21.
//  Copyright (c) 2021 Rodney J Dyer.  All Rights Reserved.
//

import Foundation
import CoreLocation

class Individual: Identifiable, Codable, Hashable, Equatable {
    
    var id: UUID
    var location: CLLocationCoordinate2D
    var strata = [String:String]()
    var loci = [String:Locus]()
    
    enum CodingKeys: String, CodingKey {
        case id
        case latitude
        case longitude
        case strata
        case loci
    }
    
    init() {
        self.id = UUID()
        self.location  = CLLocationCoordinate2DMake(0.0, 0.0)
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self )
        id = try values.decode( UUID.self , forKey: .id )
        strata = try values.decode( Dictionary.self, forKey: .strata )
        loci = try values.decode( Dictionary.self, forKey:  .loci )
        let lon = try values.decode( Double.self, forKey: .longitude )
        let lat = try values.decode( Double.self, forKey: .latitude )
        self.location = CLLocationCoordinate2DMake(lat, lon)
    
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self )
        try container.encode( id, forKey: .id )
        try container.encode( strata, forKey: .strata )
        try container.encode( loci, forKey: .loci )
        try container.encode( location.latitude, forKey: .latitude )
        try container.encode( location.longitude, forKey: .longitude )
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine( self.id )
    }
    
    
    static func == (lhs: Individual, rhs: Individual) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    func setValueForKey( key: String, value: String) {
        if loci.keys.contains( key ) {
            loci[key, default: Locus() ].setAlleles(values: value )
        }
        else if strata.keys.contains( key ) {
            strata[key, default: "" ] = value
        }
        else if key == "Longitude" {
            location.longitude = Double( value.numericDecimalString ) ?? 0.0
        }
        else if key == "Latitude" {
            location.latitude = Double( value.numericDecimalString ) ?? 0.0
        }
    }
    
    
    func dataForKey( key: String) -> String {
        if loci.keys.contains( key ) {
            return loci[key]?.description ?? ""
        }
        else if strata.keys.contains( key ) {
            return strata[key] ?? ""
        }
        else if key == "Longitude" {
            return String(format: "%.4f", location.longitude)
        }
        else if key == "Latitude" {
            return String(format: "%.4f", location.latitude)
        }
        else {
            return "-NA-"
        }
    }
    
}






extension Individual: CustomStringConvertible {
    var description: String {
        var ret = ""
        
        var keys = self.strata.keys.sorted() 
        if keys.contains("Population") {
            keys.removeAll(where: {$0 == "Population"})
            keys.append("Population")
        }
        
        for key in keys {
            ret += String( "\(strata[key, default: ""]) ")
        }
        ret += String("\(location.longitude) \(location.latitude) ")
        for key in loci.keys.sorted() {
            ret += String( "\(loci[key, default: Locus()]) ")
        }
        return ret
    }
}



// Mark: - Genetic Distance Features
extension Individual {
    
    static func -(lhs: Individual, rhs: Individual) -> Double {
        var ret: Double = 0.0
        for key in lhs.loci.keys {
            let loc1 = lhs.loci[key, default: Locus()]
            let loc2 = rhs.loci[key, default: Locus()]
            ret += loc1 - loc2
        }
        return ret
    }
    
}
