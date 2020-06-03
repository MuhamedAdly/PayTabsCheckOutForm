//
//  CountrySelectorTableViewCell.swift
//  PayTabsClient
//
//  Created by Mohamed Adly on 6/3/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import UIKit
import CountryPickerView

class CountrySelectorTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countryPickerView: CountryPickerView?
    var onCountryChanged: ((_ countryCode: String) -> Void)?
    
    var countryCode: String? {
        didSet {
            if let countryPickerView = countryPickerView, let countryCode = countryCode {
                countryPickerView.setCountryByCode(countryCode)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        countryPickerView?.delegate = self
        countryPickerView?.showCountryNameInView = true
        countryPickerView?.showPhoneCodeInView = true
    }
}

extension CountrySelectorTableViewCell: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        if let onCountryChanged = onCountryChanged {
            onCountryChanged(country.isoCode3)
        }
    }
}
