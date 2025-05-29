//
//  StratumTable.swift
//  DLabGenetic
//
//  Created by Rodney Dyer on 5/28/25.
//

import SwiftUI

struct StratumTable: View {
    
    var stratum: Stratum
    var body: some View {
        StratumTableView(stratum: stratum )
    }
}

#Preview {
    StratumTable(stratum: Stratum.DefaultStratum )
}
