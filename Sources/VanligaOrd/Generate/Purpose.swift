//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-18.
//

import Foundation

public extension RawRepresentable where Self: CustomStringConvertible, RawValue == String {
    var description: String { rawValue }
}

public enum Purpose: String, Equatable, CustomStringConvertible {
    case password
}
