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
            
            self.fetchedNameLabel.text = "\(fullName)"
            self.fetchedEmailLabel.text = "\(email)"
            
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
    let fullNameLabel: UILabel = {
       
        let label = UILabel()
        label.text = "FULL NAME"
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    let fetchedNameLabel: UILabel = {
        
        let label = UILabel()
        label.text = " "
        label.font = UIFont(name: "Avenir-Medium", size: 22)
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.layer.cornerRadius = 6
        
        label.layer.shadowRadius = 10
        label.layer.shadowColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        label.layer.shadowOpacity = 0.25
        label.layer.shadowOffset = CGSize(width: 0.5, height: 3)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    let emailLabel: UILabel = {
        
        let label = UILabel()
        label.text = "EMAIL"
        label.font = UIFont(name: "Avenir-Heavy", size: 15)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    let fetchedEmailLabel: UILabel = {
        
        let label = UILabel()
        label.text = " "
        label.font = UIFont(name: "Avenir-Medium", size: 22)
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.layer.cornerRadius = 6
        
        label.layer.shadowRadius = 10
        label.layer.shadowColor = UIColor.rgb(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        label.layer.shadowOpacity = 0.25
        label.layer.shadowOffset = CGSize(width: 0.5, height: 3)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setupViews() {
        
        view.backgroundColor = UIColor.rgb(red: 249, green: 250, blue: 251)
        
        view.addSubview(signInButton)
        signInButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64).isActive = true
        
        view.addSubview(fullNameLabel)
        fullNameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        fullNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        
        view.addSubview(fetchedNameLabel)
        fetchedNameLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 4).isActive = true
        fetchedNameLabel.leftAnchor.constraint(equalTo: fullNameLabel.leftAnchor).isActive = true
        fetchedNameLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        fetchedNameLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(emailLabel)
        emailLabel.topAnchor.constraint(equalTo: fetchedNameLabel.bottomAnchor, constant: 32).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: fullNameLabel.leftAnchor).isActive = true
        
        view.addSubview(fetchedEmailLabel)
        fetchedEmailLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4).isActive = true
        fetchedEmailLabel.leftAnchor.constraint(equalTo: emailLabel.leftAnchor).isActive = true
        fetchedEmailLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        fetchedEmailLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
}

extension UIColor {
    class func rgb(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
    }
    
    class func rgb(red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
    }
}
