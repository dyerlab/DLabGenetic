//
//  LocaleTests.swift
//  
//
//  Created by Rodney Dyer on 12/17/21.
//

import XCTest
@testable import DLabGenetic

class StratumTests: XCTestCase {


    func testDefaults() throws {
        
        let pop = DefaultIndividuals(level: .population )
        print("\(pop)")
        XCTAssertEqual( pop.individuals.count, 6)
        
        let data = DefaultIndividuals(level: .all )
        print("\(data)")
        XCTAssertEqual( data.individuals.count, 363)
        
        
        
    }

}
