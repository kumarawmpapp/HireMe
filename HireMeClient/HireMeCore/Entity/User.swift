//
//  User.swift
//  HireMeCore
//
//  Created by Sanjeewa Bamunusinghe on 10/8/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import Foundation

class User {
    var firstName: String!
    var secondName: String!
    var phoneNumber: String!
    var emailAddress: String!
}

class Profile: NSObject, NSCoding {
    var user: User
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("profile")
    
    struct PropertyKey {
        static let user = "user"
    }
    
    init(withUser user:User) {
        self.user = user
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(user, forKey: PropertyKey.user)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let user = aDecoder.decodeObject(forKey: PropertyKey.user) as? User else {
            return nil
        }
        
        self.init(withUser: user)
    }
}
