//
//  HospitalDetailsVC+UITableView.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 27/10/2020.
//

import UIKit

enum HospitalDetailSections: Int {
    case details, location, contact, count
}

// MARK: - UITableViewDelegate
extension HospitalDetailsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = HospitalDetailSections(rawValue: indexPath.row) else { return 0.0 }
        switch section {
        case .details: return HospitalDetailsCell.cellHeight
        case .location: return HospitalLocationCell.cellHeight
        case .contact: return HospitalContactCell.cellHeight
        default: return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}

// MARK: - UITableViewDataSource
extension HospitalDetailsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HospitalDetailSections.count.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HospitalDetailSections(rawValue: indexPath.row) else { return UITableViewCell() }
        switch section {
        case .details:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HospitalDetailsCell.identifier, for: indexPath) as? HospitalDetailsCell else {
                return UITableViewCell()
            }
            cell.bindData(self.viewModel.hospital)
            return cell
            
        case .location:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HospitalLocationCell.identifier, for: indexPath) as? HospitalLocationCell else {
                return UITableViewCell()
            }
            cell.bindData(self.viewModel.hospital)
            return cell
            
        case .contact:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HospitalContactCell.identifier, for: indexPath) as? HospitalContactCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.bindData(self.viewModel.hospital)
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
}
