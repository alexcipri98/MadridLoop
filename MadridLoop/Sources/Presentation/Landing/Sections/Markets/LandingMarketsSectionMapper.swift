//
//  LandingMarketsSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol LandingMarketsSectionMapperContract: SectionMapperContract {}

open class LandingMarketsSectionMapper: LandingMarketsSectionMapperContract {
    public typealias RenderModel = LandingMarketsSectionRenderModel
    
    public typealias ViewModel = LandingMarketsSectionViewModelContract
    
    public typealias ObservedModel = ViewState

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public enum ViewState {
        case show([MarketInformationModel])
        case hidden
    }

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<ObservedModel, Never> {
        let dataPublisher = viewModel.marketsPublisher
        let loadingPublisher = viewModel.loadingPublisher
        let errorPublisher = viewModel.errorPublisher

        return Publishers.CombineLatest3(dataPublisher,
                                        loadingPublisher,
                                        errorPublisher).map { data, loading, error in
            if loading || error {
                return .hidden
            } else {
                return .show(data)
            }
        }.eraseToAnyPublisher()
    }
    
    public func map(_ model: ObservedModel) -> LandingMarketsSectionRenderModel {
        switch model {
        case .show(let entries):
            var result: [RenderModel.LandingMarketsSectionData] = []
            for entry in entries {
                result.append(RenderModel.LandingMarketsSectionData(title: entry.title ?? "",
                                                                    description: entry.services ?? "",
                                                                    date: entry.schedule ?? "",
                                                                    icon: "mappin.circle.fill",
                                                                    link: entry.relation))
            }
            return .show(result)
        case .hidden:
            return .hidden
        }
    }
    
}
