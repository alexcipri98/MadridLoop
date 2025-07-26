//
//  LandingMarketsViewModelContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol LandingMarketsSectionViewModelContract: ViewModelContract {
    var loadingPublisher: AnyPublisher<Bool, Never> { get }
    var marketsPublisher: AnyPublisher<[MarketInformationModel], Never> { get }

    func lookInMapMarketsTapped()
}
