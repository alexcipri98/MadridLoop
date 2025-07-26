//
//  MapHeaderViewModelContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer
import MapKit

public protocol MapFiltersSectionViewModelContract: ViewModelContract {
    var loadingPublisher: AnyPublisher<Bool, Never> { get }
    var errorPublisher: AnyPublisher<Bool, Never> { get }
    var locationPublisher: AnyPublisher<LocationPresentationModel?, Never> { get }
    var filtersIsSelectedPublisher: AnyPublisher<[AvailableFilters: Bool], Never> { get }

    func openSettings()
    func didSelectDate(date: Date)
    func didToggleFilter(filter: AvailableFilters)
}
