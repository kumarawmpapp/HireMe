//
//  SignupViewController.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 11/4/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

class SignupViewController: BaseViewController {
    override func styleViewController() {
        self.view.backgroundColor = ApplicationColor.HEX_EAEAEA
    }
    
    @IBAction func btnNextClicked(_ sender: BaseButton){
        
    }
    
    func showMapView() {
        if let window = appDelegate.window {
            window.rootViewController = ApplicationSession.sharedInstance.viewControllerFactory.menuContainerViewController()
            window.makeKeyAndVisible()
        }
    }
}

class SignupPhoneViewController: SignupViewController {
    @IBOutlet weak var numberInput: PhoneNumberView!
    
    override func localizeViewController() {
        
    }
    
    override func styleViewController() {
        super.styleViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        numberInput.txtMobileNumber.becomeFirstResponder()
    }
    
    @IBAction override func btnNextClicked(_ sender: BaseButton){
        ApplicationSession.sharedInstance.signupDetails.user.phoneNumber = numberInput.txtMobileNumber.text
        
        let optionMenu = UIAlertController(title: nil, message: "Mobile", preferredStyle: .actionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Exist", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if let signupNavigation = self.navigationController {
                let signupname = ApplicationSession.sharedInstance.viewControllerFactory.loginPasswordViewController()
                signupNavigation.pushViewController(signupname, animated: true)
            }
        })
        let saveAction = UIAlertAction(title: "Not Exist", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if let signupNavigation = self.navigationController {
                let signupname = ApplicationSession.sharedInstance.viewControllerFactory.otpViewController()
                signupNavigation.pushViewController(signupname, animated: true)
            }
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            optionMenu.dismiss(animated: true, completion: nil)
        })
        
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    
    }
}

class SignupNameEmailViewController: SignupViewController {
    @IBOutlet weak var firstnameInput: SignupInputView!
    @IBOutlet weak var lastnameInput: SignupInputView!
    @IBOutlet weak var emailInput: SignupInputView!
    
    override func initViewController() {
        
    }
    
    override func localizeViewController() {
        firstnameInput.textField.placeholder = "First Name"
        lastnameInput.textField.placeholder = "Last Name"
        emailInput.textField.placeholder = "Email"
    }
    
    override func styleViewController() {
        super.styleViewController()
        emailInput.textField.keyboardType = .emailAddress
        
        
    }
    
    @IBAction override func btnNextClicked(_ sender: BaseButton){
        ApplicationSession.sharedInstance.signupDetails.user.firstName = firstnameInput.textField.text
        ApplicationSession.sharedInstance.signupDetails.user.secondName = lastnameInput.textField.text
        ApplicationSession.sharedInstance.signupDetails.user.emailAddress = emailInput.textField.text
        
        if let signupNavigation = self.navigationController {
            let signuppass = ApplicationSession.sharedInstance.viewControllerFactory.signupPasswordViewController()
            signupNavigation.pushViewController(signuppass, animated: true)
        }
    }
}

class SignupPasswordViewController: SignupViewController {
    @IBOutlet weak var passwordInput: SignupInputView!
    @IBOutlet weak var verifyPasswordInput: SignupInputView!
    
    override func styleViewController() {
        super.styleViewController()
    }
    
    override func localizeViewController() {
        passwordInput.textField.placeholder = "Password"
        verifyPasswordInput.textField.placeholder = "Verify password"
    }
    
    @IBAction func btnTermsClicked(_ sender: BaseButton){
        
    }
    
    @IBAction override func btnNextClicked(_ sender: BaseButton){
        ApplicationSession.sharedInstance.signupDetails.password = passwordInput.textField.text
        
        ServiceManager.sharedInstance.webServiceManager.requestHandler.createCustomer(userDetails: ApplicationSession.sharedInstance.signupDetails)
        
        showMapView()
    }
}

class LoginPasswordViewController: SignupViewController {
    @IBOutlet weak var passwordInput: SignupInputView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func localizeViewController() {
        passwordInput.textField.placeholder = "Password"
    }
    
    @IBAction func btnLoginClicked(_ sender: BaseButton){
        if true { // login success
            showMapView()
        } else { // login failed
            
        }
    }
    
    @IBAction func btnForgotPWDClicked(_ sender: BaseButton){
        
    }
}

class OTPViewController: SignupViewController {
    @IBOutlet weak var lblName: BaseLabel!
    @IBOutlet weak var lblWelcome: BaseLabel!
    @IBOutlet weak var lblCaution: BaseLabel!
    @IBOutlet weak var lblMobileNumber: BaseLabel!
    
    @IBOutlet weak var digit1: OTPDigitView!
    @IBOutlet weak var digit2: OTPDigitView!
    @IBOutlet weak var digit3: OTPDigitView!
    @IBOutlet weak var digit4: OTPDigitView!
    
    @IBOutlet weak var btnResend: BaseButton!
    @IBOutlet weak var btnNext: BaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func styleViewController() {
        super.styleViewController()
        
        lblName.font = ApplicationFonts.generalFont(withName: ApplicationFonts.Montserrat.Bold, size: 20.0)
        lblWelcome.font = ApplicationFonts.generalFont(withName: ApplicationFonts.Montserrat.Medium, size: 15.0)
        lblCaution.font = ApplicationFonts.generalFont(withName: ApplicationFonts.Montserrat.Regular, size: 13.0)
        lblMobileNumber.font = ApplicationFonts.generalFont(withName: ApplicationFonts.Montserrat.Medium, size: 13.0)
        
        btnResend.setTitleColor(ApplicationColor.HEX_525252, for: .normal) 
        btnNext.backgroundColor = ApplicationColor.HEX_525252
    }
    
    @IBAction func btnResendClicked(_ sender: BaseButton){
        
    }
    
    @IBAction override func btnNextClicked(_ sender: BaseButton){
        if let signupNavigation = self.navigationController {
            let signuppass = ApplicationSession.sharedInstance.viewControllerFactory.signupNameEmailViewController()
            signupNavigation.pushViewController(signuppass, animated: true)
        }
    }
    
}
