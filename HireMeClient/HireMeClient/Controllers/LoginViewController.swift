//
//  LoginViewController.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/3/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit
import Utility

class LoginViewController: BaseViewController {
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var phoneNumberView: PhoneNumberView!
    @IBOutlet weak var btnSupport: BaseButton!
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var lblRide: BaseLabel!
    @IBOutlet weak var btnCreateAccount: BaseButton!
    @IBOutlet weak var viewCreateAct: UIView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberView.txtMobileNumber.isUserInteractionEnabled = false
    }
    
    override func styleViewController() {
        lblRide.font = UIFont(name: ApplicationFonts.Montserrat.Medium, size: 18.0)
        
        btnCreateAccount.titleLabel?.font = UIFont(name: ApplicationFonts.Montserrat.Bold, size: 12.0)
        
        let bottomTextFont =  UIFont(name: ApplicationFonts.Montserrat.Bold, size: 10.0)
        
        btnSupport.titleLabel?.font = bottomTextFont
        lblVersion.font = bottomTextFont
    }

    override func localizeViewController() {
        
    }
    
    @IBAction func createActClicked(_ sender: UIButton) {
        ApplicationSession.sharedInstance.signupDetails = SignupDetails()
        
        if let loginNavigation = self.navigationController {
            let signup = ApplicationSession.sharedInstance.viewControllerFactory.signupPhoneViewController()
            loginNavigation.pushViewController(signup, animated: true)
        }
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        ApplicationSession.sharedInstance.signupDetails = SignupDetails()
        
        if let loginNavigation = self.navigationController {
            let signup = ApplicationSession.sharedInstance.viewControllerFactory.signupPhoneViewController()
            loginNavigation.pushViewController(signup, animated: false)
            
        }
    }
    
    
}


