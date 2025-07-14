//
//  LandingHeaderViewModelContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol LandingHeaderSectionViewModelContract: ViewModelContract {
    var loadingPublisher: AnyPublisher<Bool, Never> { get }
}
