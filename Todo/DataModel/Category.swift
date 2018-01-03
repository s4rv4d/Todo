//
//  Category.swift
//  Todo
//
//  Created by Sarvad shetty on 12/31/17.
//  Copyright © 2017 Sarvad shetty. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var color : String = ""
    let item = List<Item>()
}
