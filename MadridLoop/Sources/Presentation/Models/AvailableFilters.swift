//
//  AvailableFilters.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 18/7/25.
//

import Foundation

public enum AvailableFilters {
    case isTrashFilterSelected
    case isNormalFontsFilterSelected
    case isDogsFontsFilterSelected

    static func getEmptyFilters() -> [AvailableFilters: Bool] {
        return [.isTrashFilterSelected: true, .isNormalFontsFilterSelected: true, .isDogsFontsFilterSelected: true]
    }
}
