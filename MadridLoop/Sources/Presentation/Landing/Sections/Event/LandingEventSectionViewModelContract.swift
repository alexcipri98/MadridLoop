//
//  LandingEventSectionViewModelContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol LandingEventSectionViewModelContract: ViewModelContract {
    var loadingPublisher: AnyPublisher<Bool, Never> { get }
    var errorPublisher: AnyPublisher<Bool, Never> { get }
    var entriesPublisher: AnyPublisher<[EventEntryModel], Never> { get }

    func getEventForEntries()
    func entryTapped(at index: Int)
    func lookInMapEventsTapped()
}
