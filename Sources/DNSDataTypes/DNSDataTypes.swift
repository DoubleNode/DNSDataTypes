//
//  DNSDataTypes.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2022 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCore
import Foundation

/// DNSDataTypes module provides simple value types and enums
/// used throughout the DNSFramework without creating dependencies.
///
/// This module contains:
/// - Simple enums for business logic (UserRole, OrderState, etc.)
/// - Value types for data modeling (Status, Visibility, etc.)
/// - Foundation types with minimal dependencies
/// - Reusable type definitions
///
/// Usage:
/// ```swift
/// import DNSDataTypes
/// 
/// let role: DNSUserRole = .endUser
/// let state: DNSOrderState = .pending
/// ```

// Re-export DNSCore types for convenience
@_exported import struct DNSCore.DNSDataDictionary

// Note: Individual type files are automatically available when importing DNSDataTypes