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
    var loadingPublisher: AnyPublisher<Bool, Never> { get }
    var errorPublisher: AnyPublisher<Bool, Never> { get }
    var locationPublisher: AnyPublisher<MapPresentationModel?, Never> { get }

    func refreshUserLocation()
}
