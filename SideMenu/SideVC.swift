//
//  SideVC.swift
//  SideMenu
//
//  Created by Sujan Vaidya on 4/11/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

protocol SideVCDelegate: NSObjectProtocol {
  func showVC(mainNavigationController: UINavigationController)
}

class SideVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  weak var delegate: SideVCDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableFooterView = UIView(frame: CGRect.zero)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

extension SideVC: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return MenuItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell") as? MenuCell else {return UITableViewCell() }
    cell.label.text = MenuItems(rawValue: indexPath.row)?.menuTitle
    return cell
  }
}

extension SideVC: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let mainNavController = MenuItems(rawValue: indexPath.row)?.getVC() else { return }
    delegate?.showVC(mainNavigationController: mainNavController)
      
  }
    
}

