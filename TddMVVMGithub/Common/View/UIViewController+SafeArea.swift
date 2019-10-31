//
//  UIViewController+SafeArea.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/31.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {
    
    var safeAreaBottom: ConstraintItem {
        if #available(iOS 11, *) {
            return self.view.safeAreaLayoutGuide.snp.bottom
        } else {
            return self.view.snp.bottom
        }
    }
    var safeAreaTop: ConstraintItem {
        if #available(iOS 11, *) {
            return self.view.safeAreaLayoutGuide.snp.top
        } else {
            return self.view.snp.top
        }
    }
    var safeAreaLeading: ConstraintItem {
        if #available(iOS 11, *) {
            return self.view.safeAreaLayoutGuide.snp.leading
        } else {
            return self.view.snp.leading
        }
    }
    var safeAreaTrailing: ConstraintItem {
        if #available(iOS 11, *) {
            return self.view.safeAreaLayoutGuide.snp.trailing
        } else {
            return self.view.snp.trailing
        }
    }
}
