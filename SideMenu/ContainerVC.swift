//
//  ContainerVC.swift
//  SideMenu
//
//  Created by Sujan Vaidya on 4/11/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

enum SlideOutState {
  case Collapsed
  case Expanded
}

class ContainerVC: UIViewController {

  let centerPanelExpandedOffset: CGFloat = 100
  
  var currentState: SlideOutState = .Collapsed {
    didSet {
      let shouldShowShadow = currentState != .Collapsed
      showShadowForCenterViewController(shouldShowShadow: shouldShowShadow)
    }
  }
  
  var mainNavController: UINavigationController!
  var leftViewController: SideVC?
  var defaultVC: CenterVC!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    mainNavController = UIStoryboard.mainNavController()
    view.addSubview(mainNavController.view)
    self.addChildViewController(mainNavController)
    mainNavController.didMove(toParentViewController: self)
    
    defaultVC = mainNavController.topViewController as! CenterVC
    defaultVC.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func btnTapped(_ sender: UIButton) {
    toggleLeftPanel()
  }
  
  func toggleLeftPanel() {
    let notAlreadyExpanded = (currentState != .Expanded)
    
    if notAlreadyExpanded {
      addLeftPanelViewController()
    }
    animateLeftPanel(shouldExpand: notAlreadyExpanded)
  }
  
  private func addLeftPanelViewController() {
    if (leftViewController == nil) {
      leftViewController = UIStoryboard.leftViewController()
      addChildSidePanelController(sidePanelController: leftViewController!)
    }
  }
  
  private func addChildSidePanelController(sidePanelController: SideVC) {
    sidePanelController.delegate = self
    
    view.insertSubview(sidePanelController.view, at: 0)
    
    addChildViewController(sidePanelController)
    sidePanelController.didMove(toParentViewController: self)
  }
  
  private func animateLeftPanel(shouldExpand: Bool) {
    if (shouldExpand) {
      currentState = .Expanded
      
      animateCenterPanelXPosition(targetPosition: self.mainNavController.view.frame.width - centerPanelExpandedOffset)
    } else {
      animateCenterPanelXPosition(targetPosition: 0) { finished in
        self.currentState = .Collapsed
        
        self.leftViewController!.view.removeFromSuperview()
        self.leftViewController = nil;
      }
    }
  }
  
  private func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
    UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseIn], animations: {
      self.mainNavController.view.frame.origin.x = targetPosition
    }, completion: completion)
  }

  
  private func showShadowForCenterViewController(shouldShowShadow: Bool) {
    if (shouldShowShadow) {
      mainNavController.view.layer.shadowOpacity = 0.8
      mainNavController.view.layer.shouldRasterize = true
      mainNavController.view.layer.rasterizationScale = 1
    } else {
      mainNavController.view.layer.shadowOpacity = 0.0
      mainNavController.view.layer.shouldRasterize = false
    }
  }
  
  func collapseSidePanels() {
    switch (currentState) {
    case .Expanded:
      toggleLeftPanel()
    default:
      break
    }
  }

}

extension ContainerVC: NavBtnProtocol {
  
  func btnTapped() {
    toggleLeftPanel()
  }

}

extension ContainerVC: SideVCDelegate {
  
  func showVC(mainNavigationController: UINavigationController) {
    for childVC in self.childViewControllers {
      childVC.removeFromParentViewController()
    }
    for childView in self.view.subviews {
      childView.removeFromSuperview()
    }
    
    mainNavController = mainNavigationController
    mainNavController.view.frame.origin.x = self.mainNavController.view.frame.width - centerPanelExpandedOffset
    view.addSubview(mainNavController.view)
    self.addChildViewController(mainNavController)
    mainNavController.didMove(toParentViewController: self)
    let topVC = mainNavigationController.topViewController as! BaseNavController
    topVC.delegate = self
    collapseSidePanels()
  }
  
}

