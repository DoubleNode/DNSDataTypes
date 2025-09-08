//
//  DNSUserType.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

/// User type enumeration (age-based classification)
public enum DNSUserType: String, CaseIterable, Codable {
    case unknown = ""
    case child
    case youth
    case pendingAdult
    case adult
}