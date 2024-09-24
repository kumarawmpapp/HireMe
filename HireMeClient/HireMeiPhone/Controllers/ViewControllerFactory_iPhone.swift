//
//  ViewControllerFactory_iPhone.swift
//  HireMeiPhone
//
//  Created by Sanjeewa Bamunusinghe on 10/8/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

class ViewControllerFactory_iPhone: ViewControllerFactory {
    override init() {
        super.init()
        self.storyboard = UIStoryboard(name: "iPhone", bundle: Bundle.main)
    }
    
    override func menuContainerViewController() -> MenuContainerViewController {
        return self.storyboard.instantiateViewController(withIdentifier: "MenuContainerViewController") as! MenuContainerViewController
    }
    
    override func loginViewController() -> LoginViewController {
        return self.storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    }
    
    override func loginPasswordViewController() -> LoginPasswordViewController {
        return self.storyboard.instantiateViewController(withIdentifier: LoginPasswordViewController.storyboardIdentifier) as! LoginPasswordViewController
    }
    
    override func otpViewController() -> OTPViewController {
        return self.storyboard.instantiateViewController(withIdentifier: OTPViewController.storyboardIdentifier) as! OTPViewController
    }
    
    override func signupNameEmailViewController() -> SignupNameEmailViewController {
        return self.storyboard.instantiateViewController(withIdentifier: SignupNameEmailViewController.storyboardIdentifier) as! SignupNameEmailViewController
    }
    
    override func signupPhoneViewController() -> SignupPhoneViewController {
        return self.storyboard.instantiateViewController(withIdentifier: SignupPhoneViewController.storyboardIdentifier) as! SignupPhoneViewController
    }
    
    override func signupPasswordViewController() -> SignupPasswordViewController {
        return self.storyboard.instantiateViewController(withIdentifier: SignupPasswordViewController.storyboardIdentifier) as! SignupPasswordViewController
    }
    
    override func locationViewController() -> SetLocationViewController {
        return self.storyboard.instantiateViewController(withIdentifier: SetLocationViewController.storyboardIdentifier) as! SetLocationViewController
    }
    
    override func bookingConfirmViewController() -> BookingConfirmViewController {
        return self.storyboard.instantiateViewController(withIdentifier: BookingConfirmViewController.storyboardIdentifier) as! BookingConfirmViewController
    }
}

