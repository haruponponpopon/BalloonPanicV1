//
//  ViewController.swift
//  BalloonPanicV1
//
//  Created by 小林　遥香 on 2021/05/10.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var highScoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // ハイスコアの読み込み
        let ud = UserDefaults.standard
        let highScore = ud.integer(forKey: "HiScore") // 存在しない場合は0
        highScoreLabel.text = "\(highScore)"
    }
    
    @IBAction func backToTitle(sender: UIStoryboardSegue){
        
    }


}
