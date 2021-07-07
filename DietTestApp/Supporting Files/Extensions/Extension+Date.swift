//
//  Extension+Date.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import Foundation

extension Date {
    
    func getElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: self,
            to: Date()
        )
        
        if let year = interval.year, year > 0 {
            return year == 1
                ? "\(year)" + " " + "year ago"
                : "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1
                ? "\(month)" + " " + "month ago"
                : "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1
                ? "\(day)" + " " + "day ago"
                : "\(day)" + " " + "days ago"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1
                ? "\(hour)" + " " + "hour ago"
                : "\(hour)" + " " + "hours ago"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1
                ? "\(minute)" + " " + "minute ago"
                : "\(minute)" + " " + "minutes ago"
        } else {
            return "a moment ago"
        }
    }
    
    func getShorterElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: self,
            to: Date()
        )
        
        if let year = interval.year, year > 0 {
            return "\(year)" + "y ago"
        } else if let month = interval.month, month > 0 {
            return "\(month)" + "mo ago"
        } else if let day = interval.day, day > 0 {
            return "\(day)" + "d ago"
        } else if let hour = interval.hour, hour > 0 {
            return "\(hour)" + "h ago"
        } else if let minute = interval.minute, minute > 0 {
            return "\(minute)" + "m ago"
        } else if let second = interval.second, second > 0 {
            return "\(second)" + "s ago"
        }
        else {
            return "a moment ago"
        }
    }
    
    func getMostShortestElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: self,
            to: Date()
        )
        
        if let year = interval.year, year > 0 {
            return "\(year)" + "y"
        } else if let month = interval.month, month > 0 {
            return "\(month)" + "mo"
        } else if let day = interval.day, day > 0 {
            return "\(day)" + "d"
        } else if let hour = interval.hour, hour > 0 {
            return "\(hour)" + "h"
        } else if let minute = interval.minute, minute > 0 {
            return "\(minute)" + "m"
        } else if let second = interval.second, second > 0 {
            return "\(second)" + "s"
        }
        else {
            return "a moment ago"
        }
    }
}
