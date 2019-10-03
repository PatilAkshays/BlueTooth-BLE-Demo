//
//  TireParameterControl.swift
//  TREEL
//
//  Created by Treel Mobility  on 24/04/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit

class TireParameterControl: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var psiLbl: UILabel!
    
    var positonString : String?
    //    var tireConfig : TireConfigDetails?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    func loadView() {
        Bundle.main.loadNibNamed("TireParameterControl", owner: self, options: nil)
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.backgroundColor = .clear
    }
    
    
    
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */


}
