//
//  SplashScreenController.swift
//  SportinG
//
//  Created by Rawan Elsayed on 20/05/2024.
//

import UIKit

class SplashScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Wait 2 seconds and go to splash screen
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
            self.performSegue(withIdentifier: "OpenSplash", sender: nil)
        }
    }

}
