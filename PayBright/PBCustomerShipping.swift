//
//  PBCustomerShipping.swift
//  PayBright
//
//  Created by Manpreet Singh on 15/08/18.
//  Copyright © 2018 Manpreet Singh. All rights reserved.
//


import Foundation


public class PBCustomerShipping {
    
    private var customerShippingAddress1:   String
    
    private var customerShippingAddress2:   String?
    
    private var customerShippingCity:       String
    
    private var customerShippingCompany:    String?
    
    private var customerShippingCountry:    String
    
    private var customerShippingFirstName:  String
    
    private var customerShippingLastName:   String
    
    private var customerShippingPhone:      String
    
    private var customerShippingState:      String
    
    private var customerShippingZip:        String
    
    
    public init(customerShippingAddress1:   String,
                customerShippingAddress2:   String?,
                customerShippingCity:       String,
                customerShippingCompany:    String?,
                customerShippingCountry:    String,
                customerShippingFirstName:  String,
                customerShippingLastName:   String,
                customerShippingPhone:      String,
                customerShippingState:      String,
                customerShippingZip:        String) {
        
        self.customerShippingAddress1       = customerShippingAddress1
        
        
        if customerShippingAddress2 != nil
        {
            self.customerShippingAddress2   = customerShippingAddress2
        }
        
        
        self.customerShippingCity           = customerShippingCity
        
        
        if customerShippingCompany != nil
        {
            self.customerShippingCompany    = customerShippingCompany
        }
        
        
        self.customerShippingCountry        = customerShippingCountry
        
        self.customerShippingFirstName      = customerShippingFirstName
        
        self.customerShippingLastName       = customerShippingLastName
        
        self.customerShippingPhone          = customerShippingPhone
        
        self.customerShippingState          = customerShippingState
        
        self.customerShippingZip            = customerShippingZip
    }
    
    
    internal func customerShippingDict() -> [String : Any] {
        
        var rawDict = ["x_customer_shipping_address1":      self.customerShippingAddress1,
                       "x_customer_shipping_city":          self.customerShippingCity,
                       "x_customer_shipping_country":       self.customerShippingCountry,
                       "x_customer_shipping_first_name":    self.customerShippingFirstName,
                       "x_customer_shipping_last_name":     self.customerShippingLastName,
                       "x_customer_shipping_phone":         self.customerShippingPhone,
                       "x_customer_shipping_state":         self.customerShippingState,
                       "x_customer_shipping_zip":           self.customerShippingZip]
        
        
        if self.customerShippingAddress2 != nil
        {
            rawDict["x_customer_shipping_address2"] = self.customerShippingAddress2
        }
        
        
        if self.customerShippingCompany != nil
        {
            rawDict["x_customer_shipping_company"]  = self.customerShippingCompany
        }
        
        
        return rawDict
    }
}

