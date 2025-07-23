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
        public let filters: [String]
        public let isFilterSelected: [AvailableFilters: Bool]

        public init(filters: [String]? = nil,
                    isFilterSelected: [AvailableFilters: Bool]) {
            if let filters = filters {
                self.filters = filters
            } else {
                self.filters = []
            }
            self.isFilterSelected = isFilterSelected
        }
    }

}
