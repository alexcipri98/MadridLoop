//
//  ListMerchantsContentViewModelContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol ListMerchantsContentSectionViewModelContract: ViewModelContract {
    var loadingPublisher: AnyPublisher<Bool, Never> { get }
    var errorPublisher: AnyPublisher<Bool, Never> { get }
    var entriesPublisher: AnyPublisher<[MarketInformationModel], Never> { get }
    
    func entryTapped(at index: Int)
    func howToGoTapped(lat: Double, lon: Double)
}
