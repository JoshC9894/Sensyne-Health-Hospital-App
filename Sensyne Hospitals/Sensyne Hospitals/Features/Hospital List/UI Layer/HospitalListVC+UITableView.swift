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
