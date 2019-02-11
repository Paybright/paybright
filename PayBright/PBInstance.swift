//
//  PBInstance.swift
//  PayBright
//
//  Created by Manpreet Singh on 16/08/18.
//  Copyright © 2018 Manpreet Singh. All rights reserved.
//


import Foundation


public class PBInstance {
    
    internal var customerObj:           PBCustomer
    
    internal var customerBillingObj:    PBCustomerBilling
    
    internal var customerShippingObj:   PBCustomerShipping
    
    internal var productObj:            PBProduct
    
    
    public init(customerObj:            PBCustomer,
                customerBillingObj:     PBCustomerBilling,
                customerShippingObj:    PBCustomerShipping,
                productObj:             PBProduct) {
        
        self.customerObj            = customerObj
        
        self.customerBillingObj     = customerBillingObj
        
        self.customerShippingObj    = customerShippingObj
        
        self.productObj             = productObj
    }
}

