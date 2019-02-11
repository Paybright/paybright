//
//  PBCustomer.swift
//  PayBright
//
//  Created by Manpreet Singh on 15/08/18.
//  Copyright © 2018 Manpreet Singh. All rights reserved.
//


import Foundation


public class PBCustomer {
    
    private var customerEmail:      String
    
    private var customerFirstName:  String
    
    private var customerLastName:   String
    
    private var customerPhone:      String?
    
    
    public init(customerEmail:      String,
                customerFirstName:  String,
                customerLastName:   String,
                customerPhone:      String?) {
        
        self.customerEmail      = customerEmail
        
        self.customerFirstName  = customerFirstName
        
        self.customerLastName   = customerLastName
        
        
        if customerPhone != nil
        {
            self.customerPhone  = customerPhone
        }
    }
    
    
    internal func customerDict() -> [String : Any] {
        
        var rawDict = ["x_customer_email":      self.customerEmail,
                       "x_customer_first_name": self.customerFirstName,
                       "x_customer_last_name":  self.customerLastName]
        
        
        if self.customerPhone != nil
        {
            rawDict["x_customer_phone"] = self.customerPhone
        }
        
        
        return rawDict
    }
}

