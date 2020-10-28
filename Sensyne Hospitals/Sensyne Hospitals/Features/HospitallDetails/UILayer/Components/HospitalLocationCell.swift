//
//  HospitalLocationCell.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 28/10/2020.
//

import UIKit
import MapKit

class HospitalLocationCell: UITableViewCell {
    static let identifier: String = "HospitalLocationCell"
    static let cellHeight: CGFloat = UITableView.automaticDimension
    private let mapDistance: CLLocationDistance = CLLocationDistance(1200)
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        self.mapView.layer.cornerRadius = 8.0
        super.awakeFromNib()
    }
    
    func bindData(_ hospital: Hospital) {
        self.addressLabel.text = hospital.displayAddress()
        
        let annotation = self.createAnnotation(for: hospital)
        let region = MKCoordinateRegion(center: hospital.coordinates(),
                                        latitudinalMeters: self.mapDistance,
                                        longitudinalMeters: self.mapDistance)
        
        self.mapView.setCenter(hospital.coordinates(), animated: true)
        self.mapView.setRegion(region, animated: true)
        self.mapView.addAnnotation(annotation)
    }
    
    // MARK: - Helper Method
    private func createAnnotation(for hospital: Hospital) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = hospital.coordinates()
        return annotation
    }
}
