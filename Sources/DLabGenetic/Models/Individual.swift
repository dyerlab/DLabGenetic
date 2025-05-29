//
//  Individual.swift
//  DLabGenetic
//
//  Created by Rodney Dyer on 5/29/25.
//

import SwiftData
import Foundation

@available(macOS 14, *)
@Model
public class Individual: Identifiable {
    public var id: UUID
    public var name: String = ""
    public var latitude: Double?
    public var longitude: Double?
    
    
    init(name: String = "", latitude: Double? = nil, longitude: Double? = nil) {
        self.id = UUID()
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
}

