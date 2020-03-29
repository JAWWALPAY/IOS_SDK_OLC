//
//  PayVCNew.swift
//  Pods
//
//  Created by mahmoud gamal on 7/13/17.
//  Edited by mohamed tawfik on 8/2/17
//

import UIKit
import WebKit

class PayVCNew: UIViewController, WKUIDelegate, WKNavigationDelegate{
    
    var accept: AcceptSDK?
    
    var saveCardDefault: Bool?
    var showSaveCard: Bool?
    
    var billingData: [String: String]?
    var paymentKey: String?
    var iFrame: String?
    var token: String?
    var auth3dWebView: WKWebView!
    var auth3dCancelButton: UIButton!
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    var entryStack: TZStackView?
    
    var cardNameStack: TZStackView?
    var cardNameTitleStack: TZStackView?
    var cardNumberStack: TZStackView?
    var cardNumberTitleStack: TZStackView?
    var exp_cvvStack: TZStackView?
    var expirationStack: TZStackView?
    var expTitleStack: TZStackView?
    var cvvStack: TZStackView?
    var cvvTitleStack: TZStackView?
    var saveCardStack: TZStackView?
    
    var poweredByStack: TZStackView?
    
    
    var monthString: String?
    var yearString: String?
    
    var showAlertsFlag = true
    
    var entering3dSecure = false
    
    var payDict: [String : AnyObject]?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        spinner.isHidden = true
        
        presentWebView2()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.hideKeyboard()
        
    }
    
    
    /**
     they intercept the clicks
     */
    @IBAction func barCancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        accept!.handleUserDidCancel()
        
    }
    
    
    /**
     it handles the SDK response
     */
    func paymentInquiry(payDict: [String : AnyObject]?, payResponse: URLResponse?,  payError: Error?) {
//        print("paydict in paymentinquiry is: \(payDict) ")
        if payDict?["success"] as? String == "true" {
            self.resumeInteraction()
            AlertShower.showSweetAlertAndExecute(onCondition: self.showAlertsFlag, title: "Transaction successful", message: nil, style: AlertStyle.success, buttonTitle: "Ok", action: { (_ isOtherButton: Bool) -> Void in
                self.dismiss(animated: false, completion: nil)
                self.accept!.handleTransactionAccepted(payDict!)
            })
            
        } else {
            self.resumeInteraction()
            AlertShower.showSweetAlertAndExecute(onCondition: self.showAlertsFlag, title: "Error", message: payDict?["data.message"] as? String, style: AlertStyle.error, buttonTitle: "Ok", action: { (_ isOtherButton: Bool) -> Void in
                self.dismiss(animated: false, completion: nil)
                self.accept!.handleTransactionRejected(payDict!)
            })
        }
    }
    
    //MARK:- WebView
    
    //TODO:- add activity indicator to webview and cancel button
    
    func presentWebView2() {
        let url = "https://checkout.jawwalpay.ps/api/acceptance/iframes/\(iFrame!)?payment_token=\(paymentKey!)"
        auth3dWebView = WKWebView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 50))
        auth3dWebView.uiDelegate = self
        auth3dWebView.navigationDelegate = self
        auth3dWebView.load(URLRequest(url: URL(string: url)!))
        
        
        self.resumeInteraction()
        
        self.view.addSubview(auth3dWebView)
    }
    
    
    // testing
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
//        print("WKWebView didcommit")
        if let url = webView.url {
            //            if navigation == .formSubmitted {
            let urlString = url.absoluteString
//            print("URL == \(urlString)\n")
            if urlString.contains(Constants.stopping3dSecureURL) {
                let payDict: [String : AnyObject]? = DataAndTypeConverter.urlQueryToTargetDict(url: urlString, keys: Constants.PAY_DICT_KEYS)
                self.entering3dSecure = false
                self.auth3dWebView.removeFromSuperview()
                //                    self.pauseInteraction()
                self.paymentInquiry(payDict: payDict, payResponse: nil, payError: nil)
            }
        }else{
//            print("webview did commit failed")
        }
        //        }
    }
    
    func pauseInteraction() {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    func resumeInteraction() {
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
