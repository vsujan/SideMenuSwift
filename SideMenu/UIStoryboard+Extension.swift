//
//  UIStoryboard+Extension.swift
//  SideMenu
//
//  Created by Sujan Vaidya on 4/13/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

extension UIStoryboard {
  class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
  
  class func mainNavController() -> UINavigationController? {
    return mainStoryboard().instantiateViewController(withIdentifier: "CenterNav") as? UINavigationController
  }
  
  class func navController1() -> UINavigationController? {
    return mainStoryboard().instantiateViewController(withIdentifier: "Nav1") as? UINavigationController
  }
  
  class func navController2() -> UINavigationController? {
    return mainStoryboard().instantiateViewController(withIdentifier: "Nav2") as? UINavigationController
  }
  
  class func leftViewController() -> SideVC? {
//    let vc: SideVC = AppStoryboard.main.instantiate()

    return mainStoryboard().instantiateViewController(withIdentifier: "SideVC") as? SideVC
  }
  
  class func centerViewController() -> CenterVC? {
    return mainStoryboard().instantiateViewController(withIdentifier: "CenterVC") as? CenterVC
  }
  
}

/*
extension NSObject {
  static var className: String {
    return "\(self)"
  }
}

enum AppStoryboard: String {
  case main = "Main"
  
  func instantiate<T: UIViewController>() -> T {
      return storyboard.instantiateViewController(withIdentifier: T.className) as! T
  }
  
  var storyboard: UIStoryboard {
    return UIStoryboard(name: self.rawValue, bundle: nil)
  }
  
} */
