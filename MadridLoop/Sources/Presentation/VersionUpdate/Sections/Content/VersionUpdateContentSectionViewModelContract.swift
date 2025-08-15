//
//  VersionUpdateHeaderViewModelContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol VersionUpdateContentSectionViewModelContract: ViewModelContract {
    var versionUpdatePublisher: AnyPublisher<VersionModel?, Never> { get }
}
