//
//  HistoryListTableViewController.swift
//  Assignment2
//
//  Created by Umesh Basnet on 20/02/2025.
//

import UIKit

class HistoryListTableViewController: UITableViewController {
    
    var historyManager : HistoryManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyManager = (UIApplication.shared.delegate as! AppDelegate).historyManager
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyManager?.historyList.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyItemCell", for: indexPath)
        if let history = historyManager?.historyList[indexPath.row]{
            cell.textLabel?.text = history.name
            cell.detailTextLabel?.text = String(history.quantity)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let historyDetailController = segue.destination as! HistoryDetailViewController
        
        if let selectedRow = tableView.indexPathForSelectedRow {
            historyDetailController.history = historyManager?.historyList[selectedRow.row]
        }
        
    }

    

}
