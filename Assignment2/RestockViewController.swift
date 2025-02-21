//
//  RestoreViewController.swift
//  Assignment2
//
//  Created by Umesh Basnet on 20/02/2025.
//

import UIKit

class RestockViewController: UIViewController, UITableViewDataSource,
    UITableViewDelegate
{

    var productManager: ProductManager?
    @IBOutlet weak var productTable: UITableView!

    @IBOutlet weak var quantityTextField: UITextField!

    var selectedProdcut: Product?

    override func viewDidLoad() {
        super.viewDidLoad()

        productManager =
            (UIApplication.shared.delegate as! AppDelegate).productManager

        productTable.dataSource = self
        productTable.delegate = self
        // Do any additional setup after loading the view.
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

        if let product = productManager?.productList[indexPath.row] {
            cell.textLabel?.text = product.name
            cell.detailTextLabel?.text = String(product.stockQuantity)
        }

        return cell
    }

    func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        selectedProdcut = productManager?.productList[indexPath.row]
    }

    @IBAction func onCancelPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func onRestockPressed(_ sender: Any) {

        if selectedProdcut == nil || ((quantityTextField.text?.isEmpty ?? true)) {
            showErrorDialogWith(
                message: "You have to select a product and provide a quantity")
            return
        }

        if let quantity = Int(quantityTextField.text ?? "") {
            if quantity <= 0 {
                showErrorDialogWith(message: "Quantity must be 1 or more")
                return
            }
            productManager?.addProductQuantity(
                product: selectedProdcut!, quantity: quantity)
            productTable.reloadData()
            quantityTextField.text = ""
        } else {
            showErrorDialogWith(
                message: "Quantity too large")
            return
        }

    }

}
