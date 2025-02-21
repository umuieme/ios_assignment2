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
    var productManager: ProductManager?
    var historyManager: HistoryManager?

    var quantity = 0
    var totalAmount = 0.0
    var selectedProduct: Product?

    @IBOutlet weak var productTable: UITableView!

    @IBOutlet weak var labelSelectedProductName: UILabel!

    @IBOutlet weak var labelTotalAmount: UILabel!

    @IBOutlet weak var labelQuantitySelected: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        productManager =
            (UIApplication.shared.delegate as! AppDelegate).productManager
        historyManager =
            (UIApplication.shared.delegate as! AppDelegate).historyManager

        productTable.delegate = self
        productTable.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        productTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
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
            withIdentifier: "product_cell", for: indexPath) as! ProductItemTableViewCell
        let product = productManager!.productList[indexPath.row]
        cell.labelName?.text = product.name
        cell.labelQuantity?.text = "\(product.stockQuantity)"
        cell.labelPrice?.text = String(format: "$%.2f", product.price)
        return cell
    }

    func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        if let product = productManager?.productList[indexPath.row] {
            clearSelectedProduct()
            selectedProduct = product
            labelSelectedProductName.text = product.name
        }

    }

    func clearSelectedProduct() {
        quantity = 0
        totalAmount = 0.0
        selectedProduct = nil
        labelSelectedProductName.text = "Select a product"
        labelQuantitySelected.text = "0"
        labelTotalAmount.text = "$0.00"
    }

    @IBAction func onBuyPressed(_ sender: UIButton) {

        if selectedProduct == nil {
            showErrorDialogWith(
                message: "Please select product and add quantity to purchase",
                title: "Product not selected")
            return
        }

        if quantity == 0 {
            showErrorDialogWith(
                message: "Please add quantity in order to purchase.",
                title: "Quantity not added")
            return
        }

        productManager?.subtractProductQuantity(
            product: selectedProduct!, quantity: quantity
        )
        historyManager?.add(
            history: History(
                name: selectedProduct!.name, quantity: quantity,
                total: totalAmount, boughtDate: Date()
            )
        )
        clearSelectedProduct()
        productTable.reloadData()

    }

    @IBAction func onNumberButtonPressed(_ sender: UIButton) {

        if selectedProduct == nil {
            showErrorDialogWith(
                message: "Please select a product first",
                title: "Product not selected")
            return
        }

        if selectedProduct!.stockQuantity == 0 {
            showErrorDialogWith(
                message: "\(selectedProduct!.name) is out of stock",
                title: "Out of stock"
            )
            return
        }

        let number = sender.tag
        let newQuantity = quantity * 10 + number

        if newQuantity > selectedProduct!.stockQuantity {
            showErrorDialogWith(
                message:
                    "The quantity cannot be more than \(selectedProduct!.stockQuantity)",
                title: "Not enough stock"
            )
            return
        }

        quantity = newQuantity

        labelQuantitySelected.text = "\(quantity)"
        totalAmount = selectedProduct!.price * Double(quantity)
        labelTotalAmount.text = String(format: "$%.2f", totalAmount)
    }

}
