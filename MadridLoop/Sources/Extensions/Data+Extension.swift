//
//  Data+Extension.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 10/8/25.
//

import Foundation

extension Data {
    func cleanedInvalidEscapes() -> Data? {
        guard let jsonString = String(data: self, encoding: .utf8) else {
            return nil
        }
        
        let pattern = #"\\(?!["\\/bfnrtu])"#
        
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(jsonString.startIndex..<jsonString.endIndex, in: jsonString)
        let cleanedString = regex?.stringByReplacingMatches(in: jsonString, options: [], range: range, withTemplate: "") ?? jsonString
        
        return cleanedString.data(using: .utf8)
    }
}
