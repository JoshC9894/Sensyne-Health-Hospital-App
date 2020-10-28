//
//  Hospital.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 26/10/2020.
//

import CoreLocation

struct Hospital {
    var organisationId: String
    var organisationCode: String
    var organisationType: String
    var organisationName: String
    var organisationStatus: String

    var subtype: String
    var sector: String
    var isPimsManaged: Bool
    var parentODSCode: String
    var parentName: String

    var address1: String
    var address2: String
    var address3: String
    var city: String
    var county: String
    var postcode: String
    var latitude: Double
    var longitude: Double
    var phoneNumber: String
    var email: String
    var website: String
    var fax: String
    
    init() {
        self.organisationId = ""
        self.organisationCode = ""
        self.organisationType = ""
        self.organisationName = ""
        self.organisationStatus = ""
        
        self.subtype = ""
        self.sector = ""
        self.isPimsManaged = false
        self.parentODSCode = ""
        self.parentName = ""
        
        self.address1 = ""
        self.address2 = ""
        self.address3 = ""
        self.city = ""
        self.county = ""
        self.postcode = ""
        self.latitude = 0.0
        self.longitude = 0.0
        self.phoneNumber = ""
        self.email = ""
        self.website = ""
        self.fax = ""
    }
    
    func displayAddress() -> String {
        var string = ""
        if !self.address1.isEmpty { string = address1}
        if !self.address2.isEmpty { string = string + ((string.isEmpty) ? address2 : ", \(address2)") }
        if !self.address3.isEmpty { string = string + ((string.isEmpty) ? address3 : ", \(address3)") }
        if !self.city.isEmpty { string = string + ((string.isEmpty) ? city : ", \(city)") }
        if !self.county.isEmpty { string = string + ((string.isEmpty) ? county : ", \(county)") }
        if !self.postcode.isEmpty { string = string + ((string.isEmpty) ? postcode : ", \(postcode)") }
        return string
    }
    
    func coordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: self.latitude) ?? self.latitude,
                                      longitude: CLLocationDegrees(exactly: self.longitude) ?? self.longitude)
    }
    
    func displayPhoneNumber() -> String {
        return self.phoneNumber.isEmpty ? "Not available" : self.phoneNumber
    }
    
    func phoneURL() -> URL? {
        let number = self.phoneNumber.replacingOccurrences(of: " ", with: "")
        return URL(string: "tel://\(number)")
    }
    
    func displayEmail() -> String {
        return self.email.isEmpty ? "Not available" : self.email
    }
    
    func displayWebsite() -> String {
        return self.website.isEmpty ? "Not available" : self.website
    }
    
    func websiteURL() -> URL? {
        let url = self.website.replacingOccurrences(of: " ", with: "")
        return URL(string: url)
    }
}
