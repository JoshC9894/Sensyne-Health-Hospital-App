//
//  HospitalDetailsCell.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 27/10/2020.
//

import UIKit

class HospitalDetailsCell: UITableViewCell {
    static let identifier: String = "HospitalDetailsCell"
    static let cellHeight: CGFloat = UITableView.automaticDimension
    
    @IBOutlet weak var organisationNameLabel: UILabel!
    @IBOutlet weak var organisationTypeLabel: UILabel!
    
    func bindData(_ hospital: Hospital) {
        self.organisationNameLabel.text = hospital.organisationName
        self.organisationTypeLabel.text = hospital.organisationType
    }
}
