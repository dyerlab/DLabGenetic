//
//  Locus.swift
//  DLabGenetic
//
//  Created by Rodney Dyer on 5/29/25.
//

import SwiftData
import Foundation


@available(macOS 14, *)
@Model
public class Locus {
    
    public var id: UUID
    public var name: String
    public var location: Double?
    
    public init(name: String, location: Double? = nil) {
        self.id = UUID()
        self.name = name
        self.location = location
    }
    
}

