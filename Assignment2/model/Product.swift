//
//  Product.swift
//  Assignment2
//
//  Created by Umesh Basnet on 20/02/2025.
//

import Foundation

class Product {

    var id: UUID = UUID()
    var name: String
    var price: Double
    var stockQuantity: Int

    init(name: String, price: Double, stockQuantity: Int) {
        self.name = name
        self.price = price
        self.stockQuantity = stockQuantity
    }

}
