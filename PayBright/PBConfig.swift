//
//  PBConfig.swift
//  PayBright
//
//  Created by Manpreet Singh on 15/08/18.
//  Copyright © 2018 Manpreet Singh. All rights reserved.
//


import Foundation


public class PBConfig: NSObject {
    
    
    public enum PBEnvironment :String {
        
        case Sandbox
        case Production
    }
    
    
    public class var shared: PBConfig {
        
        struct Static {
            
            static let pbConfig = PBConfig()
        }
        
        
        return Static.pbConfig
    }
    
    
    override init() {
        
        super.init()
    }
    
    
    public var environment:   PBEnvironment = .Sandbox
    
    public var accountID:     String        = ""
    
    public var apiToken:      String        = ""
    
    
    public var instanceObj:   PBInstance?   = nil
    
    
    public func initialize(environment: PBEnvironment, accountID: String, apiToken: String) {
        
        self.environment = environment
        
        self.accountID = accountID
        
        self.apiToken = apiToken
    }
    
    
}

