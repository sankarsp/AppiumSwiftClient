//
//  driver.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/09.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

import Foundation

protocol Driver {
    typealias SessionId = String
    typealias DesiredCapability = [DesiredCapabilities : String]

    func createSession(with caps: DesiredCapability) -> String
}

public struct AppiumDriver : Driver {

    public var sessionId: String = ""

    public init(_ caps: AppiumCapabilities) {
        self.sessionId = handShake(desiredCapability: caps.desiredCapability)
    }

    private func handShake(desiredCapability: DesiredCapability) -> SessionId {
        let session = createSession(with: desiredCapability)
        return session
    }

    internal func createSession(with caps: DesiredCapability) -> String {
        let createSessionJson = generateCapabilityBody(with: caps)
        // TODO: send HTTP request to server as JSON format

        return createSessionJson
    }

    private func generateCapabilityBody(with caps: DesiredCapability) -> String {
        let invalidJson = "Not a valid JSON"

        let data = [
            "desiredCapabilities" : "caps1",
            "capabilities" : "caps2"
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [.sortedKeys])
            return String(data: jsonData, encoding: .utf8) ?? invalidJson
        } catch {
            return invalidJson
        }

    }
}

internal struct DriverCapability : Codable {
    let desiredCapabilities : String
    let capabilities : String
}