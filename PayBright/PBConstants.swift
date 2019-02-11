//
//  PBConstants.swift
//  PayBright
//
//  Created by Manpreet Singh on 15/08/18.
//  Copyright © 2018 Manpreet Singh. All rights reserved.
//


import Foundation


class PBConstants {
    
    static let LIVE_URL = "https://app.paybright.com/"
    
    static let TEST_URL = "https://sandbox.paybright.com/"
    
    
    static var IS_SIMULATOR: Bool {
        
        return TARGET_OS_SIMULATOR != 0
    }
    
    
    static let ACCOUNT_ID = ""
    
    static let API_TOKEN = ""
}

