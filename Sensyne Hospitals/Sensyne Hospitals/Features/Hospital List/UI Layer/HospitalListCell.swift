//
//  HospitalListCell.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 27/10/2020.
//

import UIKit

class HospitalListCell: UITableViewCell {
    
    static let identifier = "HospitalListCell"

    @IBOutlet weak var orgNameLabel: UILabel!
    @IBOutlet weak var orgTypeLabel: UILabel!
    
    func bindData(_ hospital: Hospital) {
        self.orgNameLabel.text = hospital.organisationName
        self.orgTypeLabel.text = hospital.organisationType
    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
//
}
