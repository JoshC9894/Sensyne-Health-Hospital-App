//
//  HospitalListViewModel.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 26/10/2020.
//

import UIKit

// MARK: - HospitalListViewModelProtocol
protocol HospitalListViewModelProtocol {
    func fetchHospitals()
    func filterHospitals(by query: String)
    func didTapFilterButton()
    var searchBarPlaceholderText: NSAttributedString { get }
}

// MARK: - HospitalListViewModel
class HospitalListViewModel: HospitalListViewModelProtocol {
    weak var view: HospitalListViewProtocol?
    var networkManager: NetworkManagerProtocol
    var queue: DispatchQueue = DispatchQueue.main
    private var hospitals: [Hospital]!
    private var filteredHospitals: [Hospital]?
    private var isFilteredByNHS: Bool = false
    
    init(view: HospitalListViewProtocol?) {
        self.view = view
        self.networkManager = NetworkManager()
    }
    
    // MARK: HospitalListViewModelProtocol Methods
    var searchBarPlaceholderText: NSAttributedString = {
        let text = "Search hospitals"
        let string = NSAttributedString(string: text, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ])
        return string
    }()
    
    func fetchHospitals() {
        let url = "http://media.nhschoices.nhs.uk/data/foi/Hospital.csv"
        networkManager.request(url: url, type: .get) { (result) in
            switch result {
            case .success(let data):
                if let data = data {
                    let csv = CSVFile(data: data)
                    let models = self.parseCSV(csv: csv)
                    self.hospitals = models
                    self.queue.async {
                        self.view?.updateHospitalsList(models)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func filterHospitals(by query: String) {
        if query.isEmpty {
            self.filteredHospitals = nil
        } else {
            let filtered = self.hospitals?.filter({ $0.organisationName.contains(query) }) ?? []
            self.filteredHospitals = filtered
        }
        self.filterByIsNHS()
    }
    
    func didTapFilterButton() {
        let actionSheet = UIAlertController(title: "Filters", message: nil, preferredStyle: .actionSheet)
        let pimsFilter: UIAlertAction = {
            let action = UIAlertAction(title: "Only NHS trusts", style: .default, handler: { (_) in
                self.filterByIsNHS()
            })
            if (self.isFilteredByNHS) {
                let image = UIImage(named: "tick")
                action.setValue(image, forKey: "image")
            }
            return action
        }()
        actionSheet.addAction(pimsFilter)
        actionSheet.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.view?.presentFilters(actionSheet)
    }
    
    // MARK: Private Methods
    private func filterByIsNHS() {
        self.isFilteredByNHS = !self.isFilteredByNHS
        var models = self.filteredHospitals ?? (self.hospitals ?? [])
        if self.isFilteredByNHS {
            models = models.filter({ $0.parentName.lowercased().contains("nhs") })
        }
        self.view?.updateHospitalsList(models)
    }
    
    private func parseCSV(csv: CSVFile) -> [Hospital] {
        var hospitals: [Hospital] = []
        csv.rows.enumerated().forEach { (index, _) in
            let columns = csv.columnsForRow(at: index)
            var hospital = Hospital()
            columns.enumerated().forEach { (index, columnValue) in
                let key = csv.keys[index]
                if let field: HospitalCSVField = HospitalCSVField.init(rawValue: key) {
                    self.updateField(field, for: &hospital, with: columnValue)
                }
            }
            hospitals.append(hospital)
        }
        return hospitals
    }
    
    private func updateField(_ field: HospitalCSVField, for hospital: inout Hospital, with value: String) {
        switch field {
        case .OrganisationId: hospital.organisationId = String(value.drop(while: { $0 == "\n"}))
        case .OrganisationCode: hospital.organisationCode = value
        case .OrganisationType: hospital.organisationType = value
        case .SubType: hospital.subtype = value
        case .Sector: hospital.sector = value
        case .OrganisationStatus: hospital.organisationStatus = value
        case .IsPimsManaged: hospital.isPimsManaged = Bool(value) ?? false
        case .OrganisationName: hospital.organisationName = value
        case .Address1: hospital.address1 = value
        case .Address2: hospital.address2 = value
        case .Address3: hospital.address3 = value
        case .City: hospital.city = value
        case .County: hospital.county = value
        case .Postcode: hospital.postcode = value
        case .Latitude: hospital.latitude = Double(value) ?? 0.0
        case .Longitude: hospital.longitude = Double(value) ?? 0.0
        case .ParentODSCode: hospital.parentODSCode = value
        case .ParentName: hospital.parentName = value
        case .Phone: hospital.phoneNumber = value
        case .Email: hospital.email = value
        case .Website: hospital.website = value
        case .Fax: hospital.fax = String(value.drop(while: { $0 == "\n"}))
        }
    }
}
