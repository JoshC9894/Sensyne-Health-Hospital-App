//
//  HospitalDetailsVC.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 27/10/2020.
//

import UIKit
import MessageUI

// MARK: - HospitalDetailsViewProtocol
protocol HospitalDetailsViewProtocol: class {}

// MARK: - HospitalDetailsVC
class HospitalDetailsVC: UIViewController {
    static let storyboardIdentifier: String = "HospitalDetailsVC"
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: HospitalDetailsViewModelProtocol = { [weak self] in
        return HospitalDetailsViewModel(view: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hospital details"
        registerCells()
    }
    
    // MARK: - Helper Methods
    private func registerCells() {
        let detailsCellNib = UINib(nibName: HospitalDetailsCell.identifier, bundle: nil)
        self.tableView.register(detailsCellNib, forCellReuseIdentifier: HospitalDetailsCell.identifier)
        
        let locationCellNib = UINib(nibName: HospitalLocationCell.identifier, bundle: nil)
        self.tableView.register(locationCellNib, forCellReuseIdentifier: HospitalLocationCell.identifier)
        
        let contactCellNib = UINib(nibName: HospitalContactCell.identifier, bundle: nil)
        self.tableView.register(contactCellNib, forCellReuseIdentifier: HospitalContactCell.identifier)
    }
    
    private func displayErrorAlert() {
        let alert = UIAlertController(title: "Not available",
                                      message: "Sorry, we can't do this right now",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
    }
}



// MARK: HospitalDetailsViewProtocol
extension HospitalDetailsVC: HospitalDetailsViewProtocol {
    
}

// MARK: - HospitalContactCellDelegate
extension HospitalDetailsVC: HospitalContactCellDelegate {
    func didTapPhoneButton() {
        guard let url = viewModel.hospital.phoneURL() else { return }
        guard UIApplication.shared.canOpenURL(url as URL) else { displayErrorAlert(); return }
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }

    func didTapEmailButton() {
        guard MFMailComposeViewController.canSendMail() else { displayErrorAlert(); return }
        let email = viewModel.hospital.email.replacingOccurrences(of: " ", with: "")
        let mailVC = MFMailComposeViewController()
        mailVC.setToRecipients([email])
        mailVC.mailComposeDelegate = self
        self.present(mailVC, animated: true, completion: nil)
    }

    func didTapWebButton() {
        guard let url = viewModel.hospital.websiteURL() else { return }
        guard UIApplication.shared.canOpenURL(url as URL) else { displayErrorAlert(); return }
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
}

// MARK: - MFMailCompose
extension HospitalDetailsVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
