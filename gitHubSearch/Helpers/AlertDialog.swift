//
//  AlertDialog.swift
//  gitHubSearch
//
//  Created by Yuri Ivashin on 03/09/2019.
//  Copyright © 2019 The Homber Team. All rights reserved.
//

import UIKit

public class AlertDialog {
    private let title: String?
    private let message: String?
    
    init(title: String?, message: String) {
        self.title = title
        self.message = message
    }
    
    func showAlert(in view: UIViewController, completion: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertController.addAction(okAction)
        view.present(alertController, animated: true, completion: nil)
    }
}

