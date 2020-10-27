//
//  CSVFile.swift
//  Sensyne Hospitals
//
//  Created by Joshua Colley on 26/10/2020.
//

import Foundation

class CSVFile {
    private let rowSeperator = "\r"
    private let columnSeperator = "¬"
    
    var keys: [String]
    var rows: [String]
    
    init(data: Data) {
        let csvString = String(data: data, encoding: String.Encoding.ascii) ?? ""
        self.rows = csvString.components(separatedBy: "\r")
        self.keys = self.rows.first?.components(separatedBy: "¬") ?? []
        self.rows.removeFirst()
    }
    
    func columnsForRow(at index: Int) -> [String] {
        let columns = self.rows[index].components(separatedBy: "¬")
        return columns
    }
}
