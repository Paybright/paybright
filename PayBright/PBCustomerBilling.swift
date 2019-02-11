//
//  PBCustomerBilling.swift
//  PayBright
//
//  Created by Manpreet Singh on 15/08/18.
//  Copyright © 2018 Manpreet Singh. All rights reserved.
//


import Foundation


public class PBCustomerBilling {
    
    private var customerBillingAddress1:    String
    
    private var customerBillingAddress2:    String?
    
    private var customerBillingCity:        String
    
    private var customerBillingCompany:     String?
    
    private var customerBillingCountry:     String
    
    private var customerBillingPhone:       String
    
    private var customerBillingState:       String
    
    private var customerBillingZip:         String
    
    
    public init(customerBillingAddress1:    String,
                customerBillingAddress2:    String?,
                customerBillingCity:        String,
                customerBillingCompany:     String?,
                customerBillingCountry:     String,
                customerBillingPhone:       String,
                customerBillingState:       String,
                customerBillingZip:         String) {
        
        self.customerBillingAddress1        = customerBillingAddress1
        
        
        if customerBillingAddress2 != nil
        {
            self.customerBillingAddress2    = customerBillingAddress2
        }
        
        
        self.customerBillingCity            = customerBillingCity
        
        
        if customerBillingCompany != nil
        {
            self.customerBillingCompany     = customerBillingCompany
        }
        
        
        self.customerBillingCountry         = customerBillingCountry
        
        self.customerBillingPhone           = customerBillingPhone
        
        self.customerBillingState           = customerBillingState
        
        self.customerBillingZip             = customerBillingZip
    }
    
    
    internal func customerBillingDict() -> [String : Any] {
        
        var rawDict = ["x_customer_billing_address1":   self.customerBillingAddress1,
                       "x_customer_billing_city":       self.customerBillingCity,
                       "x_customer_billing_country":    self.customerBillingCountry,
                       "x_customer_billing_phone":      self.customerBillingPhone,
                       "x_customer_billing_state":      self.customerBillingState,
                       "x_customer_billing_zip":        self.customerBillingZip]
        
        
        if self.customerBillingAddress2 != nil
        {
            rawDict["x_customer_billing_address2"]  = self.customerBillingAddress2
        }
        
        
        if self.customerBillingCompany != nil
        {
            rawDict["x_customer_billing_company"]   = self.customerBillingCompany
        }
        
        
        return rawDict
    }
}

