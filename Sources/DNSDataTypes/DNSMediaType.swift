//
//  DNSMediaType.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import Foundation

/// Media type enumeration
public enum DNSMediaType: String, CaseIterable, Codable {
    case image = "image"
    case video = "video"
    case audio = "audio"
    case document = "document"
    case other = "other"
}
