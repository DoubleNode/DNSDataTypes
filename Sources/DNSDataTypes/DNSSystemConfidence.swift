//
//  DNSSystemConfidence.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

public enum DNSSystemConfidence: String, CaseIterable, Codable {
    case none
    case insufficient
    case low
    case medium
    case high
}
