//
//  File.swift
//  GeneticStudio (macOS)
//
//  Created by Rodney Dyer on 11/3/21.
//  Copyright © 2021 Rodney J Dyer. All rights reserved.
//

import Foundation
import SwiftUI

extension String {

    /// Returns a string with all non-numeric characters removed
    public var numericDecimalString: String {
        let characterSet = CharacterSet(charactersIn: "0123456789.-").inverted
        return components(separatedBy: characterSet)
            .joined()
    }

    /// Returns a string with all non-numeric characters removed
    public var numericString: String {
        let characterSet = CharacterSet(charactersIn: "0123456789 ").inverted
        return components(separatedBy: characterSet)
            .joined()
    }
    

}
