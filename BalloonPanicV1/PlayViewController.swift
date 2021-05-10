//
//  PlayViewController.swift
//  BalloonPanicV1
//
//  Created by 小林　遥香 on 2021/05/10.
//

import UIKit

class PlayViewController: UIViewController {
    
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    var frameTimer: Timer!
    
    var score = 0
    //var scoreCount = 0
    //let scoreInterval = 60
    
    var bombCount = 0
    var bombInterval = 240
    var bombArray = [Bomb]()
    
    var balloonCount = 0
    var balloonInterval = 60
    var balloonArray = [Balloon]()
    
    @IBOutlet var bird: Bird!
    @IBOutlet var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        screenWidth = self.view.frame.size.width
        screenHeight = self.view.frame.size.height
        
        bird.bottom = self.view.frame.size.height - 50
        bird.top = 50
        
        frameTimer = Timer.scheduledTimer(withTimeInterval: 1.0/60, repeats: true, block: { (timer) in
            self.frameAction()
        })
        bird.animationImages = [UIImage(named: "bird.png")!, UIImage(named: "bird.png")!]
        bird.animationDuration = 0.5
        bird.startAnimating()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bird.jump()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? ResultViewController {
            //resultVC.result = scoreCount
            resultVC.result = score
        }
    }
    
    
    func frameAction(){
        
        bird.move()
        
        for i in (0..<bombArray.count).reversed() { // reversed()で逆ループ
            
            let bomb = bombArray[i]
            bomb.move()
            
            // 衝突判定
            if abs(bird.center.x - bomb.center.x) < 50 && abs(bird.center.y - bomb.center.y) < 50 { // 絶対値で判定
                finishGame()
                return
            }
            
            // 画面外の敵は除去
            if bomb.center.x < -bomb.frame.size.width/2 {
                bombArray.remove(at: i)
                bomb.removeFromSuperview()
            }
        }
        
        // 敵の発生
        if bombCount >= bombInterval {
            let size: CGFloat = 60
            let bomb = Bomb()
            bomb.frame = CGRect(x: 0, y: 0, width: size, height: size)
            let randY = arc4random_uniform(500)
            bomb.center = CGPoint(x: screenWidth + size/2, y: CGFloat(randY))
            bomb.bottom = self.view.frame.size.height - 40
            bomb.top = 40
            self.view.addSubview(bomb)
            bombArray.append(bomb)
            bombCount = 0
            
            // 敵の出現間隔を短くする
            bombInterval = Int(Double(bombInterval) * 0.98)
            if bombInterval < 20 {
                bombInterval = 20
            }
        }else{
            bombCount += 1
        }
        
        
        //風船の移動
        for i in (0..<balloonArray.count).reversed() { // reversed()で逆ループ
            
            let balloon = balloonArray[i]
            balloon.move()
            
            
            // 衝突判定
            if abs(bird.center.x - balloon.center.x) < 30 && abs(bird.center.y - balloon.center.y) < 30 { // 絶対値で判定
                score += 1
                scoreLabel.text = "\(score)"
                balloonArray.remove(at: i)
                balloon.removeFromSuperview()
            }
            
            
            // 画面外の敵は除去
            if balloon.center.x < -balloon.frame.size.width/2 {
                balloonArray.remove(at: i)
                balloon.removeFromSuperview()
            }
        }
        
        // 風船の発生
        if balloonCount >= balloonInterval {
            let size: CGFloat = 60
            let balloon = Balloon()
            balloon.frame = CGRect(x: 0, y: 0, width: size, height: size)
            let randY = arc4random_uniform(500)
            balloon.center = CGPoint(x: screenWidth + size/2, y: CGFloat(randY))
            balloon.bottom = self.view.frame.size.height - 40
            balloon.top = 40
            self.view.addSubview(balloon)
            balloonArray.append(balloon)
            balloonCount = 0
            
        }else{
            balloonCount += 1
        }
        
        // スコア
//        if scoreCount >= scoreInterval {
//            score += 1
//            scoreLabel.text = "\(score)"
//            scoreCount = 0
//        }else{
//            scoreCount += 1
//        }
    }
    
    func finishGame(){
        frameTimer.invalidate()
        bird.stopAnimating()
        
        // ハイスコアの保存
        let ud = UserDefaults.standard
        let highScore = ud.integer(forKey: "HiScore") // 存在しない場合は0
        if score > highScore {
            ud.set(score, forKey: "HiScore")
        }
        ud.synchronize()
        
        
        let image = UIImage(named: "birdDead.png")
        bird.image = image
        UIView.animate(withDuration: 0.3, animations: {
            self.bird.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }){(_) in self.performSegue(withIdentifier: "FinishGame", sender: nil)}
        
        
        //        UIView.animate(withDuration: 0.7, animations: {
        //            self.bird.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        //        }) { (_) in
        //            UIView.animate(withDuration: 0.7, animations: {
        //                self.bird.transform = CGAffineTransform.identity
        //            }) { (_) in
        //                self.dismiss(animated: true, completion: nil)
        //            }
        //        }
        //performSegue(withIdentifier: "FinishGame", sender: nil)

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
