//
//  AMOVAMatrixTest.swift
//  Tests macOS
//
//  Created by Rodney Dyer on 11/28/21.
//

import Testing
import DLabGenetic
import DLabMatrix

class AMOVAMatrixTest {

    @Test func testCreation() throws {
    
        //var individuals = [Individual]()
        let genotypes = [ "A:A", "A:B", "A:C", "A:D",
                          "B:B", "B:C", "B:D",
                          "C:C", "C:D",
                          "D:D" ]
        let stratum = Stratum(label: "All")
        for geno in genotypes {
            let ind = Individual()
            ind.loci["loc1"] = Locus(raw: geno)
            //individuals.append( ind )
            stratum.addIndividual(individual: ind, strata: ["All"], levels: ["All"] )
        }
        
        let M = AMOVADistance(stratum: stratum)
        print("\(M)")

        #expect( M[0,0] == 0 )
        #expect( M.diagonal.sum == 0.0 )
        #expect( M[1,0] == 1.0 )
        #expect( M[2,0] == 1.0 )
        #expect( M[4,0] == 4.0 )
        #expect( M[5,0] == 3.0 )
        
    }


}
