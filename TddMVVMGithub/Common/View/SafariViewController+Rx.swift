//
//  SafariViewController+Rx.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/31.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxSwift
import RxCocoa

struct SafariRouteArgument {
    let url: String
    let completionHandler: ((Bool) -> Void)? = nil
}
extension Reactive where Base: UIViewController {
    var presentSafari: Binder<SafariRouteArgument> {
        return Binder(self.base) { vc, arg in
            guard let url = URL(string: arg.url), UIApplication.shared.canOpenURL(url) else {
                logger.error("The Safari can't open url")
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: arg.completionHandler)
        }
    }
}
