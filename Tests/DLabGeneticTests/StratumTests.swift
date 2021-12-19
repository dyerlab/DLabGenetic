//
//  LocaleTests.swift
//  
//
//  Created by Rodney Dyer on 12/17/21.
//

import XCTest
@testable import DLabGenetic

class StratumTests: XCTestCase {



    func testExample() throws {

        let root = Stratum(label: "Root")
        let region1 = Stratum(label: "Washington")
        root.addSubstratum(stratum: region1 )
        let pop1 = Stratum(label:"Olympia")
        let pop2 = Stratum(label:"Bellingham")
        region1.addSubstratum( stratum: pop1 )
        region1.addSubstratum( stratum: pop2 )
        
        let region2 = Stratum(label: "Virginia")
        root.addSubstratum(stratum: region2 )
        let pop3 = Stratum(label: "RVA")
        let pop4 = Stratum(label: "Deltaville")
        region2.addSubstratum( stratum: pop3 )
        region2.addSubstratum( stratum: pop4 )

        print( "\(root)")
        
        XCTAssertTrue( root.parent == nil )
        XCTAssertEqual( root.label, "Root")
        
    }


}
