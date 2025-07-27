//
//  LandingEventSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol LandingEventSectionMapperContract: SectionMapperContract {}

open class LandingEventSectionMapper: LandingEventSectionMapperContract {
    public typealias RenderModel = LandingEventSectionRenderModel
    
    public typealias ViewModel = LandingEventSectionViewModelContract
    
    public typealias ObservedModel = ViewState

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public enum ViewState {
        case show([EventEntryModel])
        case loading
        case error
    }

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<ObservedModel, Never> {
        let loadingPublisher = viewModel.loadingPublisher
        let errorPublisher = viewModel.errorPublisher
        let dataPublisher = viewModel.entriesPublisher

        return Publishers.CombineLatest3(loadingPublisher, errorPublisher, dataPublisher).map { loader, error, data in
            if loader {
                return .loading
            } else if error {
                return .error
            } else {
                return .show(data)
            }
        }.eraseToAnyPublisher()
    }
    
    public func map(_ model: ObservedModel) -> LandingEventSectionRenderModel {
        switch model {
        case .error:
            return .error
        case .show(let entries):
            let sortedEntries = entries.sorted {
                guard let date1 = $0.dtStart.parseStringToDate(),
                      let date2 = $1.dtStart.parseStringToDate() else {
                    return false
                }
                return date1 < date2
            }
            var result: [RenderModel.LandingEventDataRenderModel] = []
            for entry in sortedEntries {
                result.append(RenderModel.LandingEventDataRenderModel(id: entry.id,
                                                                      title: entry.title,
                                                                      description: entry.description,
                                                                      dateStart: entry.dtStart,
                                                                      dateEnd: entry.dtEnd,
                                                                      isItFree: entry.price == "Entrada gratuita",
                                                                      location: entry.address?.locality,
                                                                      link: entry.link,
                                                                      latitude: entry.location?.latitude,
                                                                      longitude: entry.location?.longitude))
            }
            return .show(result)
        case .loading:
            return .loading
        }
    }
    
}
