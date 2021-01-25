//
//  TimeIntervalExtension.swift
//

import Foundation

extension TimeInterval {
    var hour: TimeInterval { return self / 60 / 60 }
    var day: TimeInterval { return hour / 24 }
}
