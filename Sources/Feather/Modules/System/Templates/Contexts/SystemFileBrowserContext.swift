//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 22..
//

import FeatherApi

struct SystemFileBrowserContext {

    let list: FeatherFile.Directory.List
    
    init(list: FeatherFile.Directory.List) {
        self.list = list
    }
}