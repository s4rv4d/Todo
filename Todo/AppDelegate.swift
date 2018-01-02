//
//  AppDelegate.swift
//  Todo
//
//  Created by Sarvad shetty on 12/25/17.
//  Copyright © 2017 Sarvad shetty. All rights reserved.Sea
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
     
       // print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        do{
            _ = try Realm()
            
        }
        catch{
            print("error initialising an object of realm \(error)")
        }
        
        
        return true
    }

}

