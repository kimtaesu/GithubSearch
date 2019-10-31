//
//  UILabel+Empty.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/31.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UICollectionView {
    func setEmptyView(view: UILabel) -> Binder<String> {
        return Binder(self.base) { cv, msg in
            logger.info("empty message: \(msg)")
            if msg.isEmpty {
                cv.backgroundView = nil
            } else {
                view.text = msg
                cv.backgroundView = view
            }
        }
    }
}
