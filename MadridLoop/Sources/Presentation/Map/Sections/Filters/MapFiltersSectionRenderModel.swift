//
//  MapHeaderSectionRenderModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Foundation
import MapKit

public enum MapFiltersSectionRenderModel {
    case hidden
    case error
    case show(renderData: MapFiltersSectionRenderModelData)

    public struct MapFiltersSectionRenderModelData {
        public let filters: [Filters]
        public let isFilterSelected: [AvailableFilters: Bool]

        public init(filters: [Filters]? = nil,
                    isFilterSelected: [AvailableFilters: Bool]) {
            if let filters = filters {
                self.filters = filters
            } else {
                self.filters = []
            }
            self.isFilterSelected = isFilterSelected
        }
    }

    public enum Filters: CaseIterable {
        case date
        case trash
        case font
        case dogPark
    }
}
