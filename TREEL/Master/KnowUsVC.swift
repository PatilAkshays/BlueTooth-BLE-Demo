//
//  KnowUsVC.swift
//  TREEL
//
//  Created by Treel Mobility  on 23/04/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
class KnowUsVC: BaseViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        
        let url = NSURL (string: "https://treel.in/enterprise/");
        let request = NSURLRequest(url: url! as URL);
        webView.loadRequest(request as URLRequest);
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func pressKnowProductBtnAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let masterViewController = storyBoard.instantiateViewController(withIdentifier:"KnowProductVC") as! KnowProductVC
        self.navigationController?.pushViewController(masterViewController, animated: true)
    }
    @IBAction func pressDemoBtnAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let masterViewController = storyBoard.instantiateViewController(withIdentifier:"MasterViewController") as! MasterViewController
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
