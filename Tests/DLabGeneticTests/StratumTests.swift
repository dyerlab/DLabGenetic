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
        root.add(child: region1 )
        let pop1 = Stratum(label:"Olympia")
        let pop2 = Stratum(label:"Bellingham")
        region1.add( child: pop1 )
        region1.add( child: pop2 )
        
        let region2 = Stratum(label: "Virginia")
        root.add(child: region2 )
        let pop3 = Stratum(label: "RVA")
        let pop4 = Stratum(label: "Deltaville")
        region2.add( child: pop3 )
        region2.add( child: pop4 )

        print( "\(root)")
        
        
        XCTAssertTrue( root.parent == nil )
        XCTAssertEqual( root.count, 2 )
        XCTAssertEqual( root.label, "Root")
        
        
    }


}
