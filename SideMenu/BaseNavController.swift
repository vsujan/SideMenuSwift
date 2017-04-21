//
//  BaseNavController.swift
//  SideMenu
//
//  Created by Sujan Vaidya on 4/13/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

protocol NavBtnProtocol: NSObjectProtocol {
  func btnTapped()
}

class BaseNavController: UIViewController {
  
  weak var delegate: NavBtnProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setup() {
    let leftItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(BaseNavController.buttonAction))
    self.navigationItem.leftBarButtonItem = leftItem
  }
  
  func buttonAction() {
    delegate.btnTapped()
  }

}
