//
//  DNSDayOfWeekFlags.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSDataTypes
//
//  Created by Darren Ehlers.
//  Copyright © 2025 - 2016 DoubleNode.com. All rights reserved.
//

import DNSCore
import Foundation

open class DNSDayOfWeekFlags: DNSDataTranslation, Codable, NSCopying {
    // MARK: - Properties -
    private func field(_ from: CodingKeys) -> String { return from.rawValue }
    public enum CodingKeys: String, CodingKey {
        case sunday, monday, tuesday, wednesday, thursday, friday, saturday
    }
    
    open var sunday: Bool = true
    open var monday: Bool = true
    open var tuesday: Bool = true
    open var wednesday: Bool = true
    open var thursday: Bool = true
    open var friday: Bool = true
    open var saturday: Bool = true
    
    // Convenience properties for common day combinations
    open var isWeekdays: Bool {
        monday && tuesday && wednesday && thursday && friday && !saturday && !sunday
    }
    open var isWeekend: Bool {
        saturday && sunday && !monday && !tuesday && !wednesday && !thursday && !friday
    }
    open var isAllDays: Bool {
        sunday && monday && tuesday && wednesday && thursday && friday && saturday
    }
    open var isNoDays: Bool {
        !sunday && !monday && !tuesday && !wednesday && !thursday && !friday && !saturday
    }
    
    // MARK: - Initializers -
    required override public init() {
        super.init()
    }
    
    public convenience init(sunday: Bool = true, monday: Bool = true, tuesday: Bool = true, wednesday: Bool = true, thursday: Bool = true, friday: Bool = true, saturday: Bool = true) {
        self.init()
        self.sunday = sunday
        self.monday = monday
        self.tuesday = tuesday
        self.wednesday = wednesday
        self.thursday = thursday
        self.friday = friday
        self.saturday = saturday
    }

    // MARK: - DAO copy methods -
    public init(from object: DNSDayOfWeekFlags) {
        super.init()
        self.update(from: object)
    }
    open func update(from object: DNSDayOfWeekFlags) {
        self.sunday = object.sunday
        self.monday = object.monday
        self.tuesday = object.tuesday
        self.wednesday = object.wednesday
        self.thursday = object.thursday
        self.friday = object.friday
        self.saturday = object.saturday
    }
    
    // MARK: - DAO translation methods -
    required public init(from data: DNSDataDictionary) {
        super.init()
        _ = self.dao(from: data)
    }
    open func dao(from data: DNSDataDictionary) -> DNSDayOfWeekFlags {
        self.sunday = self.bool(from: data[field(.sunday)] as Any?) ?? self.sunday
        self.monday = self.bool(from: data[field(.monday)] as Any?) ?? self.monday
        self.tuesday = self.bool(from: data[field(.tuesday)] as Any?) ?? self.tuesday
        self.wednesday = self.bool(from: data[field(.wednesday)] as Any?) ?? self.wednesday
        self.thursday = self.bool(from: data[field(.thursday)] as Any?) ?? self.thursday
        self.friday = self.bool(from: data[field(.friday)] as Any?) ?? self.friday
        self.saturday = self.bool(from: data[field(.saturday)] as Any?) ?? self.saturday
        return self
    }
    open var asDictionary: DNSDataDictionary {
        let retval: DNSDataDictionary = [
            field(.sunday): self.sunday,
            field(.monday): self.monday,
            field(.tuesday): self.tuesday,
            field(.wednesday): self.wednesday,
            field(.thursday): self.thursday,
            field(.friday): self.friday,
            field(.saturday): self.saturday,
        ]
        return retval
    }
    
    // MARK: - Codable protocol methods -
    required public init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sunday = self.bool(from: container, forKey: .sunday) ?? sunday
        monday = self.bool(from: container, forKey: .monday) ?? monday
        tuesday = self.bool(from: container, forKey: .tuesday) ?? tuesday
        wednesday = self.bool(from: container, forKey: .wednesday) ?? wednesday
        thursday = self.bool(from: container, forKey: .thursday) ?? thursday
        friday = self.bool(from: container, forKey: .friday) ?? friday
        saturday = self.bool(from: container, forKey: .saturday) ?? saturday
    }
    open func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sunday, forKey: .sunday)
        try container.encode(monday, forKey: .monday)
        try container.encode(tuesday, forKey: .tuesday)
        try container.encode(wednesday, forKey: .wednesday)
        try container.encode(thursday, forKey: .thursday)
        try container.encode(friday, forKey: .friday)
        try container.encode(saturday, forKey: .saturday)
    }
    
    // MARK: - NSCopying protocol methods
    open func copy(with zone: NSZone? = nil) -> Any {
        let copy = DNSDayOfWeekFlags(from: self)
        return copy
    }
    open func isDiffFrom(_ rhs: Any?) -> Bool {
        guard let rhs = rhs as? DNSDayOfWeekFlags else { return true }
        let lhs = self
        return lhs.sunday != rhs.sunday ||
            lhs.monday != rhs.monday ||
            lhs.tuesday != rhs.tuesday ||
            lhs.wednesday != rhs.wednesday ||
            lhs.thursday != rhs.thursday ||
            lhs.friday != rhs.friday ||
            lhs.saturday != rhs.saturday
    }

    // MARK: - Equatable protocol methods -
    static public func !=(lhs: DNSDayOfWeekFlags, rhs: DNSDayOfWeekFlags) -> Bool {
        lhs.isDiffFrom(rhs)
    }
    static public func ==(lhs: DNSDayOfWeekFlags, rhs: DNSDayOfWeekFlags) -> Bool {
        !lhs.isDiffFrom(rhs)
    }
}
