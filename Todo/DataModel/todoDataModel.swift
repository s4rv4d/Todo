//
//  todoDataModel.swift
//  Todo
//
//  Created by Sarvad shetty on 12/26/17.
//  Copyright © 2017 Sarvad shetty. All rights reserved.
//

import Foundation


//codable or use both encodable and decodable

class Item : Encodable , Decodable{
    
    var title : String?
    var done : Bool = false
    
}
