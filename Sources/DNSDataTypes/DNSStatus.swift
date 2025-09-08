//
//  DNSStatus.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

/// Status enumeration (business/operational status)
public enum DNSStatus: String, CaseIterable, Codable {
    case badWeather
    case closed
    case comingSoon
    case grandOpening
    case hidden
    case holiday
    case maintenance
    case open
    case privateEvent
    case tempClosed
    case training
}