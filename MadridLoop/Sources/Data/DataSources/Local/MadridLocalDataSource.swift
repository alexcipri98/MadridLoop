//
//  MadridLocalDataSource.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 27/7/25.
//

import Foundation

open class MadridLocalDataSource: EventsCalendarLocalDataSourceContract, DogsInformationLocalDataSourceContract, MarketsLocalDataSourceContract {

    public required init() {}

    private let eventsFileName = "cached_events.json"

    private var eventsFileURL: URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(eventsFileName)
    }

    private var eventsTimestampURL: URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("cached_events_timestamp.txt")
    }

    private func dogsFileURL(for district: String) -> URL {
        let sanitized = district.replacingOccurrences(of: "[^a-zA-Z0-9]", with: "_", options: .regularExpression)
        let fileName = "dogs_info_\(sanitized).json"
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(fileName)
    }

    private func dogsTimestampURL(for district: String) -> URL {
        let sanitized = district.replacingOccurrences(of: "[^a-zA-Z0-9]", with: "_", options: .regularExpression)
        let fileName = "dogs_info_\(sanitized)_timestamp.txt"
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(fileName)
    }

    private func isCacheValid(url: URL, maxAge: TimeInterval) -> Bool {
        guard FileManager.default.fileExists(atPath: url.path),
              let data = try? Data(contentsOf: url),
              let string = String(data: data, encoding: .utf8),
              let timestamp = Double(string) else {
            return false
        }

        let now = Date().timeIntervalSince1970
        return now - timestamp <= maxAge
    }

    open func getCachedEvents() async throws -> [EventEntryModel]? {
        let oneWeek: TimeInterval = 7 * 24 * 60 * 60
        guard isCacheValid(url: eventsTimestampURL, maxAge: oneWeek),
              FileManager.default.fileExists(atPath: eventsFileURL.path) else {
            return nil
        }
        let data = try Data(contentsOf: eventsFileURL)
        let decoder = JSONDecoder()
        return try decoder.decode([EventEntryModel].self, from: data)
    }

    open func saveEvents(_ events: [EventEntryModel]) async throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(events)
        try data.write(to: eventsFileURL, options: .atomic)

        let timestamp = Date().timeIntervalSince1970
        try? "\(timestamp)".data(using: .utf8)?.write(to: eventsTimestampURL)
    }

    open func cleanEventsCache() async {
        if FileManager.default.fileExists(atPath: eventsFileURL.path) {
            try? FileManager.default.removeItem(at: eventsFileURL)
        }
        if FileManager.default.fileExists(atPath: eventsTimestampURL.path) {
            try? FileManager.default.removeItem(at: eventsTimestampURL)
        }
    }

    open func getDogsInformation(distrit: String) async throws -> [DogsInformationModel] {
        let url = dogsFileURL(for: distrit)
        let timestampURL = dogsTimestampURL(for: distrit)
        let oneYear: TimeInterval = 365 * 24 * 60 * 60
        guard isCacheValid(url: timestampURL, maxAge: oneYear),
              FileManager.default.fileExists(atPath: url.path) else {
            return []
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode([DogsInformationModel].self, from: data)
    }

    open func addDogsInformation(_ dogsInformation: [DogsInformationModel]) {
        guard let district = dogsInformation.first?.distrito else { return }
        let url = dogsFileURL(for: district)
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(dogsInformation) {
            try? data.write(to: url, options: .atomic)

            let timestampURL = dogsTimestampURL(for: district)
            let timestamp = Date().timeIntervalSince1970
            try? "\(timestamp)".data(using: .utf8)?.write(to: timestampURL)
        }
    }

    open func cleanDogsInformationCache() async {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        let directory = paths[0]
        if let files = try? FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil) {
            for file in files where file.lastPathComponent.hasPrefix("dogs_info_") {
                try? FileManager.default.removeItem(at: file)
            }
        }
    }

    // MARK: - Markets Cache

    private let marketsFileName = "cached_markets.json"

    private var marketsFileURL: URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(marketsFileName)
    }

    private var marketsTimestampURL: URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("cached_markets_timestamp.txt")
    }

    open func getCachedMarkets() async throws -> [MarketInformationModel]? {
        let oneWeek: TimeInterval = 7 * 24 * 60 * 60
        guard isCacheValid(url: marketsTimestampURL, maxAge: oneWeek),
              FileManager.default.fileExists(atPath: marketsFileURL.path) else {
            return nil
        }
        let data = try Data(contentsOf: marketsFileURL)
        let decoder = JSONDecoder()
        return try decoder.decode([MarketInformationModel].self, from: data)
    }

    open func saveMarkets(_ events: [MarketInformationModel]) async throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(events)
        try data.write(to: marketsFileURL, options: .atomic)

        let timestamp = Date().timeIntervalSince1970
        try? "\(timestamp)".data(using: .utf8)?.write(to: marketsTimestampURL)
    }

    open func cleanMarketsCache() async {
        if FileManager.default.fileExists(atPath: marketsFileURL.path) {
            try? FileManager.default.removeItem(at: marketsFileURL)
        }
        if FileManager.default.fileExists(atPath: marketsTimestampURL.path) {
            try? FileManager.default.removeItem(at: marketsTimestampURL)
        }
    }
}
