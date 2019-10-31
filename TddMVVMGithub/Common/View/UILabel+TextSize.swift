//
//  UILabel+TextSize.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/31.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

extension UILabel {
  func setTextSize(_ size: CGFloat) {
    self.font = self.font.withSize(size)
  }
}

extension UIButton {
  func setTextSize(_ size: CGFloat) {
    self.titleLabel?.setTextSize(size)
  }
}
