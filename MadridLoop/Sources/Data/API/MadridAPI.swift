//
//  MadridAPI.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector
import DataLayer

public protocol MadridAPIContract: Instanciable {
    func getEventsCalendar() -> HTTPAPIContract
}

open class MadridAPI: MadridAPIContract {
    public required init () { }

    open func getEventsCalendar() -> HTTPAPIContract {
        GetEventsCalendar()
    }
}

private extension MadridAPI {
    struct GetEventsCalendar: HTTPAPIContract {
        public init() {}
        
        public var method = "GET"
        public var path: String { "https://datos.madrid.es/egob/catalogo/206974-0-agenda-eventos-culturales-100.json" }
    }
}
