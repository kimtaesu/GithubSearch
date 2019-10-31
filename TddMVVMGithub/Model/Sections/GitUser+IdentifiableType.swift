//
//  GitUser+RxDataSoruce.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/30.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxDataSources

extension GitUser: IdentifiableType {
    var identity: Int {
        return id
    }
}
