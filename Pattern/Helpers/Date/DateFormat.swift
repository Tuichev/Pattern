//
//  DateFormat.swift
//

import Foundation

enum DateFormatType: String {
    case epgTime = "h:mm a"
    case weekday = "EEEE"
    case birthday = "dd.MM.yyyy"
    case year = "yyyy"
    case longMonth = "dd MMMM yyyy"
    case longServerDateTime = "YYYY-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
    case forTheServer = "yyyy-MM-dd HH:mm:ss"
    case forSaveVideo = "MMM dd, yyyy HH:mm"
    case dateWithOutTime = "MMM dd, yyyy"
    case onlyTime = "HH:mm"
    case dayMonthYear = "dd-MMM-yyyy"
}

class DateFormat {
    
    private static var epgDateFormatter = DateFormatter()
    private let dateFormatter = DateFormatter()
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func getStringTimeFromSeconds(time: (hours: Int, minutes: Int, seconds: Int)) -> String {
        let hours = time.0 < 10 ? "0\(String(time.hours))" : String(time.hours)
        let minutes = time.1 < 10 ? "0\(String(time.minutes))" : String(time.minutes)
        let seconds = time.2 < 10 ? "0\(String(time.seconds))" : String(time.seconds)
        
        if hours == "00" {
            return minutes + ":" + seconds
        }
        
        return hours + ":" + minutes + ":" + seconds
    }
    
    func forrmattedDate(date: Date, format: DateFormatType) -> String {
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale(identifier: "en")
        
        return dateFormatter.string(from: date)
    }
    
    func getDateFromString(dateStr: String, format: DateFormatType) -> Date? {
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale(identifier: "en")
        
        return dateFormatter.date(from: dateStr)
    }
    
    func getDateFrom(unix: Int) -> Date {
        let nsdate = NSDate(timeIntervalSince1970: Double(unix))
        return nsdate as Date
    }
}
