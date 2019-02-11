//
//  PBProduct.swift
//  PayBright
//
//  Created by Manpreet Singh on 16/08/18.
//  Copyright © 2018 Manpreet Singh. All rights reserved.
//


import Foundation


public class PBProduct {
    
    private var amount:         String
    
    private var currency:       String
    
    private var description:    String?
    
    private var invoice:        String?
    
    private var planID:         String?
    
    private var platform:       String
    
    private var reference:      String
    
    private var shopCountry:    String
    
    private var shopName:       String
    
    private var urlCallback:    String
    
    private var urlCancel:      String
    
    private var urlComplete:    String
    
    
    public init(amount:         Double,
                currency:       String,
                description:    String?,
                invoice:        String?,
                planID:         String?,
                platform:       String,
                reference:      String,
                shopCountry:    String,
                shopName:       String,
                urlCallback:    String,
                urlCancel:      String,
                urlComplete:    String) {
        
        self.amount             = String(format:"%.1f", amount)
        
        self.currency           = currency
        
        
        if description != nil
        {
            self.description    = description
        }
        
        
        if invoice != nil
        {
            self.invoice        = invoice
        }
        
        
        if planID != nil
        {
            self.planID         = planID
        }
        
        
        self.platform           = platform
        
        self.reference          = reference
        
        self.shopCountry        = shopCountry
        
        self.shopName           = shopName
        
        self.urlCallback        = urlCallback
        
        self.urlCancel          = urlCancel
        
        self.urlComplete        = urlComplete
    }
    
    
    internal func productDict() -> [String : Any] {
        
        var rawDict = ["x_amount":          self.amount,
                       "x_currency":        self.currency,
                       "x_platform":        self.platform,
                       "x_reference":       self.reference,
                       "x_shop_country":    self.shopCountry,
                       "x_shop_name":       self.shopName,
                       "x_url_callback":    self.urlCallback,
                       "x_url_cancel":      self.urlCancel,
                       "x_url_complete":    self.urlComplete] as [String : Any]
        
        
        if self.description != nil
        {
            rawDict["x_description"]    = self.description
        }
        
        
        if self.invoice != nil
        {
            rawDict["x_invoice"]        = self.invoice
        }
        
        
        if self.planID != nil
        {
            rawDict["x_plan_id"]        = self.planID
        }
        
        
        return rawDict
    }
}

