//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-18.
//

import Foundation

extension RangeReplaceableCollection where Self: MutableCollection {
   
    func splitIntoChunks(ofSize maxLength: Int) -> [Self] {
        precondition(maxLength > 0, "groups must be greater than zero")
        var start = startIndex
        return stride(from: 0, to: count, by: maxLength).map { _ in
            let end = index(start, offsetBy: maxLength, limitedBy: endIndex) ?? endIndex
            defer { start = end }
            return Self(self[start..<end])
        }
    }
}
