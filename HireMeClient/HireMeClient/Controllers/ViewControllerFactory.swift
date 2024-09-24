//
//  ViewControllerFactory.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 10/8/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

class ViewControllerFactory {
    var storyboard: UIStoryboard!
    
    func loginViewController() -> LoginViewController {
        return LoginViewController()
    }
    
    func loginPasswordViewController() -> LoginPasswordViewController {
        return LoginPasswordViewController()
    }
    
    func otpViewController() -> OTPViewController {
        return OTPViewController()
    }
    
    func menuContainerViewController() -> MenuContainerViewController {
        return MenuContainerViewController()
    }
    
    func signupNameEmailViewController() -> SignupNameEmailViewController {
        return SignupNameEmailViewController()
    }
    
    func signupPhoneViewController() -> SignupPhoneViewController {
        return SignupPhoneViewController()
    }
    
    func signupPasswordViewController() -> SignupPasswordViewController {
        return SignupPasswordViewController()
    }
    
    func locationViewController() -> SetLocationViewController {
        return SetLocationViewController()
    }
    
    func bookingConfirmViewController() -> BookingConfirmViewController {
        return BookingConfirmViewController()
    }
}
