//
//  NormalFontsEntityMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 17/7/25.
//


import DependencyInjector

public protocol NormalFontsEntityMapperContract: Instanciable {
    func map(_ input: Data) throws -> NormalFontsEntity
    func map(_ input: NormalFontsEntity) throws -> [DogsInformationModel]
}

open class NormalFontsEntityMapper: NormalFontsEntityMapperContract {
    public required init() {}

    open func map(_ input: Data) throws -> NormalFontsEntity {
        return try input.map(NormalFontsEntity.self)
    }

    open func map(_ input: NormalFontsEntity) throws -> [DogsInformationModel] {
        guard let records = input.records else {
            throw NSError(domain: "NormalTrashEntityMapper", code: 0)
        }
        return records.compactMap { record in
            if let lat = record.latitud,
               let long = record.longitud,
               let id = record.id {
                let location = DogsInformationModel.LocationModel(
                    latitude: lat,
                    longitude: long
                )
                
                return DogsInformationModel(
                    id: id,
                    typeOfElement: .font,
                    barrio: record.barrio,
                    distrito: record.distrito,
                    localization: location,
                    direction: record.direccionAux
                )
            } else {
                return nil
            }
        }
    }
}
