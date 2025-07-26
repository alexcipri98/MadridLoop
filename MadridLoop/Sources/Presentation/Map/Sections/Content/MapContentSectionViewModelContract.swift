//
//  MapHeaderViewModelContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import MapKit

public protocol MapContentSectionViewModelContract: ViewModelContract {
    var errorPublisher: AnyPublisher<Bool, Never> { get }
    var locationPublisher: AnyPublisher<LocationPresentationModel?, Never> { get }
    var filtersIsSelectedPublisher: AnyPublisher<[AvailableFilters: Bool], Never> { get }
    var dateFilterPublisher: AnyPublisher<Date?, Never> { get }

    func openSettings()
}
