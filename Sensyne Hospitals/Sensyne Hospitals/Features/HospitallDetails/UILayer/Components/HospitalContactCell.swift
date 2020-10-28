//
//  HospitalContactCell.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 28/10/2020.
//

import UIKit

protocol HospitalContactCellDelegate: class {
    func didTapPhoneButton()
    func didTapEmailButton()
    func didTapWebButton()
}

class HospitalContactCell: UITableViewCell {
    static let identifier: String = "HospitalContactCell"
    static let cellHeight: CGFloat = UITableView.automaticDimension
    
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    
    weak var delegate: HospitalContactCellDelegate?
    
    func bindData(_ hospital: Hospital) {
        phoneLabel.text = hospital.displayPhoneNumber()
        emailLabel.text = hospital.displayEmail()
        websiteLabel.text = hospital.displayWebsite()
        
        phoneButton.isEnabled = !hospital.phoneNumber.isEmpty
        emailButton.isEnabled = !hospital.email.isEmpty
        websiteButton.isEnabled = !hospital.website.isEmpty
    }
    
    // MARK: - Actions
    @IBAction func phoneButtonAction(_ sender: UIButton) {
        self.delegate?.didTapPhoneButton()
    }
    
    @IBAction func emailButtonAction(_ sender: UIButton) {
        self.delegate?.didTapEmailButton()
    }
    
    @IBAction func websiteButtonAction(_ sender: UIButton) {
        self.delegate?.didTapWebButton()
    }
}
