//
//  File.swift
//  DLabGenetic
//
//  Created by Rodney Dyer on 5/27/25.
//

import Foundation

public enum Parentage: String, Codable {
    case Unknown = "Unknown"
    case Mother = "Mother"
    case Father = "Father"
    case Ambiguous = "Ambiguous"
}
