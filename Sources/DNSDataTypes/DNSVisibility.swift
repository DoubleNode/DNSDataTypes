//
//  DNSVisibility.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

/// Visibility enumeration (access control)
public enum DNSVisibility: String, CaseIterable, Codable {
    case adultsOnly
    case everyone
    case staffYouth
    case staffOnly
    case adminOnly
}
