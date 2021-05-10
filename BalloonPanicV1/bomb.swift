//
//  bomb.swift
//  BalloonPanicV1
//
//  Created by 小林　遥香 on 2021/05/10.
//

import UIKit


class Bomb: UIImageView {

    var bottom: CGFloat = 0 // 表示位置の下限のy座標
    var top: CGFloat = 0 // 表示位置の上限のy座標


    var hSpeed: CGFloat = 0 // 水平方向の速度
    var vSpeed: CGFloat = 0 // 垂直方向の速度
    
    override func didMoveToSuperview() {
        
        let imageNames = "bomb.png"
        self.image = UIImage(named: imageNames)
        hSpeed = 2.0
        vSpeed = 2.0
        
        
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


