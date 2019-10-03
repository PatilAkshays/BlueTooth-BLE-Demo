//
//  MasterViewController.swift
//  TREEL
//
//  Created by Treel Mobility  on 22/04/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class MasterViewController: BaseViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var pageVController = UIPageViewController()
    var pageIndex: Int = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // - Setup page control
//        pageController.numberOfPages = 2;
//        pageIndex = 0
//        pageController.currentPage = 0;
        
        
        // Create page view controller
        self.pageVController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController

        self.addDemoView()
       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Load Initial Trip View On ContainerView
        BLEManager.sharedManager.findBLE(true)

    }
    func addDemoView() -> Void
    {
        let pageContaintVC : DemoViewController = self.getViewControllerAtIndex1(index: 0)
        let viewControllers = [pageContaintVC]
        self.pageVController.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: false) { _ in }
        // Change the size of page view controller
        self.pageVController.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        addChild(self.pageVController)
        view.addSubview(self.pageVController.view)
        self.view.addSubview(stackView)
        self.view.addSubview(homeBtn)
        self.view.addSubview(segmentControl)
    }
    func removeView() -> Void
    {
       
       self.pageVController.view.removeFromSuperview()
       
    }
    
    func addVehicleView() -> Void
    {
        let pageContaintVC : TwentyTiresVehicleVC = self.getViewControllerAtIndex(index: 0)
        let viewControllers = [pageContaintVC]
        self.pageVController.setViewControllers(viewControllers as? [UIViewController], direction: .forward, animated: false) { _ in }
        // Change the size of page view controller
        self.pageVController.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        addChild(self.pageVController)
        view.addSubview(self.pageVController.view)
        self.view.addSubview(stackView)
        self.view.addSubview(homeBtn)
        self.view.addSubview(segmentControl)
    }
    
    
    // MARK:- Other Methods
    func getViewControllerAtIndex(index: NSInteger) -> TwentyTiresVehicleVC
    {
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "TwentyTiresVehicleVC") as! TwentyTiresVehicleVC
        
        pageIndex = index
        
        return pageContentViewController
    }
    
    
    // MARK:- Other Methods
    func getViewControllerAtIndex1(index: NSInteger) -> DemoViewController
    {
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "DemoViewController") as! DemoViewController
        
        pageIndex = index
        
        return pageContentViewController
    }
    
    
    @IBAction func pressSegmentControlAction(_ sender: Any) {
        let segmentContrl = sender as! UISegmentedControl
        if segmentContrl.selectedSegmentIndex == 0{
            removeView()
            self.addDemoView()
        }else{
            removeView()
            self.addVehicleView()

        }
    }
    
    private lazy var vehicleViewController: VehicleVC = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "VehicleVC") as! VehicleVC
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var demoViewController: DemoViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "DemoViewController") as! DemoViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
        
//        currentViewController = viewController
        
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
//    func addDemoView() {
//        remove(asChildViewController: vehicleViewController)
//        add(asChildViewController: demoViewController)
//    }
//    func addVehicleView() {
//        remove(asChildViewController: demoViewController)
//        add(asChildViewController: vehicleViewController)
//    }
    
  
    @IBAction func pressKnowProductBtnAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let masterViewController = storyBoard.instantiateViewController(withIdentifier:"KnowProductVC") as! KnowProductVC
        self.navigationController?.pushViewController(masterViewController, animated: true)
    }
    @IBAction func pressKnowUsBtnAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let masterViewController = storyBoard.instantiateViewController(withIdentifier:"KnowUsVC") as! KnowUsVC
        self.navigationController?.pushViewController(masterViewController, animated: true)
        
    }
    @IBAction func pressHomeBtnAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
