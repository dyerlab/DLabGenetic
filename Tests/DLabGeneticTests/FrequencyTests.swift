//
//  FrequencyTests.swift
//  Tests macOS
//
//  Created by Rodney Dyer on 12/1/21.
//

import XCTest
@testable import DLabGenetic

final class FrequencyTests: XCTestCase {

   
    func testExample() throws {
   
       
        let raw_inds = DefaultIndividuals()
        XCTAssertEqual( raw_inds.count, 363)
        
        /*
        let df = raw_inds.locales(stratum: "Population", values: ["101","102"] )
        
        let zmp = AlleleFrequencies( loci: df.getLoci(named: "ZMP"))
        XCTAssertEqual( zmp.alleles, ["1"] )
        XCTAssertEqual( zmp.frequency(allele: "1"), 1.0 )
        XCTAssertEqual( zmp.frequency(allele: "2"), 0.0 )
        
        let aml = AlleleFrequencies( loci: df.getLoci(named: "AML") )
        XCTAssertEqual( aml.alleles, ["8","11"])
        XCTAssertEqual( aml.frequency(allele: "8"), 1.0 / 3.0 )
        XCTAssertEqual( aml.frequency(allele: "11"), 2.0 / 3.0 )
        
        
        print("\(aml)")
        */
    }
    
    
    

   

}
