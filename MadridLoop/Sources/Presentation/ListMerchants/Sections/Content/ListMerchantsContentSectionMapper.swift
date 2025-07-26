//
//  ListMerchantsContentSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol ListMerchantsContentSectionMapperContract: SectionMapperContract {}

open class ListMerchantsContentSectionMapper: ListMerchantsContentSectionMapperContract {
    public typealias RenderModel = ListMerchantsContentSectionRenderModel
    
    public typealias ViewModel = ListMerchantsContentSectionViewModelContract
    
    public typealias ObservedModel = ViewState

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public enum ViewState {
        case show([MarketInformationModel])
        case hidden
    }

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<ObservedModel, Never> {
        let loadingPublisher = viewModel.loadingPublisher
        let errorPublisher = viewModel.errorPublisher
        let dataPublisher = viewModel.entriesPublisher

        return Publishers.CombineLatest3(loadingPublisher, errorPublisher, dataPublisher).map { loader, error, data in
            if loader || error {
                return .hidden
            } else {
                return .show(data)
            }
        }.eraseToAnyPublisher()
    }
    
    public func map(_ model: ObservedModel) -> RenderModel {
        switch model {
        case .show(let entries):
            var result: [RenderModel.ListMerchantsMarketsDataRenderModel] = []
            for entry in entries {
                result.append(RenderModel.ListMerchantsMarketsDataRenderModel(id: entry.id ?? "",
                                                                              title: entry.title ?? "",
                                                                              description: entry.services?.cleanedUntilFirstDot ?? "",
                                                                              location: entry.schedule,
                                                                              link: entry.relation,
                                                                              latitude: entry.latitude,
                                                                              longitude: entry.longitude))
            }
            return .show(result)
        case .hidden:
            return .hidden
        }
    }
    
}
