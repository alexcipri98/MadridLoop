//
//  DogsFontsEntity.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 17/7/25.
//

import Foundation

open class DogsFontsEntity: Decodable {
    public let page: Int?
    public let pageSize: Int?
    public let totalRecords: Int?
    public let pageRecords: Int?
    public let status: Int?
    public let responseDate: String?
    public let first: String?
    public let last: String?
    public let `self`: String?
    public let contentMD5: String?
    public let sinEntrecomillar: Bool?
    public let records: [FountainEntity]?

    public init(page: Int? = nil, pageSize: Int? = nil, totalRecords: Int? = nil, pageRecords: Int? = nil, status: Int? = nil, responseDate: String? = nil, first: String? = nil, last: String? = nil, contentMD5: String? = nil, sinEntrecomillar: Bool? = nil, records: [FountainEntity]? = nil) {
        self.page = page
        self.pageSize = pageSize
        self.totalRecords = totalRecords
        self.pageRecords = pageRecords
        self.status = status
        self.responseDate = responseDate
        self.first = first
        self.last = last
        self.`self` = nil
        self.contentMD5 = contentMD5
        self.sinEntrecomillar = sinEntrecomillar
        self.records = records
    }

    open class FountainEntity: Decodable {
        public let id: String?
        public let descClasificacion: String?
        public let codBarrio: String?
        public let barrio: String?
        public let codDistrito: String?
        public let distrito: String?
        public let estado: String?
        public let coordGisX: String?
        public let coordGisY: String?
        public let sistemaCoord: String?
        public let latitud: Double?
        public let longitud: Double?
        public let tipoVia: String?
        public let nomVia: String?
        public let numVia: String?
        public let codPostal: String?
        public let direccionAux: String?
        public let ndp: String?
        public let fechaInstalacion: String?
        public let codigoInterno: String?
        public let contratoCod: String?
        public let ubicacion: String?
        public let uso: String?
        public let modelo: String?

        private enum CodingKeys: String, CodingKey {
            case id = "ID"
            case descClasificacion = "DESC_CLASIFICACION"
            case codBarrio = "COD_BARRIO"
            case barrio = "BARRIO"
            case codDistrito = "COD_DISTRITO"
            case distrito = "DISTRITO"
            case estado = "ESTADO"
            case coordGisX = "COORD_GIS_X"
            case coordGisY = "COORD_GIS_Y"
            case sistemaCoord = "SISTEMA_COORD"
            case latitud = "LATITUD"
            case longitud = "LONGITUD"
            case tipoVia = "TIPO_VIA"
            case nomVia = "NOM_VIA"
            case numVia = "NUM_VIA"
            case codPostal = "COD_POSTAL"
            case direccionAux = "DIRECCION_AUX"
            case ndp = "NDP"
            case fechaInstalacion = "FECHA_INSTALACION"
            case codigoInterno = "CODIGO_INTERNO"
            case contratoCod = "CONTRATO_COD"
            case ubicacion = "UBICACION"
            case uso = "USO"
            case modelo = "MODELO"
        }

        public init(id: String? = nil,
                    descClasificacion: String? = nil,
                    codBarrio: String? = nil,
                    barrio: String? = nil,
                    codDistrito: String? = nil,
                    distrito: String? = nil,
                    estado: String? = nil,
                    coordGisX: String? = nil,
                    coordGisY: String? = nil,
                    sistemaCoord: String? = nil,
                    latitud: Double? = nil,
                    longitud: Double? = nil,
                    tipoVia: String? = nil,
                    nomVia: String? = nil,
                    numVia: String? = nil,
                    codPostal: String? = nil,
                    direccionAux: String? = nil,
                    ndp: String? = nil,
                    fechaInstalacion: String? = nil,
                    codigoInterno: String? = nil,
                    contratoCod: String? = nil,
                    ubicacion: String? = nil,
                    uso: String? = nil,
                    modelo: String? = nil) {
            self.id = id
            self.descClasificacion = descClasificacion
            self.codBarrio = codBarrio
            self.barrio = barrio
            self.codDistrito = codDistrito
            self.distrito = distrito
            self.estado = estado
            self.coordGisX = coordGisX
            self.coordGisY = coordGisY
            self.sistemaCoord = sistemaCoord
            self.latitud = latitud
            self.longitud = longitud
            self.tipoVia = tipoVia
            self.nomVia = nomVia
            self.numVia = numVia
            self.codPostal = codPostal
            self.direccionAux = direccionAux
            self.ndp = ndp
            self.fechaInstalacion = fechaInstalacion
            self.codigoInterno = codigoInterno
            self.contratoCod = contratoCod
            self.ubicacion = ubicacion
            self.uso = uso
            self.modelo = modelo
        }
    }
}
