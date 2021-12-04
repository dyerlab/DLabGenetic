//
//  IndividualTests.swift
//  Tests macOS
//
//  Created by Rodney Dyer on 11/28/21.
//

import XCTest
import CoreLocation
@testable import DLGenetic

final class IndividualTests: XCTestCase {

    func testEquality() throws {
        
        let ind1 = Individual()
        ind1.loci["AAT"] = Locus(raw: "A:A")
        ind1.strata["Population"] = "RVA"
        ind1.location = CLLocationCoordinate2D(latitude: 38.0, longitude: -77.3)
        
        let ind2 = Individual()
        ind2.loci["AAT"] = Locus(raw: "A:B")
        ind2.strata["Population"] = "RVB"
        ind2.location = CLLocationCoordinate2D(latitude: 38.0, longitude: -77.2)
        
        XCTAssertFalse( ind1 == ind2 )
        XCTAssertEqual( ind1 - ind2, 1.0 )
        
    }


    func testAMOVAIndividuals() throws {
        
        let testBundle = Bundle(for: type(of: self))
        guard let filePath = testBundle.path(forResource: "arapat", ofType: "csv") else { fatalError() }
        let raw_inds = loadCSVFile(path: filePath, numStrata: 3, hasCoord: true, numLoci: 8)
        XCTAssertEqual( raw_inds.count, 363)
        
        let df = raw_inds.locales(stratum: "Population", values: ["101","102"] )
        let D = Matrix(individuals: df )
        XCTAssertEqual( D.rows, D.cols )
        XCTAssertEqual( D.rows, df.count )
        
        print("\(D)")
        
        let loci = df.locusKeys
        for ind in df {
            var ret = ind.strata["Population"]!
            for locus in loci {
                ret += String(" \(ind.loci[locus]! )" )
            }
            print( ret )
        }

    }
    
}
