//
//  UIAlertViewModel.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/30.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import UIKit

struct UIAlertViewModel {
    let title: String?
    let message: String
    let style: UIAlertController.Style?
    let ok: UIAlertActionModel?
    let cancel: UIAlertActionModel?

    private init(
        message: String,
        title: String?,
        ok: UIAlertActionModel?,
        cancel: UIAlertActionModel?,
        style: UIAlertController.Style = UIAlertController.Style .alert
    ) {
        self.title = title
        self.message = message
        self.style = style
        self.ok = ok
        self.cancel = cancel
    }

    class Builder {
        var title: String?
        var message: String
        var okAction: UIAlertActionModel?
        var cancelAction: UIAlertActionModel?
        
        public init(message: String) {
            self.message = message
        }
        
        func setTitle(title: String) -> Builder {
            self.title = title
            return self
        }
        func setMessage(message: String) -> Builder {
            self.message = message
            return self
        }
        func setOk(
            buttonTitle: String = L10n.ok,
            style: UIAlertAction.Style = UIAlertAction.Style.default,
            doAction: ((UIAlertAction) -> Void)? = nil
        ) -> Builder {
            self.okAction = UIAlertActionModel(title: buttonTitle, action: doAction)
            return self
        }
        func setCancel(
            title: String = L10n.cancel,
            style: UIAlertAction.Style = UIAlertAction.Style.cancel,
            doAction: ((UIAlertAction) -> Void)? = nil
        ) -> Builder {
            self.cancelAction = UIAlertActionModel(title: title, action: doAction)
            return self
        }
        func build() -> UIAlertViewModel {
            if okAction == nil, cancelAction == nil {
                self.okAction = UIAlertActionModel(title: L10n.ok)
            }
            return UIAlertViewModel(
                message: self.message,
                title: self.title,
                ok: self.okAction,
                cancel: self.cancelAction
            )
        }
    }
}
