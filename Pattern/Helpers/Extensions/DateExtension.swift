//
//  DateExtension.swift
//

import Foundation

extension Date {
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func dayAfter(_ days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: noon)
    }
    
    func dayBefore(_ days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: -days, to: noon)
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}
