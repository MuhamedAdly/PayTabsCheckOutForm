//
//  CheckoutViewController.swift
//  PayTabsClient
//
//  Created by Mohamed Adly on 6/3/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import UIKit
import CountryPickerView

class CheckoutViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var customerEmailField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    private let cpv = CountryPickerView(frame: CGRect(x: 0, y: 0, width: 120, height: 20))
    
    private var shippingUserInfo: UserInfo!
    private var billingUserInfo: UserInfo!
    var checkoutViewModel: CheckOutViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Check Out"
        checkoutViewModel = CheckOutViewModel(rootViewController: self)
        shippingUserInfo = UserInfo(address: nil, city: nil, countryCode: nil, state: nil, zipCode: nil)
        billingUserInfo = UserInfo(address: nil, city: nil, countryCode: nil, state: nil, zipCode: nil)
        tableView.register(UINib(nibName: "UserInforInputTableViewCell", bundle: nil), forCellReuseIdentifier: "UserInforInputTableViewCell")
        tableView.register(UINib(nibName: "CountrySelectorTableViewCell", bundle: nil), forCellReuseIdentifier: "CountrySelectorTableViewCell")
        phoneNumberField.leftView = cpv
        phoneNumberField.leftViewMode = .always
    }
    
    @IBAction func checkout() {
        let phoneNumber = cpv.selectedCountry.phoneCode + (phoneNumberField.text ?? "")
        checkoutViewModel.doAction(action: .validate(phoneNumber: phoneNumber,
                                                     email: customerEmailField.text ?? "",
                                                     amount: amountField.text ?? "",
                                                     shippingInfo: shippingUserInfo,
                                                     billingInfo: billingUserInfo))
    }
    
}

extension CheckoutViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Shipping Details" : "Billing Details"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let addressCell = tableView.dequeueReusableCell(withIdentifier: "UserInforInputTableViewCell") as? UserInforInputTableViewCell {
                addressCell.inputTitleLabel.text = "Address:"
                addressCell.inputTextField.text = indexPath.section == 0 ? shippingUserInfo?.address : billingUserInfo?.address
                addressCell.onTextChanged = { [weak self] text in
                    if indexPath.section == 0 {
                        self?.shippingUserInfo.address = text
                    } else {
                        self?.billingUserInfo.address = text
                    }
                }
                return addressCell
            }
        case 1:
            if let cityCell = tableView.dequeueReusableCell(withIdentifier: "UserInforInputTableViewCell") as? UserInforInputTableViewCell {
                cityCell.inputTitleLabel.text = "City:"
                cityCell.inputTextField.text = indexPath.section == 0 ? shippingUserInfo?.city : billingUserInfo?.city
                cityCell.onTextChanged = { [weak self] text in
                    if indexPath.section == 0 {
                        self?.shippingUserInfo.city = text
                    } else {
                        self?.billingUserInfo.city = text
                    }
                }
                return cityCell
            }
        case 2:
            if let countryCell = tableView.dequeueReusableCell(withIdentifier: "CountrySelectorTableViewCell") as? CountrySelectorTableViewCell {
                countryCell.titleLabel.text = "Country Code:"
                countryCell.countryCode = indexPath.section == 0 ? shippingUserInfo.countryCode : billingUserInfo.countryCode
                countryCell.onCountryChanged = { [weak self] in
                    if indexPath.section == 0 {
                        self?.shippingUserInfo.countryCode = $0
                    } else {
                        self?.billingUserInfo.countryCode = $0
                    }
                }
                return countryCell
            }
           
        case 3:
            if let stateCell = tableView.dequeueReusableCell(withIdentifier: "UserInforInputTableViewCell") as? UserInforInputTableViewCell {
                stateCell.inputTitleLabel.text = "State:"
                stateCell.inputTextField.text = indexPath.section == 0 ? shippingUserInfo?.state : billingUserInfo?.state
                stateCell.onTextChanged = { [weak self] text in
                    if indexPath.section == 0 {
                        self?.shippingUserInfo.state = text
                    } else {
                        self?.billingUserInfo.state = text
                    }
                }
                return stateCell
            }
        case 4:
            if let zipCodeCell = tableView.dequeueReusableCell(withIdentifier: "UserInforInputTableViewCell") as? UserInforInputTableViewCell {
                zipCodeCell.inputTitleLabel.text = "Zip Code:"
                zipCodeCell.inputTextField.text = indexPath.section == 0 ? shippingUserInfo?.zipCode : billingUserInfo?.zipCode
                zipCodeCell.onTextChanged = { [weak self] text in
                    if indexPath.section == 0 {
                        self?.shippingUserInfo.zipCode = text
                    } else {
                        self?.billingUserInfo.zipCode = text
                    }
                }
                return zipCodeCell
            }
        default:
            break
        }
        return UITableViewCell()
    }
}
