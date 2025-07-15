//
//  InformationMapModalContentViewModelContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol InformationMapModalContentSectionViewModelContract: ViewModelContract {
    var loadingPublisher: AnyPublisher<Bool, Never> { get }
    var contentPublisher: AnyPublisher<InformationMapModalPresentationModel?, Never> { get }

    func howToGoTapped()
}
