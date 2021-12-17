//
//  Stratum.swift
//  
//
//  Created by Rodney Dyer on 12/17/21.
//

import Foundation

class Stratum {
    var label: String
    var children: [Stratum] = []
    var count: Int { return children.count }
    weak var parent: Stratum?
    
    private var _inds: [Individual]?
    var individuals: [Individual] {
        get {
            if self.count > 0  {
                var ret = [Individual]()
                for child in children {
                    ret.append(contentsOf: child.individuals )
                }
                return ret
            }
            else {
                return self._inds ?? [Individual]()
            }
        }
    }
    
    init( label: String ) {
        self.label = label
    }
    
    
    func addIndividual( ind: Individual ) {
        
        if ind.strata.values.contains( self.label ) {
            
        }
        
    }
    
    func add(child: Stratum) {
        child.parent = self
        self.children.append( child )
    }
    
    func search(label: String) -> Stratum? {
        if label == self.label { return self }
        
        for child in children {
            if let found = child.search(label: label ) {
                return found
            }
        }
        return nil
    }
    
}

extension Stratum: CustomStringConvertible {
    
    var description: String {
        var ret = "\(label):"
        if !children.isEmpty {
            ret += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
        }
        return ret
    }
    
}
