//
//  OffblastSettingsManager.swift
//  OffblastKit
//
//  Created by Ryan Renna on 2015-02-23.
//  Copyright (c) 2015 Offblast Softworks. All rights reserved.
//

import UIKit

// Notifications
public let NOTIFICATION_ALTERNATE_STYLE_FONT_SELECTED: Notification.Name = Notification.Name("NOTIFICATION_ALTERNATE_STYLE_FONT_SELECTED")
public let NOTIFICATION_FONT_SIZED_CHANGED = Notification.Name("NOTIFICATION_FONT_SIZED_CHANGED")
public let NOTIFICATION_CONTENT_FILTER_CHANGED = Notification.Name("NOTIFICATION_CONTENT_FILTER_CHANGED")
public let NOTIFICATION_PRO_MODE_CHANGED = Notification.Name("NOTIFICATION_PRO_MODE_CHANGED")

public class OffblastSettingsManager: NSObject
{
    // State
    public var loading = true
    public var smallFonts : Bool = false { didSet(newValue) {
        
            if(!loading)
            {
                saveSettings()
            }
            
            //Inform application
            NotificationCenter.default.post(name: NOTIFICATION_FONT_SIZED_CHANGED, object: nil)
        }
    }
    public var proMode : Bool = false { didSet(newValue) {
        
        if(!loading)
        {
            saveSettings()
        }
        //Inform application
        NotificationCenter.default.post(name: NOTIFICATION_PRO_MODE_CHANGED, object: nil)
        }
    }
    
    // Definitions
    private let SMALL_FONTS_KEY = "SMALL_FONTS_KEY"
    private let PRO_MODE_KEY = "PRO_MODE_KEY"
    
    public class var sharedInstance : OffblastSettingsManager
    {
        assert(true, "Singleton Template Method should never be invoked, but overriden")
        
        struct Static
        {
            static let instance : OffblastSettingsManager = OffblastSettingsManager()
        }
        return Static.instance
    }
    
    public override init() {
        super.init()
        loadSettings()
    }
    
    public func loadSettings()
    {
        smallFonts = UserDefaults.standard.bool(forKey: SMALL_FONTS_KEY)
        
        //PRO mode can be passed as a debug arguement
        let environementVariables = ProcessInfo.processInfo.environment
        if environementVariables["proMode"] != nil
        {
            proMode = true
        }
            //If the environment variable is not detected, check NSUserDefaults for a cached value, as per usual
        else
        {
            proMode = UserDefaults.standard.bool(forKey: PRO_MODE_KEY)
        }
        
        loading = false //All modifications will now be saved
    }
    public func saveSettings()
    {
        UserDefaults.standard.set(smallFonts, forKey: SMALL_FONTS_KEY)
        UserDefaults.standard.set(proMode, forKey: PRO_MODE_KEY)
        UserDefaults.standard.synchronize()
    }
}
