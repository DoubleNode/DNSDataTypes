//
//  DNSAnalyticsNumbers.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCore
import Foundation

public class DNSAnalyticsNumbers: DNSDataTranslation, Codable {
    // MARK: - Properties -
    private func field(_ from: CodingKeys) -> String { return from.rawValue }
    public enum CodingKeys: String, CodingKey {
        case android, iOS, total
    }

    open var android: Double = 0.0
    open var iOS: Double = 0.0
    open var total: Double = 0.0

    // MARK: - Initializers -
    required override public init() {
        super.init()
    }
    public init(android: Double,
                iOS: Double,
                total: Double) {
        super.init()
        self.android = android
        self.iOS = iOS
        self.total = total
    }

    // MARK: - DAO copy methods -
    public init(from object: DNSAnalyticsNumbers) {
        super.init()
        self.update(from: object)
    }
    open func update(from object: DNSAnalyticsNumbers) {
        self.android = object.android
        self.iOS = object.iOS
        self.total = object.total
    }

    // MARK: - DAO translation methods -
    required public init(from data: DNSDataDictionary) {
        super.init()
        _ = self.dao(from: data)
    }
    open func dao(from data: DNSDataDictionary) -> DNSAnalyticsNumbers {
        self.android = self.double(from: data[field(.android)] as Any?) ?? self.android
        self.iOS = self.double(from: data[field(.iOS)] as Any?) ?? self.iOS
        self.total = self.double(from: data[field(.total)] as Any?) ?? self.total
        return self
    }
    open var asDictionary: DNSDataDictionary {
        let retval: DNSDataDictionary = [
            field(.android): self.android,
            field(.iOS): self.iOS,
            field(.total): self.total,
        ]
        return retval
    }

    // MARK: - Codable protocol methods -
    required public init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        android = self.double(from: container, forKey: .android) ?? android
        iOS = self.double(from: container, forKey: .iOS) ?? iOS
        total = self.double(from: container, forKey: .total) ?? total
    }
    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(android, forKey: .android)
        try container.encode(iOS, forKey: .iOS)
        try container.encode(total, forKey: .total)
    }

    // MARK: - NSCopying protocol methods -
    open func copy(with zone: NSZone? = nil) -> Any {
        let copy = DNSAnalyticsNumbers(from: self)
        return copy
    }
    open func isDiffFrom(_ rhs: Any?) -> Bool {
        guard let rhs = rhs as? DNSAnalyticsNumbers else { return true }
        let lhs = self
        return lhs.android != rhs.android ||
            lhs.iOS != rhs.iOS ||
            lhs.total != rhs.total
    }

    // MARK: - Equatable protocol methods -
    static public func !=(lhs: DNSAnalyticsNumbers, rhs: DNSAnalyticsNumbers) -> Bool {
        lhs.isDiffFrom(rhs)
    }
    static public func ==(lhs: DNSAnalyticsNumbers, rhs: DNSAnalyticsNumbers) -> Bool {
        !lhs.isDiffFrom(rhs)
    }
}