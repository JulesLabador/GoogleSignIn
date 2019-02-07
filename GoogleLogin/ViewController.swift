//
//  ViewController.swift
//  GoogleLogin
//
//  Created by Jules Labador on 2/6/19.
//  Copyright © 2019 Jules Labador. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        setupViews()
        
        signInButton.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error { print("\(error.localizedDescription)") }
        else {
            
            let userId = user.userID ?? ""
            let idToken = user.authentication.idToken ?? ""
            let fullName = user.profile.name ?? ""
            let givenName = user.profile.givenName ?? ""
            let familyName = user.profile.familyName ?? ""
            let email = user.profile.email ?? ""
            
            self.nameLabel.text = "FULL NAME: \(fullName)"
            self.emailLabel.text = "EMAIL: \(email)"
            
            print(userId)
            print(idToken)
            print(fullName)
            print(givenName)
            print(familyName)
            print(email)
            
        }
    }
    
    @objc func didTapSignOut() {
        GIDSignIn.sharedInstance()?.signOut()
    }
    let signInButton: GIDSignInButton = {
       
        let button = GIDSignInButton()
        button.colorScheme = .light
        button.style = .wide
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    let nameLabel: UILabel = {
       
        let label = UILabel()
        label.text = "FULL NAME"
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    let emailLabel: UILabel = {
        
        let label = UILabel()
        label.text = "EMAIL"
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    func setupViews() {
        
        view.backgroundColor = UIColor.rgb(red: 249, green: 250, blue: 251)
        
        view.addSubview(signInButton)
        signInButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        
        view.addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        
        view.addSubview(emailLabel)
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
    }
    
}

extension UIColor {
    class func rgb(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
    }
}
