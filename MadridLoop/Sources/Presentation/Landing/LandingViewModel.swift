//
//  LandingViewModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector
import PresentationLayer
import Combine

open class LandingViewModelDependencies {
    public let identifier: String
    
    public init(identifier: String) {
        self.identifier = identifier
    }
}

public protocol LandingViewModelContract: ViewModelContract {
    func setupDependencies(_ dependencies: LandingViewModelDependencies)
    func notifyAppearance()
}

open class LandingViewModel: LandingHeaderSectionViewModelContract,
                             LandingEventSectionViewModelContract,
                             LandingViewModelContract {

    public let getEventsCalendarUseCase: GetEventsCalendarUseCaseContract

    public required init(){
        @Injected var getEventsCalendarUseCase: GetEventsCalendarUseCaseContract
        self.getEventsCalendarUseCase = getEventsCalendarUseCase
    }

    //init() {}

    @Published public var loadingPublished: Bool = false
    @Published public var errorPublished: Bool = false
    @Published public var entriesPublished: [LandingEntryModel] = []

    public var loadingPublisher: AnyPublisher<Bool, Never> {
        $loadingPublished.eraseToAnyPublisher()
    }

    public var errorPublisher: AnyPublisher<Bool, Never> {
        $errorPublished.eraseToAnyPublisher()
    }
    
    public var entriesPublisher: AnyPublisher<[LandingEntryModel], Never> {
        $entriesPublished.eraseToAnyPublisher()
    }

    // Dependencies
    @Dependency public var identifier: String

    open func setupDependencies(_ dependencies: LandingViewModelDependencies) {
        self.identifier = dependencies.identifier
    }
    
    open func notifyAppearance() {
        print("Notify Appearance")
        loadInitialData()
    }

    open func getEventForEntries() {}
    
    open func entryTapped(at index: Int) {}
}

private extension LandingViewModel {
    func loadInitialData() {
        loadingPublished = true
        Task { @MainActor [weak self] in
            guard let self else { return }
            defer {
                self.loadingPublished = false
            }
            do {
                let params = GetEventsCalendarUseCaseParameters()
                self.entriesPublished = try await getEventsCalendarUseCase.run(params)
            } catch {
                self.errorPublished = true
            }
        }
    }
}
