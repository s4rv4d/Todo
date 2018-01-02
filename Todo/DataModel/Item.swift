//
//  Item.swift
//  Todo
//
//  Created by Sarvad shetty on 12/31/17.
//  Copyright © 2017 Sarvad shetty. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var date : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "item")
}
