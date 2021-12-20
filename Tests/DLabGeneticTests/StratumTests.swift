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

    
    func testAddIndividual() throws {
        
        let root = Stratum(label: "All", level: "All")
        
        let ind11 =  Individual()
        let ind12 =  Individual()
        let ind21 =  Individual()
        let ind22 =  Individual()
        let pop1levels = ["West","Olympia"]
        let pop2levels = ["West","Bellingham"]
        
        root.addIndividual(individual: ind11, strata: pop1levels, levels: ["Region","Population"] )
        root.addIndividual(individual: ind12, strata: pop1levels, levels: ["Region","Population"] )
        root.addIndividual(individual: ind21, strata: pop2levels, levels: ["Region","Population"] )
        root.addIndividual(individual: ind22, strata: pop2levels, levels: ["Region","Population"] )
        
        print( root )
        XCTAssertEqual( root.individuals.count, 4)
        
        if let olympia = root.substratum(named: "Olympia") {
            XCTAssertEqual( olympia.individuals.count, 2 )
        } else {
            XCTAssertEqual( 0, 1 )
        }
        if let bellingham = root.substratum(named: "Bellingham") {
            XCTAssertEqual( bellingham.individuals.count, 2)
        } else {
            XCTAssertEqual( 0, 1 )
        }
        
        XCTAssertNil( root.substratum(named: "Tacoma") )
        XCTAssertNotNil( root.substratum(named: "Olympia"))
        
    }
    
    
    func testIndividuals() throws {
        
        let data = DefaultIndividuals(level: .all )
        
        XCTAssertEqual( data.individuals.count, 363 )
        XCTAssertFalse( data.isLocale )
        XCTAssertEqual( data.childCount, 3 )
        XCTAssertEqual( data.childLevel, "Species" )
        XCTAssertEqual( data.level, "All" )
        if let mainland = data.substratum(named: "Mainland") {
            XCTAssertEqual( mainland.individuals.count, 36)
        } else {
            XCTAssertEqual( 0, 1)
        }
        if let sonora = data.substratum(named: "SON-B") {
            XCTAssertEqual( sonora.individuals.count, 36)
        } else {
            XCTAssertEqual( 0, 1)
        }
        if let pop101 = data.substratum(named: "101") {
            XCTAssertEqual( pop101.individuals.count, 9)
        } else {
            XCTAssertEqual( 0, 1)
        }
        
        let cape = DefaultIndividuals(level: .population)
        
        XCTAssertTrue( cape.isLocale )
        XCTAssertEqual( cape.childCount, 0 )
        XCTAssertEqual( cape.individuals.count, 6 )
        XCTAssertEqual( cape.childLevel, "No Labels")
                        
    }
    
}
