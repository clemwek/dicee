//
//  CGameViewController.swift
//  dicee
//
//  Created by Clement Wekesa on 20/05/2018.
//  Copyright © 2018 Clement Wekesa. All rights reserved.
//

import UIKit

class CGameViewController: UIViewController {
    
    private var opponent: Bool = false

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController {
            vc.opponent = opponent
        }
    }

    @IBAction func startGame(_ sender: UIButton) {
        if sender.tag == 2 {
            opponent = false
        } else {
            opponent = true
        }
        
        self.performSegue(withIdentifier: "startGameSegue", sender: nil)
    }
    
}
