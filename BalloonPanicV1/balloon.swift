//
//  balloon.swift
//  BalloonPanicV1
//
//  Created by 小林　遥香 on 2021/05/10.
//

import UIKit

enum BalloonType {
    case red
    case orange
    case yellow
    case green
    case blue
}

class Balloon: UIImageView {

    var bottom: CGFloat = 0 // 表示位置の下限のy座標
    var top: CGFloat = 0 // 表示位置の上限のy座標

    var balloonType:BalloonType!

    var hSpeed: CGFloat = 0 // 水平方向の速度
    var vSpeed: CGFloat = 0 // 垂直方向の速度
    
    var bpoint = 0 //風船のポイント
    
    override func didMoveToSuperview() {
        
        let imageNames = ["redBalloon.png", "orangeBalloon.png", "yellowBalloon.png", "greenBalloon.png", "blueBalloon.png"]
        let rand = Int(arc4random_uniform(10))
        
        
        switch rand {
        case 0:
            balloonType = .red
            hSpeed = 5.0
            vSpeed = 5.0
            bpoint = 5
        case 1:
            balloonType = .orange
            hSpeed = 4.0
            vSpeed = 4.0
            bpoint = 4
        case 2...3:
            balloonType = .yellow
            hSpeed = 3.0
            vSpeed = 3.0
            bpoint = 3
        case 4...6:
            balloonType = .green
            hSpeed = 2.0
            vSpeed = 2.0
            bpoint = 2
        case 7...9:
            balloonType = .blue
            hSpeed = 1.0
            vSpeed = 1.0
            bpoint = 1
        default:
            break
        }
        self.image = UIImage(named: imageNames[5-bpoint])
        
        if arc4random_uniform(2) == 0 {
            vSpeed *= -1
        }
    }
    
    func move(){
        self.center = CGPoint(x: self.center.x - hSpeed, y: self.center.y + vSpeed)
        if self.center.y > bottom {
            vSpeed = -abs(vSpeed)
        }else if self.center.y < top {
            vSpeed = abs(vSpeed)
        }
    }

}


