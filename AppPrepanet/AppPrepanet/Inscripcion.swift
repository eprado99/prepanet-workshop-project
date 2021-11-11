//
//  Inscripcion.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 04/11/21.
//

import UIKit
//import FirebaseFirestoreSwift
class Inscripcion: NSObject {
    //var id: String = UUID().uuidString
    //var WkID: String = UUID().uuidString
    var campusID: String // necesitamos el id o el nombre del campus
    var matriculaAlum: String
    var date: Date
    var status: Bool
    // let periodo
    
    init(campusID : String, matriculaAlum : String, date : Date, status: Bool){
        self.campusID = campusID
        self.matriculaAlum = matriculaAlum
        self.date = date
        self.status = status
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
