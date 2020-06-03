//
//  CheckOutViewModel.swift
//  PayTabsClient
//
//  Created by Mohamed Adly on 6/3/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation

class CheckOutViewModel {
    private var initialSetupViewController: PTFWInitialSetupViewController!
    private var rootViewController: UIViewController?
    private var phoneNumber: String?
    private var customerEmail: String?
    private var amount: String?
    private var shippingUserInfo: UserInfo!
    private var billingUserInfo: UserInfo!
    private let secretKey = "Yk8gS8rNArGmElD4KRojAgogiw82HSyGdGW5PnSpPzMuUqzFhXYRem7xTfzB77hkOepDCi3rRPWMfvrwspnHMveFKNgRUycJMCmo"
    private let merchantEmail = "muhamedadly@gmail.com"
    
    convenience init(rootViewController: UIViewController) {
        self.init()
        self.rootViewController = rootViewController
    }
    
    func doAction(action: Action) {
        switch action {
        case .validate(let phoneNumber, let email, let amount, let shippingInfo, let billingInfo):
            self.phoneNumber = phoneNumber
            self.customerEmail = email
            self.shippingUserInfo = shippingInfo
            self.billingUserInfo = billingInfo
            self.amount = amount
            if validUserInputs() {
                doAction(action: .checkout)
            }
        case .checkout:
            checkout()
        }
    }
    
    func checkout() {
        guard let rootViewController = rootViewController else { return }
        let amount = ((self.amount ?? "") as NSString).floatValue
        let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
        self.initialSetupViewController = PTFWInitialSetupViewController.init(
            bundle: bundle,
            andWithViewFrame: rootViewController.view.frame,
            andWithAmount: amount,
            andWithCustomerTitle: "PayTabs Sample App",
            andWithCurrencyCode: "USD",
            andWithTaxAmount: 0.0,
            andWithSDKLanguage: "en",
            andWithShippingAddress: shippingUserInfo.address ?? "",
            andWithShippingCity: shippingUserInfo.city ?? "",
            andWithShippingCountry: shippingUserInfo.countryCode ?? "",
            andWithShippingState: shippingUserInfo.state ?? "",
            andWithShippingZIPCode: shippingUserInfo.zipCode ?? "00000",
            andWithBillingAddress: billingUserInfo.address ?? "",
            andWithBillingCity: billingUserInfo.city ?? "",
            andWithBillingCountry: billingUserInfo.countryCode ?? "",
            andWithBillingState: billingUserInfo.state ?? "",
            andWithBillingZIPCode: billingUserInfo.zipCode ?? "00000",
            andWithOrderID: "12345",
            andWithPhoneNumber: phoneNumber ?? "",
            andWithCustomerEmail: customerEmail ?? "",
            andIsTokenization:true,
            andIsPreAuth: false,
            andWithMerchantEmail: merchantEmail,
            andWithMerchantSecretKey: secretKey,
            andWithAssigneeCode: "SDK",
            andWithThemeColor:UIColor.red,
            andIsThemeColorLight: false)
        
        self.initialSetupViewController.didReceiveFinishTransactionCallback = { (responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
            print("Response Code: \(responseCode)")
            print("Response Result: \(result)")
            
            // In Case you are using tokenization
            UserDefaults.saveToken(token: token)
            UserDefaults.saveCustomerEmail(email: tokenizedCustomerEmail)
            UserDefaults.saveCustomerPassword(password: tokenizedCustomerPassword)
            
            let paymentResultViewController = PaymentResultViewController.instantiate(code: responseCode, statusDescription: result, token: token, customerEmail: tokenizedCustomerEmail, customerPassword: tokenizedCustomerPassword)
            DispatchQueue.main.async {
                rootViewController.navigationController?.pushViewController(paymentResultViewController, animated: true)
            }
        }
        rootViewController.view.addSubview(initialSetupViewController.view)
        rootViewController.addChild(initialSetupViewController)
        initialSetupViewController.didMove(toParent: rootViewController)
    }
    enum Action {
        case validate(phoneNumber: String, email: String, amount: String, shippingInfo: UserInfo, billingInfo: UserInfo)
        case checkout
    }
}

extension CheckOutViewModel {
    
