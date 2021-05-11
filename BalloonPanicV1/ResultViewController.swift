//
//  ResultViewController.swift
//  BalloonPanicV1
//
//  Created by 小林　遥香 on 2021/05/10.
//

import UIKit


class ResultViewController: UIViewController {
    
    var result = 0
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet weak var gameoverLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = "\(result)"
        
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
