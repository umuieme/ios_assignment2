//
//  ViewController.swift
//  Assignment2
//
//  Created by Umesh Basnet on 20/02/2025.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,
    UITableViewDataSource
{
    var productManager : ProductManager?
    var quantity = 0;
    var selectedProduct : Product?

    @IBOutlet weak var productTable: UITableView!

    @IBOutlet weak var labelSelectedProductName: UILabel!

    @IBOutlet weak var labelTotalAmount: UILabel!

    @IBOutlet weak var labelQuantitySelected: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        productManager = (UIApplication.shared.delegate as! AppDelegate).productManager
        
        productTable.delegate = self
        productTable.dataSource = self
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return productManager?.productList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "product_cell", for: indexPath)
        let product = productManager!.productList[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = "\(product.stockQuantity)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let product = productManager?.productList[indexPath.row] {
//            quantity = 0
//            labelTotalAmount.text = "0.0"
//            labelQuantitySelected.text = String(quantity)
            clearSelectedProduct()
            selectedProduct = product
            labelSelectedProductName.text = product.name
            
        }
        
    }
    
    func clearSelectedProduct(){
        quantity = 0
        selectedProduct = nil
        labelSelectedProductName.text = "Select a product"
        labelQuantitySelected.text = "0"
        labelTotalAmount.text = "$0.00"
    }

    @IBAction func onBuyPressed(_ sender: UIButton) {
        
        if(selectedProduct == nil){
            print("please select a product first")
            return
        }
        
        if(quantity == 0){
            print("product is zero")
            return
        }
        
        productManager?.buyProdcut(product: selectedProduct!, quantity: quantity)
        clearSelectedProduct()
        productTable.reloadData()
        
        
    }

    @IBAction func onNumberButtonPressed(_ sender: UIButton) {
        
        if(selectedProduct == nil) {
            print("please select a product first")
            return
        }
        
        let number = sender.tag;
        let newQuantity = quantity * 10 + number;
        
        if(newQuantity > selectedProduct!.stockQuantity){
            
            print("Not enough items")
            return
        }

        quantity = newQuantity;
        
        labelQuantitySelected.text = "\(quantity)"
        let total = selectedProduct!.price * Double(quantity)
        labelTotalAmount.text = "$\(total)"
    }

}
