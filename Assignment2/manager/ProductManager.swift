//
//  ProductManager.swift
//  Assignment2
//
//  Created by Umesh Basnet on 20/02/2025.
//

class ProductManager {

    var productList: [Product] = []

    init() {
        self.productList = self.addDummyProducts()
    }
    
    func subtractProductQuantity(product: Product, quantity: Int) {
        productList.first { p in
            return p.id == product.id
        }?.stockQuantity = product.stockQuantity - quantity
    }

    func addProductQuantity(product : Product, quantity : Int ){
        productList.first { p in
            return p.id == product.id
        }?.stockQuantity = product.stockQuantity + quantity
    }

    func addDummyProducts() -> [Product] {
        return [
            Product(name: "Shirt", price: 10.50, stockQuantity: 20),
            Product(name: "Pant", price: 15.99, stockQuantity: 30),
            Product(name: "Half Pant", price: 9.59, stockQuantity: 15),
            Product(name: "Hoodie", price: 25.99, stockQuantity: 10),
            Product(name: "Jacket", price: 50.59, stockQuantity: 20),
            Product(name: "Shoe", price: 80.99, stockQuantity: 17),
            Product(name: "T-shirts", price: 5.99, stockQuantity: 58),
        ]
    }

}
