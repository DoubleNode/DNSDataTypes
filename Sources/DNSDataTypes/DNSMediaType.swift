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
    case unknown
    case animatedImage
    case pdfDocument
    case staticImage
    case text
    case video
}
