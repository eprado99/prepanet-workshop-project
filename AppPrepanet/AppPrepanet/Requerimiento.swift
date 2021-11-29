//
//  Requerimiento.swift
//  AppPrepanet
//
//  Created by Emilio Fernando Prado Chible on 29/11/21.
//

import UIKit

class Requerimiento: NSObject {
    var req : String
    var status : String
    
    init(req:String){
        self.req = req
        self.status = ""
    }
    init(req:String, status:String){
        self.req = req
        self.status = status
    }
}
