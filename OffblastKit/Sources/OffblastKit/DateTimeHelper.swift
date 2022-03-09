//
//  DateTimeHelper.swift
//  OffblastKit
//
//  Created by Ryan Renna on 2015-03-20.
//  Copyright (c) 2015 Offblast Softworks. All rights reserved.
//

import Foundation

public class DateTimeHelper: NSObject {
   
    let dateFormatter = DateFormatter()
    
    public class func stringForDate(date: Date, includeYear:Bool) -> String
    {
        return sharedInstance._stringForDate(date: date, includeYear: includeYear)
    }
    
    // MARK : Singleton compliance methods
    
    public class var sharedInstance : DateTimeHelper
    {
        assert(true, "Singleton Template Method should never be invoked, but overriden")
        
        struct Static
        {
            static let instance : DateTimeHelper = DateTimeHelper()
        }
        return Static.instance
    }
    
    override init()
    {
    }
    
    //
    
    private func _stringForDate(date: Date, includeYear:Bool) -> String
    {
        //Formats day of month with postfix ie. 1st, 2nd, 3rd, 4th
        let dayOfMonth =  Calendar.current.component(.day, from: date)
        var dayFormat = "d'th'"
        
        if(dayOfMonth == 1 || dayOfMonth == 21 || dayOfMonth == 31)
        {
            dayFormat = "d'st'"
        }
        else if(dayOfMonth == 2 || dayOfMonth == 22)
        {
            dayFormat = "d'nd'"
        }
        else if(dayOfMonth == 3 || dayOfMonth == 23)
        {
            dayFormat = "d'rd'"
        }
            
        
        if(includeYear)
        {
            dateFormatter.dateFormat = "MMMM \(dayFormat) yyyy"
        }
        else
        {
            dateFormatter.dateFormat = "MMMM \(dayFormat)"
        }
        
        return dateFormatter.string(from: date)
    }
}
