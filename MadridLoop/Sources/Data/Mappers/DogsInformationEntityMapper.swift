//
//  DogsInformationEntity.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 15/7/25.
//

import DependencyInjector

public protocol DogsInformationEntityMapperContract: Instanciable {
    func map(_ input: Data) throws -> DogTrashEntity
    func map(_ input: DogTrashEntity) throws -> [DogsInformationModel]
}

open class DogsInformationEntityMapper: DogsInformationEntityMapperContract {
    public required init() {}

    open func map(_ input: Data) throws -> DogTrashEntity {
        return try input.map(DogTrashEntity.self)
    }

    open func map(_ input: DogTrashEntity) throws -> [DogsInformationModel] {
        return input.records.map { record in
            let location = DogsInformationModel.LocationModel(
                latitude: record.latitud,
                longitude: record.longitud
            )

            return DogsInformationModel(
                id: record.id,
                typeOfElement: .trash,
                barrio: record.barrio,
                distrito: record.distrito,
                localization: location,
                direction: record.direccionAux
            )
        }
    }
}
