//
//  Inscripcion.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 04/11/21.
//

import UIKit
//import FirebaseFirestoreSwift
struct Inscripcion: Identifiable, Codable{
    var id: String = UUID().uuidString
    var WkID: String = UUID().uuidString
    var matriculaAlum: String
    var date: Date
    var status: Bool
    // let periodo
    
    enum CodingKeys: String, CodingKey {
        case WkID
        case matriculaAlum
        case date
        case status = "false"
    }
    /*
    enum CodingKeys: String, CodingKey {
        case name
        case state
        case country
        case population
    }
    
    init(
    */
}
