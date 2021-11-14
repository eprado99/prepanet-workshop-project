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
    
    init(wkID: String, title: String, descr: String, req: [String]) {
        self.wkID = wkID
        self.title = title
        self.descr = descr
        self.req = req
    }
    
}

// MARK: - Docs
// El ID del taller decide en que orden se muestran (1,2,3...)
// Un taller consiste de "titulo", "descripcion" y "requerimientos".
// "requerimientos" es un array de Strings
