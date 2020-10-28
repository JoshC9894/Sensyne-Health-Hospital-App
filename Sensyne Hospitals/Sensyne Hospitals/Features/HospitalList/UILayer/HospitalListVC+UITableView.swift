//
//  HospitalListVC+UITableViewDataSource.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 27/10/2020.
//

import UIKit

// MARK: - UITableViewDelegate
extension HospitalListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = HospitalDetailsVC.storyboardIdentifier
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as? HospitalDetailsVC else {
            return
        }
        let hospital = self.hospitals[indexPath.row]
        vc.viewModel.hospital = hospital
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HospitalListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hospitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = HospitalListCell.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? HospitalListCell else {
            return UITableViewCell()
        }
        let hospital = self.hospitals[indexPath.row]
        cell.bindData(hospital)
        return cell
    }
}
