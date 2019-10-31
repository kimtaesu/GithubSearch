//
//  GitUserSection.swift
//  TddMVVMGithub
//
//  Created by tskim on 2019/10/30.
//  Copyright © 2019 hucet. All rights reserved.
//

import RxDataSources

struct GitUserSection {
    var header: String
    var items: [Item]
}

extension GitUserSection: AnimatableSectionModelType {
    typealias Item = GitUser
    init(original: GitUserSection, items: [Item]) {
        self = original
        self.items = items
    }
    
    var identity: String {
        return header
    }
}
