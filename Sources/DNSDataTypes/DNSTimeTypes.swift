//
//  DNSTimeTypes.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

// MARK: - Time Types

/// Daily hours structure
public struct DNSDailyHours {
    public var openTime: Date?
    public var closeTime: Date?
    public var isClosed: Bool
    public var isAllDay: Bool
    
    public init(openTime: Date? = nil, closeTime: Date? = nil, isClosed: Bool = false, isAllDay: Bool = false) {
        self.openTime = openTime
        self.closeTime = closeTime
        self.isClosed = isClosed
        self.isAllDay = isAllDay
    }
}

/// Day of week flags
public struct DNSDayOfWeekFlags: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let sunday = DNSDayOfWeekFlags(rawValue: 1 << 0)
    public static let monday = DNSDayOfWeekFlags(rawValue: 1 << 1)
    public static let tuesday = DNSDayOfWeekFlags(rawValue: 1 << 2)
    public static let wednesday = DNSDayOfWeekFlags(rawValue: 1 << 3)
    public static let thursday = DNSDayOfWeekFlags(rawValue: 1 << 4)
    public static let friday = DNSDayOfWeekFlags(rawValue: 1 << 5)
    public static let saturday = DNSDayOfWeekFlags(rawValue: 1 << 6)
    
    public static let weekdays: DNSDayOfWeekFlags = [.monday, .tuesday, .wednesday, .thursday, .friday]
    public static let weekend: DNSDayOfWeekFlags = [.saturday, .sunday]
    public static let all: DNSDayOfWeekFlags = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
}