    func validUserInputs() -> Bool {
        if !isValidePhoneNumber {
            return false
        } else if !isValideEmail {
            return false
        } else if !isValidAmount {
            return false
        } else if !isValideShippingDetails {
            return false
        } else if !isValidBilingDetails {
            return false
        }
        return true
    }
    
    var isValidePhoneNumber: Bool {
        if let phoneNumber = phoneNumber, !phoneNumber.isBlank, phoneNumber.isValidPhoneNumber {
            return true
        }
        rootViewController?.showMessage(message: "Invalid Phone Number, Please enter valid phone number")
        return false
    }
    
    var isValideEmail: Bool {
        if let email = customerEmail, !email.isBlank, email.isEmail {
            return true
        }
        rootViewController?.showMessage(message: "Invalid Customer Email, Please enter valid email address")
        return true
    }
    
    var isValidAmount: Bool {
        if let amount = amount, amount.isNumber {
            return true
        }
        rootViewController?.showMessage(message: "Please enter valid amount")
        return false
    }
    
    var isValideCountry: Bool {
        if let email = customerEmail, !email.isBlank, email.isEmail {
            return true
        }
        rootViewController?.showMessage(message: "Invalid Customer Email, Please enter valid email address")
        return true
    }
    
    var isValideShippingDetails: Bool {
        if !isValideShippingAddress {
            return false
        } else if !isValideShippingCity {
            return false
        } else if !isValideShippingState {
            return false
        } else if !isValidShippingePostalCode {
            return false
        }
        return true
    }
    
    var isValideShippingAddress: Bool {
        if let address = shippingUserInfo.address, !address.isBlank {
            return true
        }
        rootViewController?.showMessage(message: "Please enter the shipping address")
        return true
    }
    
    var isValideShippingCity: Bool {
        if let city = shippingUserInfo.city, !city.isBlank {
            return true
        }
        rootViewController?.showMessage(message: "Please enter the shipping city")
        return true
    }
    
    var isValideShippingState: Bool {
        if let state = shippingUserInfo.state, !state.isBlank {
            return true
        }
        rootViewController?.showMessage(message: "Please enter the shipping state")
        return true
    }
 
    var isValidShippingePostalCode: Bool {
        if let zipCode = shippingUserInfo.zipCode, !zipCode.isBlank, zipCode.isValidPostalCode {
            return true
        }
        rootViewController?.showMessage(message: "Please enter the shipping zip code")
        return true
    }
    
    var isValidBilingDetails: Bool {
        if !isValideBillingAddress {
            return false
        } else if !isValideBillingCity {
            return false
        } else if !isValideBillingState {
            return false
        } else if !isValidBillingPostalCode {
            return false
        }
        return true
    }
    
    var isValideBillingAddress: Bool {
           if let address = billingUserInfo.address, !address.isBlank {
               return true
           }
           rootViewController?.showMessage(message: "Please enter the billing address")
           return true
       }
       
       var isValideBillingCity: Bool {
           if let city = billingUserInfo.city, !city.isBlank {
               return true
           }
           rootViewController?.showMessage(message: "Please enter the billing city")
           return true
       }
       
       var isValideBillingState: Bool {
           if let state = billingUserInfo.state, !state.isBlank {
               return true
           }
           rootViewController?.showMessage(message: "Please enter the billing state")
           return true
       }
    
       var isValidBillingPostalCode: Bool {
           if let zipCode = billingUserInfo.zipCode, !zipCode.isBlank, zipCode.isValidPostalCode {
               return true
           }
           rootViewController?.showMessage(message: "Please enter the billing zip code")
           return true
       }
    
}

