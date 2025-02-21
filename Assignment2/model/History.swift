//
//  History.swift
//  Assignment2
//
//  Created by Umesh Basnet on 20/02/2025.
//

import Foundation

class History {
    var id : UUID = UUID()
    var quantity : Int
    var total : Double
    var boughtDate : Date
    var name: String
    
    init(name: String, quantity: Int, total: Double, boughtDate: Date) {
        self.quantity = quantity
        self.total = total
        self.boughtDate = boughtDate
        self.name = name
    }
    
}
