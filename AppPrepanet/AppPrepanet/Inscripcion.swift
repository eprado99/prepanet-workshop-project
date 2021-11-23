//
//  Inscripcion.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 04/11/21.
//

import UIKit

class Inscripcion: NSObject {
    
    var wkID: String
    var campusID: String
    var matriculaAlum: String
    var date: Date
    var status: String
    
    init(wkID: String, campusID : String, matriculaAlum : String, status : String ,date : Date){
        self.date = date
        self.campusID = campusID
        self.matriculaAlum = matriculaAlum
        self.status = "En Proceso"
        self.wkID = wkID
    }
    
}
