//
//  DNSSystemState.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public struct MEESystemDebugString: Hashable {
    public var id: String
    public var timestamp: Date
    public var platform: String // "ios" or "android"
    public var debugString: String
    public var metadata: [String: String]

    // MARK: - Computed Properties
    public var platformIcon: String {
        return platform.lowercased() == "ios" ? "􀣺" : "􀢹" // SF Symbols
    }

    public var timestampText: String {
        return timestamp.dnsDateTime(as: .longSmart, in: TimeZone.current)
    }

    public var previewText: String {
        let maxLength = 100
        let cleaned = debugString.replacingOccurrences(of: "\n", with: " ")
        let preview = cleaned.prefix(maxLength)
        return debugString.count > maxLength ? "\(preview)..." : String(preview)
    }

    public var appVersion: String? {
        return metadata["appVersion"]
    }

    public var osVersion: String? {
        return metadata["osVersion"]
    }

    // MARK: - Initializers
    public init(
        id: String,
        timestamp: Date,
        platform: String,
        debugString: String,
        metadata: [String: String] = [:]
    ) {
        self.id = id
        self.timestamp = timestamp
        self.platform = platform
        self.debugString = debugString
        self.metadata = metadata
    }
}
