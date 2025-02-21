//
//  HistoryDetailViewController.swift
//  Assignment2
//
//  Created by Umesh Basnet on 20/02/2025.
//

import UIKit

class HistoryDetailViewController: UIViewController {
    
    var history : History?

    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelQuantity: UILabel!
    
    @IBOutlet weak var labelTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(history != nil){
            labelName.text = history!.name
            labelQuantity.text = String(history!.quantity)
            labelTotal.text = String(format: "$%.2f", history!.total)
            labelDate.text = "\(history!.boughtDate)"
            title = history?.name
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
