//
//  Menu+Constants.swift
//  SideMenu
//
//  Created by Sujan Vaidya on 4/13/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

enum MenuItems: Int {
  case CenterVC
  case VCFirst
  case VCSecond
  
  func getVC() -> UINavigationController? {
    switch self {
    case .CenterVC :
      return UIStoryboard.mainNavController()
    case .VCFirst :
      return UIStoryboard.navController1()
      
    case .VCSecond :
      return UIStoryboard.navController2()
    }
  }
  
  var menuTitle: String {
    switch self {
    case .CenterVC :
      return "Center VC"
      
    case .VCFirst :
      return "First VC"
      
    case .VCSecond :
      return "Second VC"
    }
  }
  
  static let count: Int = 3
}
