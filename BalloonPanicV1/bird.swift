//
//  bird.swift
//  BalloonPanicV1
//
//  Created by 小林　遥香 on 2021/05/10.
//

import UIKit

class Bird: UIImageView {
    
    var bottom: CGFloat = 0 // 表示位置の下限のy座標
    var top: CGFloat = 0 // 表示位置の上限のy座標
    
    var vSpeed: CGFloat = 0 // 垂直方向の速度

    func move(){
        vSpeed += 0.3
        self.center = CGPoint(x: self.center.x, y: self.center.y + vSpeed)
        
        if self.center.y > bottom {
            vSpeed = -10
        }else if self.center.y < top {
            self.center = CGPoint(x: self.center.x, y: top)
            vSpeed = 0
        }
    }
    
    func jump(){
        vSpeed = -10
    }
}

