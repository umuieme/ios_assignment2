//
//  ErrorDialog.swift
//  Assignment2
//
//  Created by Umesh Basnet on 20/02/2025.
//

import UIKit

extension UIViewController {
    func showErrorDialogWith( message: String, title: String = "Error") {
        let alert = UIAlertController(
            title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true)
    }
}
