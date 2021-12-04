//
//  LocusTests.swift
//  Tests macOS
//
//  Created by Rodney Dyer on 11/28/21.
//

import XCTest
@testable import DLGenetic

final class LocusTests: XCTestCase {
   

    func testProperties() throws {

        let locNull = Locus()
        let locHap = Locus(raw: "A")
        let locAA  = Locus(raw: "A:A")
        let locAB  = Locus(raw: "A:B")
        let locAC  = Locus(raw: "C:A")
        
        XCTAssertEqual( locNull.ploidy, 0 )
        XCTAssertEqual( locNull.isEmpty, true )
        XCTAssertEqual( locNull.isHeterozygote, false )
        
        XCTAssertEqual( locHap.ploidy, 1 )
        XCTAssertEqual( locHap.isEmpty, false )
        XCTAssertEqual( locHap.isHeterozygote, false )
        
        XCTAssertEqual( locAA.isHeterozygote, false )
        XCTAssertEqual( locAC.isHeterozygote, true )
        
        XCTAssertEqual( locAA, locAA )
        XCTAssertNotEqual( locAA, locAB )
        
    }
    
    func testAMOVADistance() throws {
        
        let locNull = Locus()
        let locAA  = Locus(raw: "A:A")
        let locAB  = Locus(raw: "A:B")
        let locBB  = Locus(raw: "B:B")
        let locAC  = Locus(raw: "C:A")
        let locBC  = Locus(raw: "B:C")
        let locCD  = Locus(raw: "C:D")
     
        XCTAssertEqual( locAA - locAA, 0.0, accuracy: 0.00001 )
        XCTAssertEqual( locAA - locAB, 1.0, accuracy: 0.00001 )
        XCTAssertEqual( locAB - locAA, 1.0, accuracy: 0.00001 )
        XCTAssertEqual( locAA - locAC, 1.0, accuracy: 0.00001 )
        XCTAssertEqual( locAA - locBB, 4.0, accuracy: 0.00001 )
        XCTAssertEqual( locAB - locBC, 1.0, accuracy: 0.00001 )
        XCTAssertEqual( locAA - locBC, 3.0, accuracy: 0.00001 )
        XCTAssertEqual( locAB - locCD, 2.0, accuracy: 0.00001 )
        
        XCTAssertEqual( locNull - locAA, 0.0 )
        XCTAssertEqual( locAA - locNull, 0.0 )
        XCTAssertEqual( locNull - locAB, 0.0 )
        XCTAssertEqual( locAB - locNull, 0.0 )

    }

    
}
