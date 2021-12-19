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
//  Array+Individual.swift
//
//  Created by Rodney Dyer on 10/27/21.
//  Copyright (c) 2021 Rodney J Dyer.  All Rights Reserved.
//

import Foundation
import CoreLocation
import MapKit

import DLabMatrix


/**
 Extensions for arrays  of individuals
 */

extension Array where Element == Individual {

    
    var locusKeys: [String] {
        return self.first?.loci.keys.sorted() ?? [String]()
    }
    
    var allKeys: [String] {
        var ret = [String]()
        if let ind = self.first {
            ret.append(contentsOf: ["Longitude","Latitude"])
            ret.append(contentsOf: ind.loci.keys.sorted() )
        }
        return ret
    }
    
    var locations: [CLLocationCoordinate2D] {
        return self.compactMap{ $0.location }
    }
    
    var center: CLLocationCoordinate2D {
        return self.locations.center
    }
    
    var coordinateRegion: MKCoordinateRegion {
        return MKCoordinateRegion(coordinates:  self.locations )
    }
    
    /*
    func levelsForStratum( key: String ) -> [String] {
        return Set( self.map { $0.strata[ key, default: ""] } ).unique().sorted()
    }
     */
        
    func getLoci( named: String ) -> [Locus] {
        return self.compactMap{ $0.loci[named] }
    }
        
    /*
    func locales(stratum: String, values: [String] ) -> [Individual] {
        var ret = [Individual]()
        let groups = partition(by: stratum)
        for locale in values {
            ret.append(contentsOf: groups[locale, default: [Individual]() ] )
        }
        return ret
    }
    
    
    func frequenciesFor( locus: String ) -> AlleleFrequencies {
        return AlleleFrequencies(loci: self.compactMap( { $0.loci[locus] } ))
    }

    
    func frequenciesFor(locus: String, stratum: String, level: String) -> AlleleFrequencies {
        return individualsAtStratum(stratum: stratum, level: level).frequenciesFor(locus: locus )
    }
     
     */
   
    
    
}

