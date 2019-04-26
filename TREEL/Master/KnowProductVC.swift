//
//  KnowProductVC.swift
//  TREEL
//
//  Created by Treel Mobility  on 23/04/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
@available(iOS 11.0, *)
class KnowProductVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func pressKnowUsBtnAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let masterViewController = storyBoard.instantiateViewController(withIdentifier:"KnowUsVC") as! KnowUsVC
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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row)", for: indexPath) 
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
