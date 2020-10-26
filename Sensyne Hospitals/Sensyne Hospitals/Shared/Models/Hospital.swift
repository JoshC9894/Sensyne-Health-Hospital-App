//
//  Hospital.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 26/10/2020.
//

struct Hospital {
    let organisationId: Int
    let organisationCode: String
    let organisationType: String
    let organisationName: String

    let subtype: String
    let sector: String
    let organisationStatus: String
    let isPimsManaged: Bool
    let parentODSCode: String

    let address1: String
    let address2: String
    let address3: String
    let city: String
    let county: String
    let postcode: String
    let latitude: Double
    let longitude: Double
    let phoneNumber: String
    let website: String
    let fax: String
}
