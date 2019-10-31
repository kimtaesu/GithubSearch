//
//  UIViewController+Alert.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/30.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
    var showAlertView: Binder<UIAlertViewModel> {
        return Binder(self.base) { vc, alert in
            UIAlertControllerViewer.shared.show(vc, alert: alert)
        }
    }
}
