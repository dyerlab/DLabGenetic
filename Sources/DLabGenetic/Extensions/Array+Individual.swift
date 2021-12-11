//
//  File.swift
//  
//
//  Created by Rodney Dyer on 12/4/21.
//

import Foundation
import CoreLocation
import MapKit

import DLabMatrix


/**
 Extensions for arrays  of individuals
 */

extension Array where Element == Individual {
    
    var strataKeys: [String] {
        var keys = self.first?.strata.keys.sorted() ?? [String]()
        if keys.contains("Population") {
            keys.removeAll(where: {$0 == "Population"})
            keys.append("Population")
        }
        return keys
    }
    
    var allLevels: [String] {
        var ret = ["All"]
        ret.append(contentsOf: self.strataKeys)
        return ret
    }
    
    var locusKeys: [String] {
        return self.first?.loci.keys.sorted() ?? [String]()
    }
    
    var allKeys: [String] {
        var ret = self.strataKeys
        ret.append(contentsOf: ["Longitude","Latitude"])
        ret.append(contentsOf: self.locusKeys )
        return ret
    }
    
    var locations: [CLLocationCoordinate2D] {
        return self.map{ $0.location }
    }
    
    var center: CLLocationCoordinate2D {
        return self.locations.center
    }
    
    var coordinateRegion: MKCoordinateRegion {
        return MKCoordinateRegion(coordinates:  self.locations )
    }
    
    func levelsForStratum( key: String ) -> [String] {
        return Set( self.map { $0.strata[ key, default: ""] } ).unique().sorted()
    }
        
    func getLoci( named: String ) -> [Locus] {
        return self.compactMap{ $0.loci[named] }
    }
        
    func locales(stratum: String, values: [String] ) -> [Individual] {
        var ret = [Individual]()
        let groups = partition(by: stratum)
        for locale in values {
            ret.append(contentsOf: groups[locale, default: [Individual]() ] )
        }
        return ret
    }
    
    func partition( by: String )  -> [String: [Individual] ] {
        var ret = [String: [Individual] ]()
        if by == "All" {
            ret["All"] = self
        } else {
            for stratum in levelsForStratum(key: by) {
                ret[stratum] = self.filter{ $0.strata[by] == stratum }
            }
        }
        return ret
    }
    
    func frequenciesFor( locus: String ) -> AlleleFrequencies {
        return AlleleFrequencies(loci: self.compactMap( { $0.loci[locus] } ))
    }

    func frequenciesFor(locus: String, stratum: String, level: String) -> AlleleFrequencies {
        return individualsAtStratum(stratum: stratum, level: level).frequenciesFor(locus: locus )
    }

    func individualsAtStratum( stratum: String, level: String) -> [Individual] {
        return self.filter{ $0.strata[stratum] == level }
    }
    
    
    func designMatrixFor( stratum: String ) -> Matrix {
        let pops = self.compactMap{ $0.strata[ stratum ] }
        return Matrix.designMatrix(strata: pops)   
    }
    
}

