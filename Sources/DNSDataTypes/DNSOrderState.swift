//
//  DNSOrderState.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

/// Order state enumeration
public enum DNSOrderState: String, CaseIterable, Codable {
    case cancelled
    case completed
    case created
    case fraudulent
    case pending
    case processing
    case refunded
    case unknown
}