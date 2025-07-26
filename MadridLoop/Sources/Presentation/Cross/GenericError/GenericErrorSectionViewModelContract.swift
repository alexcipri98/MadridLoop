//
//  GenericErrorViewModelContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol GenericErrorSectionViewModelContract: ViewModelContract {
    var errorPublisher: AnyPublisher<Bool, Never> { get }

    func tryAgain()
}
