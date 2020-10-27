//
//  Hospital.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 26/10/2020.
//

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
}
