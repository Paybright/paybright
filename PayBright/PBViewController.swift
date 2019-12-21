//
//  PBViewController.swift
//  PayBright
//
//  Created by Manpreet Singh on 24/08/18.
//  Copyright © 2018 Manpreet Singh. All rights reserved.
//


import UIKit
import WebKit
import SafariServices


public protocol PBWebViewDelegate: class {
    
    func userDidCancel()
    
    func transactionComplete(success: Bool, params: [String: String])
}


public class PBViewController: UIViewController, WKNavigationDelegate, SFSafariViewControllerDelegate {
    
    
    var isFrance: Bool = false
    
    
    var progressHUD: PBPRogressHUD?
    
    
    @IBOutlet weak var containerV: UIView!
    
    
    @IBOutlet weak var pbwkWebView: WKWebView!
    
    
    public weak var delegate: PBWebViewDelegate?
    
    
    // MARK: - View Lifecycle
    
    override public func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //PBLog.shared.logEvent(title: "Test")
        
        
        setup()
    }
    
    
    // MARK: - Void
    
    func setup() {
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        var request = URLRequest(url: URL(string: "\(PBConfig.shared.environment == .Sandbox ? PBConstants.TEST_URL : PBConstants.LIVE_URL)checkout/applicationform.aspx")!)
        
        request.httpMethod = "POST"
        
        
        let postString = queryString()
        
        
        request.httpBody = postString.data(using: .utf8)
        
        
        if isFrance == true
        {
            progressHUD = PBPRogressHUD(text: "Lancement PayBright")
        }
            
        else
        {
            progressHUD = PBPRogressHUD(text: "Launching PayBright")
        }
        
        
        self.view.addSubview(progressHUD!)
        
        
        launchWKWebViewWithRequest(request: request)
    }
    
    
    func queryString() -> String {
        
        var rawDict = ["x_account_id":      PBConfig.shared.accountID,
                       "x_test":            PBConfig.shared.environment == .Sandbox ? "true" : "false"] as [String : Any]
        
        
        // Customer
        
        let customerDict = PBConfig.shared.instanceObj?.customerObj.customerDict()
        
        
        customerDict?.forEach { rawDict[$0] = $1 }
        
        
        // Customer Billing
        
        let customerBillingDict = PBConfig.shared.instanceObj?.customerBillingObj.customerBillingDict()
        
        
        customerBillingDict?.forEach { rawDict[$0] = $1 }
        
        
        // Customer Shipping
        
        let customerShippingDict = PBConfig.shared.instanceObj?.customerShippingObj.customerShippingDict()
        
        
        customerShippingDict?.forEach { rawDict[$0] = $1 }
        
        
        // Product
        
        let productDict = PBConfig.shared.instanceObj?.productObj.productDict()
        
        
        productDict?.forEach { rawDict[$0] = $1 }
        
        
        isFrance = (productDict?["x_shop_country"] as! String).caseInsensitiveCompare("CA-fr") == .orderedSame
        
        
        // Sort dictionary and get the string
        
        let tupleArr = rawDict.sorted(by: { $0.0 < $1.0 })
        
        
        var sortedStr = ""
        
        
        for tuple in tupleArr
        {
            sortedStr.append(tuple.key)
            
            
            sortedStr.append(tuple.value as! String)
        }
        
        
        rawDict["x_signature"] = sortedStr.HMAC(algorithm: .sha256, secret: PBConfig.shared.apiToken)
        
        
        return queryParameters(sourceDict: rawDict)
    }
    
    
    func clearWKWebViewCache() {
        
        pbwkWebView.load(URLRequest(url: URL(string:"about:blank")!))
        
        
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        
        
        let date = Date(timeIntervalSince1970: 0)
        
        
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: date, completionHandler:{ })
    }
    
    
    public func sampleSignature() -> String {
        
        let rawDict = ["x_account_id":          "NjOcXFC8cvTPtAwv3TCGFvSamx74HPvTgm1s46CcGENMmbWFUa",
                       "x_amount":               "2951.10",
                       "x_currency":             "CAD",
                       "x_gateway_reference":    "13770",
                       "x_message":              "Success",
                       "x_reference":            "238828060691",
                       "x_result":               "Completed",
                       "x_test":                 "true"]
        
        
        // Sort dictionary and get the string
        
        let tupleArr = rawDict.sorted(by: { $0.0 < $1.0 })
        
        
        var sortedStr = ""
        
        
        for tuple in tupleArr
        {
            sortedStr.append(tuple.key)
            
            
            sortedStr.append(tuple.value)
        }
        
        
        return sortedStr.HMAC(algorithm: .sha256, secret: "9O49jqV5mW5wWvctuk3mjs9WW5A4VgW5wrtRSvaYSHfahaYOBX")
    }
    
    
    func showLinksClicked(url: URL) {
        
        let safariVC = SFSafariViewController(url: url)
        
        safariVC.delegate = self
        
        safariVC.modalPresentationStyle = .popover
        
        safariVC.popoverPresentationController?.sourceView = self.view
        
        safariVC.preferredContentSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        self.present(safariVC, animated: true, completion: nil)
    }
    
    
    func launchWKWebViewWithRequest(request: URLRequest) {
        
        //let webConfiguration = WKWebViewConfiguration()
        
        
        //pbwkWebView = WKWebView (frame: .zero , configuration: webConfiguration)
        
        pbwkWebView.translatesAutoresizingMaskIntoConstraints = false
        
        
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            pbwkWebView.customUserAgent = "Mozilla/5.0 (iPad; CPU OS 7_0 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) CriOS/30.0.1599.12 Mobile/11A465 Safari/8536.25 (3B92C18B-D9DE-4CB7-A02A-22FD2AF17C8F)"
        }
        
        else
        {
            pbwkWebView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 12_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Mobile/15E148 Safari/604.1"
        }
        
        
        //containerV.addSubview(pbwkWebView)
        
        
        //pbwkWebView.topAnchor.constraint(equalTo: containerV.topAnchor).isActive          = true

        //pbwkWebView.rightAnchor.constraint(equalTo: containerV.rightAnchor).isActive      = true

        //pbwkWebView.leftAnchor.constraint(equalTo: containerV.leftAnchor).isActive        = true

        //pbwkWebView.bottomAnchor.constraint(equalTo: containerV.bottomAnchor).isActive    = true

        //pbwkWebView.heightAnchor.constraint(equalTo: containerV.heightAnchor).isActive    = true
        
        
        pbwkWebView.navigationDelegate = self
        
        
        pbwkWebView.load(request)
    }
    
    
    // MARK: - String
    
    func stringByAddingPercentEncodingForRFC3986(sourceStr: String) -> String? {
        
        let unreserved = "-._~/?"
        
        
        var allowedCharacterSet = NSCharacterSet.alphanumerics
        
        allowedCharacterSet.insert(charactersIn: unreserved)
        
        
        return sourceStr.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
    }
    
    
    func stringByAddingPercentEncodingForFormData(plusForSpace: Bool=false, sourceStr: String) -> String? {
        
        let unreserved = "*-._"
        
        
        var allowedCharacterSet = NSCharacterSet.alphanumerics
        
        allowedCharacterSet.insert(charactersIn: unreserved)
        
        
        if plusForSpace
        {
            allowedCharacterSet.insert(charactersIn: " ")
        }
        
        
        var encoded = sourceStr.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
        
        
        if plusForSpace
        {
            encoded = encoded?.replacingOccurrences(of: " ", with: "+")
        }
        
        
        return encoded
    }
    
    
    // MARK: - Dictionary
    
    func queryParameters(sourceDict: [String : Any]) -> String {
        
        var parts: [String] = []
        
        
        for (key, value) in sourceDict
        {
            let part = String(format: "%@=%@",
                              self.stringByAddingPercentEncodingForFormData(plusForSpace: true, sourceStr: key)!,
                              self.stringByAddingPercentEncodingForFormData(plusForSpace: true, sourceStr: value as! String)!)
            
            
            parts.append(part as String)
        }
        
        
        return parts.joined(separator: "&")
    }
    
    
    // MARK: - SafariViewController
    
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - WKWebView
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        NSLog("finished")
        
        progressHUD?.removeFromSuperview()
    }
    
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        progressHUD?.removeFromSuperview()
    }
    
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        
    }
    
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        //print("webView:\(webView) decidePolicyForNavigationAction:\(navigationAction) decisionHandler:\(decisionHandler)")
        
        
        
        //print("%@", navigationAction.request.allHTTPHeaderFields ?? ".....");

        
        
        switch navigationAction.navigationType {
            
        case .linkActivated:
            
            if navigationAction.targetFrame == nil
            {
                
            }
            
            
            if let url = navigationAction.request.url
            {
                showLinksClicked(url: url)
                
                
                decisionHandler(.cancel)
                
                
                return
            }
            
            
        default:
            
            break
        }
        
        
        if let url = navigationAction.request.url
        {
            if url.absoluteString == PBConfig.shared.instanceObj?.productObj.productDict()["x_url_cancel"] as! String
            {
                clearWKWebViewCache()
                
                
                (self.parent as! UINavigationController).popViewController(animated: true)
                
                
                self.delegate?.userDidCancel()
                
                
                /*let alert = UIAlertController(title: "Return to \(Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String)?", message: "Your PayBright loan request will not be completed.", preferredStyle: .alert)
                
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    
                    DispatchQueue.main.async {
                        
                        (self.parent as! UINavigationController).popViewController(animated: true)
                        
                        
                        self.delegate?.userDidCancel()
                    }
                }))
                
                
                self.present(alert, animated: true, completion: nil)*/
            }
            
            else if url.absoluteString.contains(PBConfig.shared.instanceObj?.productObj.productDict()["x_url_complete"] as! String)
            {
                clearWKWebViewCache()
                
                
                var urlParams = url.queryParameters
                
                
                let receivedParams = urlParams
                
                
                let generatedSignature = urlParams!["x_signature"]
                
                
                urlParams?.removeValue(forKey: "x_signature")
                
                
                if urlParams!["x_result"] == "Completed"
                {
                    let tupleArr = urlParams?.sorted(by: { $0.0 < $1.0 })
                    
                    
                    var sortedStr = ""
                    
                    
                    for tuple in tupleArr!
                    {
                        sortedStr.append(tuple.key)
                        
                        
                        sortedStr.append(tuple.value)
                    }
                    
                    
                    if generatedSignature == sortedStr.HMAC(algorithm: .sha256, secret: PBConfig.shared.apiToken)
                    {
                        delegate?.transactionComplete(success: true, params: receivedParams!)
                    }
                    
                    else
                    {
                        delegate?.transactionComplete(success: false, params: receivedParams!)
                    }
                }
                
                else
                {
                    delegate?.transactionComplete(success: false, params: receivedParams!)
                }
                
                
                (self.parent as! UINavigationController).popViewController(animated: true)
            }
                
            /*else if url.absoluteString.contains(instanceObj.configObj.productObj.productDict()["x_url_callback"] as! String)         // Not required at the moment
            {
                delegate?.receivedCallback()
            }*/
            
            
            decisionHandler(.allow)
        }
    }
    
    
}


extension URL {
    
    public var queryParameters: [String: String]? {
        
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            
            return nil
        }
        
        
        var parameters = [String: String]()
        
        
        for item in queryItems
        {
            parameters[item.name] = item.value
        }
        
        
        return parameters
    }
}

