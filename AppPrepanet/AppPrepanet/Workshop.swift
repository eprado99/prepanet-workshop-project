//
//  Workshop.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 30/10/21.
//

import UIKit

class Workshop: NSObject {
    
    var wkID: String
    var title: String
    var descr: String
    var req: [String]
    var startDate: Date
    var endDate: Date
    var status : String!
    
    init(wkID: String, title: String, descr: String, req: [String], startDate: Date, endDate: Date) {
        self.wkID = wkID
        self.title = title
        self.descr = descr
        self.req = req
        self.startDate = startDate
        self.endDate = endDate
        self.status = ""
    }
    
    init(wkID: String, title: String, descr: String, req: [String], startDate: Date, endDate: Date, status : String) {
        self.wkID = wkID
        self.title = title
        self.descr = descr
        self.req = req
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
    }
}

// MARK: - Docs
// El ID del taller decide en que orden se muestran (1,2,3...)
// Un taller consiste de "titulo", "descripcion" y "requerimientos".
// "requerimientos" es un array de Strings
