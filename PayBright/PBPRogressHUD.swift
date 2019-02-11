//
//  PBPRogressHUD.swift
//  PayBright
//
//  Created by Manpreet Singh on 01/09/18.
//  Copyright © 2018 Manpreet Singh. All rights reserved.
//


import UIKit
//import WebKit


class PBPRogressHUD: UIVisualEffectView {
    
    
    var text: String? {
        
        didSet
        {
            label.text = text
        }
    }
    
    
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
    
    
    let label: UILabel = UILabel()
    
    
    let blurEffect = UIBlurEffect(style: .dark)
    
    
    let vibrancyView: UIVisualEffectView
    
    
    //static var webView: WKWebView? = nil
    
    
    init(text: String) {
        
        self.text = text
        
        
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        
        
        super.init(effect: blurEffect)
        
        
        self.setup()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        
        self.text = ""
        
        
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        
        
        super.init(coder: aDecoder)
        
        
        self.setup()
    }
    
    
    func setup() {
        
        contentView.addSubview(vibrancyView)
        
        contentView.addSubview(activityIndictor)
        
        contentView.addSubview(label)
        
        
        activityIndictor.startAnimating()
    }
    
    
    override func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        
        
        let width: CGFloat = 220.0
        
        let height: CGFloat = 50.0
        
        
        self.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - width / 2,
                            y: UIScreen.main.bounds.size.height / 2 - height / 2,
                            width: width,
                            height: height)
        
        
        vibrancyView.frame = self.bounds
        
        
        let activityIndicatorSize: CGFloat = 40
        
        
        activityIndictor.frame = CGRect(x: 5,
                                        y: height / 2 - activityIndicatorSize / 2,
                                        width: activityIndicatorSize,
                                        height: activityIndicatorSize)
        
        
        layer.cornerRadius = 8.0
        
        layer.masksToBounds = true
        
        
        label.text = text
        
        label.textAlignment = NSTextAlignment.center
        
        label.frame = CGRect(x: activityIndicatorSize,
                             y: 0,
                             width: width - activityIndicatorSize,
                             height: height)
        
        label.textColor = UIColor.white
        
        label.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    
    func show() {
        
        self.isHidden = false
    }
    
    
    func hide() {
        
        self.isHidden = true
    }
    

}

