//
//  LocationPermissionHeaderViewModelContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol LocationPermissionContentSectionViewModelContract: ViewModelContract {
    var LocationPermissionPublisher: AnyPublisher<VersionModel?, Never> { get }

    func goToSettings()
}
