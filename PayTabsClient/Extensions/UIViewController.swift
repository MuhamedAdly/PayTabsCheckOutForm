//
//  UIViewController.swift
//  PayTabsClient
//
//  Created by Mohamed Adly on 6/3/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showMessage(message: String) {
        let alertViewController = UIAlertController(title: self.title , message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertViewController, animated: true, completion: nil)
    }
}
