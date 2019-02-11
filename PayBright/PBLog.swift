//
//  PBLog.swift
//  PayBright
//
//  Created by Manpreet Singh on 15/08/18.
//  Copyright © 2018 Manpreet Singh. All rights reserved.
//


import Foundation


public class PBLog: NSObject {
    
    
    var logCount: Int = 0
    
    
    internal class var shared: PBLog {
        
        struct Static {
            
            static let pbLog = PBLog()
        }
        
        
        return Static.pbLog
    }
    
    
    override init() {
        
        super.init()
    }
    
    
    internal func logEvent(title: String) {
        
        logEvent(title: title, info: [ : ])
    }
    
    
    internal func logEvent(title: String, info: [String : Any]?) {
        
        print(logInfoWithContext(info: info!))
    }
    
    
    private func logInfoWithContext(info: [String : Any]) -> [String : Any] {
        
        var dict = info
        
        
        dict["app_id"]              = "iOS SDK"
        
        dict["device_type"]         = modelIdentifier()
        
        dict["release"]             = Bundle(for: self.classForCoder).object(forInfoDictionaryKey: "CFBundleShortVersionString")
        
        dict["app_name"]            = Bundle.main.object(forInfoDictionaryKey: "CFBundleName")
        
        dict["environment"]         = PBConfig.shared.environment == .Production ? "Production" : "Sandbox"
        
        dict["ts"]                  = String(UInt64((Date.timeIntervalBetween1970AndReferenceDate + 62_135_596_800) * 10_000_000))
        
        dict["local_log_counter"]   = NSNumber(value: logCount)
        
        
        logCount += 1
        
        
        return dict
    }
    
    
    // MARK: - Device
    
    private func modelIdentifier() -> String {
        
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        
        
        var sysinfo = utsname()
        
        uname(&sysinfo)
        
        
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
    
}

