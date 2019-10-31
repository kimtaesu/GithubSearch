//
//  MemoryAddress.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/30.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

func addressOf(_ o: UnsafeRawPointer) -> String {
  let addr = Int(bitPattern: o)
  return String(format: "%p", addr)
}

func addressOf<T: AnyObject>(_ o: T) -> String {
  let addr = unsafeBitCast(o, to: Int.self)
  return String(format: "%p", addr)
}
