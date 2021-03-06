//
//  Capabilities.swift
//  AppiumSwiftClient
//
//  Created by kazuaki matsuo on 2018/11/09.
//  Copyright © 2018 KazuCocoa. All rights reserved.
//

public enum DesiredCapabilitiesEnum: String {
    case platformName, automationName, app, platformVersion, deviceName
    case reduceMotion // Option
    case sessionId // Additional
}

public struct OssDesiredCapability: Codable {
    let platformName: String
    let automationName: String
    let app: String
    let platformVersion: String
    let deviceName: String
    var reduceMotion: String = "false"

    init(with caps: AppiumCapabilities) {
        let desiredCaps = caps.desiredCapability
        platformName = desiredCaps[.platformName] ?? ""
        automationName = desiredCaps[.automationName] ?? ""
        app = desiredCaps[.app] ?? ""
        platformVersion = desiredCaps[.platformVersion] ?? ""
        deviceName = desiredCaps[.deviceName] ?? ""
        reduceMotion = desiredCaps[.reduceMotion] ?? "false"
    }
}

public struct W3CDesiredCapability: Codable {
    let platformName: String
    let automationName: String
    let app: String
    let platformVersion: String
    let deviceName: String
    var reduceMotion: String = "false"

    init(with caps: AppiumCapabilities) {
        let desiredCaps = caps.desiredCapability
        platformName = desiredCaps[.platformName] ?? ""
        automationName = desiredCaps[.automationName] ?? ""
        app = desiredCaps[.app] ?? ""
        platformVersion = desiredCaps[.platformVersion] ?? ""
        deviceName = desiredCaps[.deviceName] ?? ""
        reduceMotion = desiredCaps[.reduceMotion] ?? "false"
    }

    enum CodingKeys: String, CodingKey {
        case platformName, automationName, platformVersion, deviceName
        case app = "appium:app"
    }
}

protocol Capabilities {
    // protocol
}

public struct AppiumCapabilities: Capabilities {
    var desiredCapability: [DesiredCapabilitiesEnum: String] = [:]

    var sessionId: String = ""

    public init(_ opts: [DesiredCapabilitiesEnum: String]) {
        guard let platformName = opts[.platformName] else {
            fatalError("platformName is mondatory")
        }
        self.desiredCapability[.platformName] = platformName

        guard let automationName = opts[.automationName] else {
            fatalError("automationName is mondatory")
        }
        self.desiredCapability[.automationName] = automationName

        guard let app = opts[.app] else {
            fatalError("app is mondatory")
        }
        self.desiredCapability[.app] = app

        guard let platformVersion = opts[.platformVersion] else {
            fatalError("platformVersion is mondatory")
        }
        self.desiredCapability[.platformVersion] = platformVersion

        guard let deviceName = opts[.deviceName] else {
            fatalError("deviceName is mondatory")
        }
        self.desiredCapability[.deviceName] = deviceName

        if opts[.sessionId] != nil {
            self.desiredCapability[.sessionId] = opts[.sessionId]
        }

        if opts[.reduceMotion] != nil {
            self.desiredCapability[.reduceMotion] = opts[.reduceMotion]
        }
    }

    public func capabilities() -> [DesiredCapabilitiesEnum: String] {
        return desiredCapability
    }
}
