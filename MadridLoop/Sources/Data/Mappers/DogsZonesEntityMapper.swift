//
//  DogsZonesEntityMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 17/7/25.
//

import DependencyInjector

public protocol DogsZonesEntityMapperContract: Instanciable {
    func map(_ input: Data) throws -> DogsZonesEntity
    func map(_ input: DogsZonesEntity) throws -> [DogsInformationModel]
}

open class DogsZonesEntityMapper: DogsZonesEntityMapperContract {
    public required init() {}

    open func map(_ input: Data) throws -> DogsZonesEntity {
        let cleanedData = input.cleanedInvalidEscapes() ?? input
        
        // Intentamos decodificar el JSON como diccionario de [String: Any] primero
        guard let rawObject = try JSONSerialization.jsonObject(with: cleanedData) as? [String: Any] else {
            throw NSError(domain: "DogsZonesEntityMapper", code: 1, userInfo: [NSLocalizedDescriptionKey: "JSON no es un diccionario válido"])
        }
        
        var zones: [String: DogsZonesEntity.ZoneEntity] = [:]
        
        for (key, value) in rawObject {
            do {
                let zoneData = try JSONSerialization.data(withJSONObject: value)
                let zone = try JSONDecoder().decode(DogsZonesEntity.ZoneEntity.self, from: zoneData)
                zones[key] = zone
            } catch {
                print("⚠️ Error decodificando zona \(key): \(error)")
            }
        }
        
        return DogsZonesEntity(zones: zones)
    }

    open func map(_ input: DogsZonesEntity) throws -> [DogsInformationModel] {
        guard let records = input.zones?.values else {
            throw NSError(domain: "DogsZonesEntityMapper", code: 0)
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
                    typeOfElement: .dogFont,
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
