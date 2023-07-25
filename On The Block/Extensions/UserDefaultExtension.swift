//
//  UserDefaultExtension.swift
//  Launch screen
//
//  Created by Abe Molina on 6/8/23.
//

import Foundation
import UIKit


extension UserDefaults {
    
    var authorizationEnabled: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "authorizationEnabled") as? Bool) ?? false }
                set {
                    UserDefaults.standard.setValue(newValue, forKey: "authorizationEnabled")
                }
            }
        }


extension UserDefaults {
    
    var welcomeScreenShown: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "welcomeScreenShown") as? Bool) ?? false }
                set {
                    UserDefaults.standard.setValue(newValue, forKey: "welcomeScreenShown")
                }
            }
        }


