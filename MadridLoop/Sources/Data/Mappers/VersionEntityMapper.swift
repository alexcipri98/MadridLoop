//
//  VersionEntityMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 11/8/25.
//

import DependencyInjector

public protocol VersionEntityMapperContract: Instanciable {
    func map(_ input: Data) throws -> VersionEntity
    func map(_ input: VersionEntity) throws -> VersionModel
}

open class VersionEntityMapper: VersionEntityMapperContract {
    public required init() {}

    open func map(_ input: Data) throws -> VersionEntity {
        return try input.map(VersionEntity.self)
    }

    open func map(_ input: VersionEntity) throws -> VersionModel {
        return VersionModel(
            minimumVersion: input.minimumVersion ?? "0.0.0",
            url: input.url ?? "",
            updateRequired: input.updateRequired ?? false
        )
    }
}

