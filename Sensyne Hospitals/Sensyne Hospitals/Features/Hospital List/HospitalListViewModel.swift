//
//  HospitalListViewModel.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 26/10/2020.
//

// MARK: - HospitalListViewModelProtocol
protocol HospitalListViewModelProtocol {
    func fetchHospitals()
}

// MARK: - HospitalListViewModel
class HospitalListViewModel: HospitalListViewModelProtocol {
    weak var view: HospitalListViewProtocol?
    var networkManager: NetworkManagerProtocol
    
    init(view: HospitalListViewProtocol?) {
        self.view = view
        self.networkManager = NetworkManager()
    }
    
    // MARK: HospitalListViewModelProtocol Methods
    func fetchHospitals() {
        let url = "http://media.nhschoices.nhs.uk/data/foi/Hospital.csv"
        networkManager.request(url: url, type: .get) { (result) in
            switch result {
            case .success(let data):
                if let data = data {
                    print(data)
                    return
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
}
