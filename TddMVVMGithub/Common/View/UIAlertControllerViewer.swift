//
//  UIAlertControllerViewer.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/30.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

class UIAlertControllerViewer {
    private static var _instance: UIAlertControllerViewer = {
        return UIAlertControllerViewer()
    }()
    static var shared: UIAlertControllerViewer {
        return _instance
    }
}

extension UIAlertControllerViewer {
    func show(_ vc: UIViewController, alert: UIAlertViewModel) {
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        if let ok = alert.ok {
            alertController.addAction(ok.alertAction)
        }
        
        if let cancel = alert.cancel {
            alertController.addAction(cancel.alertAction)
        }
        
        if alertController.actions.isEmpty {
            alertController.addAction(UIAlertAction(title: L10n.ok, style: .default))
        }
        vc.present(alertController, animated: true)
    }

}
