//
//  CheckoutTableViewController.swift
//  PayTabsClient
//
//  Created by Mohamed Adly on 6/3/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import UIKit

class CheckoutTableViewController: UIViewController {

    var initialSetupViewController: PTFWInitialSetupViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func setOnClickPay(_ sender: Any) {
        let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
        self.initialSetupViewController = PTFWInitialSetupViewController.init(
            bundle: bundle,
            andWithViewFrame: self.view.frame,
            andWithAmount: 5.0,
            andWithCustomerTitle: "PayTabs Sample App",
            andWithCurrencyCode: "USD",
            andWithTaxAmount: 0.0,
            andWithSDKLanguage: "en",
            andWithShippingAddress: "Manama",
            andWithShippingCity: "Manama",
            andWithShippingCountry: "BHR",
            andWithShippingState: "Manama",
            andWithShippingZIPCode: "123456",
            andWithBillingAddress: "Manama",
            andWithBillingCity: "Manama",
            andWithBillingCountry: "BHR",
            andWithBillingState: "Manama",
            andWithBillingZIPCode: "12345",
            andWithOrderID: "12345",
            andWithPhoneNumber: "0097333109781",
            andWithCustomerEmail: "rhegazy@paytabs.com",
            andIsTokenization:true,
            andIsPreAuth: true,
            andWithMerchantEmail: "muhamedadly@gmail.com",
            andWithMerchantSecretKey: "Yk8gS8rNArGmElD4KRojAgogiw82HSyGdGW5PnSpPzMuUqzFhXYRem7xTfzB77hkOepDCi3rRPWMfvrwspnHMveFKNgRUycJMCmo",
            andWithAssigneeCode: "SDK",
            andWithThemeColor:UIColor.red,
            andIsThemeColorLight: false)
        
        
        self.initialSetupViewController.didReceiveBackButtonCallback = {
            
        }
        
        self.initialSetupViewController.didStartPreparePaymentPage = {
            // Start Prepare Payment Page
            // Show loading indicator
        }
        self.initialSetupViewController.didFinishPreparePaymentPage = {
            // Finish Prepare Payment Page
            // Stop loading indicator
        }
        
        self.initialSetupViewController.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
            print("Response Code: \(responseCode)")
            print("Response Result: \(result)")
            
            // In Case you are using tokenization
            print("Tokenization Cutomer Email: \(tokenizedCustomerEmail)");
            print("Tokenization Customer Password: \(tokenizedCustomerPassword)");
            print("TOkenization Token: \(token)");
        }

        self.view.addSubview(initialSetupViewController.view)
        self.addChild(initialSetupViewController)
        
        initialSetupViewController.didMove(toParent: self)
    }
    
}

