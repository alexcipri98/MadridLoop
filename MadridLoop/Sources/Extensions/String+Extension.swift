//
//  String+Extension.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 26/7/25.
//

import Foundation

extension String {
    func parseStringToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        formatter.locale = Locale(identifier: "es_ES")
        return formatter.date(from: self)
    }

    var cleanedUntilFirstDot: String {
        let cleaned = self.replacingOccurrences(of: "Más información", with: "")
        
        if let index = cleaned.firstIndex(of: ".") {
            return String(cleaned[..<index])
        } else {
            return cleaned
        }
    }
}
