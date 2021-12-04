//
//  FrequencyTests.swift
//  Tests macOS
//
//  Created by Rodney Dyer on 12/1/21.
//

import XCTest
@testable import DLGenetic

final class FrequencyTests: XCTestCase {

   
    func testExample() throws {
   
        let testBundle = Bundle(for: type(of: self))
        guard let filePath = testBundle.path(forResource: "arapat", ofType: "csv") else { fatalError() }
        let raw_inds = loadCSVFile(path: filePath, numStrata: 3, hasCoord: true, numLoci: 8)
        XCTAssertEqual( raw_inds.count, 363)
        let df = raw_inds.locales(stratum: "Population", values: ["101","102"] )
        
        let zmp = AlleleFrequencies( loci: df.getLoci(named: "ZMP"))
        XCTAssertEqual( zmp.alleles, ["1"] )
        XCTAssertEqual( zmp.frequency(allele: "1"), 1.0 )
        XCTAssertEqual( zmp.frequency(allele: "2"), 0.0 )
        XCTAssertEqual( zmp.Ho, 0.0 )
        XCTAssertEqual( zmp.He, 0.0 )
        XCTAssertEqual( zmp.F, 0.0 )
        
        let aml = AlleleFrequencies( loci: df.getLoci(named: "AML") )
        XCTAssertEqual( aml.alleles, ["8","11"])
        XCTAssertEqual( aml.frequency(allele: "8"), 1.0 / 3.0 )
        XCTAssertEqual( aml.frequency(allele: "11"), 2.0 / 3.0 )
        XCTAssertEqual( aml.Ae, 1.8, accuracy: 0.000001)
        XCTAssertEqual( aml.Ho, 0.0 )
        XCTAssertEqual( aml.He, 1.0 - ( pow( (1.0/3.0), 2.0) + pow( (2.0/3.0), 2.0 )   ) )
        XCTAssertEqual( aml.F, 1.0 )
        print("\(aml)")
        
    }

   

}
