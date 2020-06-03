//
//  PaymentResultViewController.swift
//  PayTabsClient
//
//  Created by Mohamed Adly on 6/3/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import UIKit

class PaymentResultViewController: UIViewController {

    @IBOutlet weak var statusCodeLabel: UILabel!
    @IBOutlet weak var statusDescriptionLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    
    var code: Int32 = 0
    var statusDescription: String?
    var token: String?
    var customerEmail: String?
    var customerPassword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusCodeLabel.text = "\(code)"
        statusCodeLabel.textColor = code == 100 ? .systemGreen : .red
        statusDescriptionLabel.text = statusDescription
        statusDescriptionLabel.textColor = code == 100 ? .systemGreen : .red
        emailLabel.text = customerEmail
        passwordLabel.text = customerPassword
        tokenLabel.text = token
    }

    static func instantiate(code: Int32, statusDescription: String, token: String?, customerEmail: String?, customerPassword: String?) -> PaymentResultViewController {
        let paymentResultViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentResultViewController") as? PaymentResultViewController ?? PaymentResultViewController()
        paymentResultViewController.code = code
        paymentResultViewController.statusDescription = statusDescription
        paymentResultViewController.token = token
        paymentResultViewController.customerEmail = customerEmail
        paymentResultViewController.customerPassword = customerPassword
        return paymentResultViewController
    }

}
