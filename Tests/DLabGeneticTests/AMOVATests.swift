//
//  AMOVATests.swift
//  Tests macOS
//
//  Created by Rodney Dyer on 12/1/21.
//

import XCTest
import DLabMatrix

@testable import DLabGenetic

final class AMOVATests: XCTestCase {

    func testExample() throws {
        let raw_inds = DefaultIndividuals()
        XCTAssertEqual( raw_inds.count, 363)
        let df = raw_inds.locales(stratum: "Population", values: ["101","102"] )

        let analysis = AMOVAAnalysis(individuals: df )
        analysis.partitionName = "Population"
        
        let D = Matrix(17, 17, [0.0, 2.0, 5.0, 3.0, 5.0, 6.0, 4.0, 3.0, 1.0, 4.0, 4.0, 4.0, 2.0, 4.0, 3.0, 4.0, 5.0,
                                2.0, 0.0, 0.0, 4.0, 4.0, 4.0, 4.0, 4.0, 1.0, 2.0, 4.0, 0.0, 4.0, 4.0, 0.0, 4.0, 4.0,
                                5.0, 0.0, 0.0, 5.0, 6.0, 9.0, 9.0, 7.0, 1.0, 7.0, 8.0, 4.0, 7.0, 6.0, 4.0, 9.0, 6.0,
                                3.0, 4.0, 5.0, 0.0, 8.0, 4.0, 8.0, 9.0, 1.0, 2.0, 8.0, 4.0, 9.0, 8.0, 5.0, 8.0, 8.0,
                                5.0, 4.0, 6.0, 8.0, 0.0,15.0, 3.0, 3.0, 5.0, 5.0, 2.0, 2.0, 3.0, 1.0, 8.0, 3.0, 1.0,
                                6.0, 4.0, 9.0, 4.0,15.0, 0.0, 8.0,10.0, 3.0, 8.0, 9.0, 7.0,10.0,15.0, 5.0, 8.0,11.0,
                                4.0, 4.0, 9.0, 8.0, 3.0, 8.0, 0.0, 2.0, 5.0, 6.0, 1.0, 3.0, 2.0, 3.0, 5.0, 0.0, 3.0,
                                3.0, 4.0, 7.0, 9.0, 3.0,10.0, 2.0, 0.0, 5.0, 6.0, 2.0, 2.0, 1.0, 3.0, 5.0, 2.0, 3.0,
                                1.0, 1.0, 1.0, 1.0, 5.0, 3.0, 5.0, 5.0, 0.0, 1.0, 5.0, 1.0, 5.0, 5.0, 1.0, 5.0, 5.0,
                                4.0, 2.0, 7.0, 2.0, 5.0, 8.0, 6.0, 6.0, 1.0, 0.0, 5.0, 4.0, 6.0, 5.0, 7.0, 6.0, 5.0,
                                4.0, 4.0, 8.0, 8.0, 2.0, 9.0, 1.0, 2.0, 5.0, 5.0, 0.0, 2.0, 2.0, 2.0, 6.0, 1.0, 1.0,
                                4.0, 0.0, 4.0, 4.0, 2.0, 7.0, 3.0, 2.0, 1.0, 4.0, 2.0, 0.0, 3.0, 2.0, 4.0, 3.0, 2.0,
                                2.0, 4.0, 7.0, 9.0, 3.0,10.0, 2.0, 1.0, 5.0, 6.0, 2.0, 3.0, 0.0, 2.0, 5.0, 2.0, 3.0,
                                4.0, 4.0, 6.0, 8.0, 1.0,15.0, 3.0, 3.0, 5.0, 5.0, 2.0, 2.0, 2.0, 0.0, 8.0, 3.0, 1.0,
                                3.0, 0.0, 4.0, 5.0, 8.0, 5.0, 5.0, 5.0, 1.0, 7.0, 6.0, 4.0, 5.0, 8.0, 0.0, 5.0, 8.0,
                                4.0, 4.0, 9.0, 8.0, 3.0, 8.0, 0.0, 2.0, 5.0, 6.0, 1.0, 3.0, 2.0, 3.0, 5.0, 0.0, 3.0,
                                5.0, 4.0, 6.0, 8.0, 1.0,11.0, 3.0, 3.0, 5.0, 5.0, 1.0, 2.0, 3.0, 1.0, 8.0, 3.0, 0.0])
        
        XCTAssertEqual( analysis.D, D )
        
        XCTAssertEqual( analysis.dfModel, 1 )
        XCTAssertEqual( analysis.dfError, 15 )
        XCTAssertEqual( analysis.dfTotal, 16 )
        
        XCTAssertEqual( analysis.SSTotal, D.sum / (2 * 16.0) )
        XCTAssertEqual( analysis.SSModel, (352.0/16.0) + (212/14.0) )
        XCTAssertEqual( analysis.SSError, analysis.SSTotal - analysis.SSModel )
        
        XCTAssertEqual( analysis.MSModel, (352.0/16.0) + (212/14.0) )
        XCTAssertEqual( analysis.MSError, analysis.SSError / 15.0 )
    }

}
