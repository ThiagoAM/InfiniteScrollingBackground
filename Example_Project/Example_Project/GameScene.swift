//
//  GameScene.swift
//  Example_Project
//  Created by Thiago Martins on 27/04/2018.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Declaring the InfiniteScrollingBackground instance:
    var scroller : InfiniteScrollingBackground?
    
    override func didMove(to view: SKView) {
        
        // Getting the images:
        let images = [
            UIImage(named: "cloud1")!,
            UIImage(named: "cloud2")!,
            
        ]
        
        // Initializing InfiniteScrollingBackground's instance:
        scroller = InfiniteScrollingBackground(images: images,
                                               scene: self,
                                               scrollDirection: .right,
                                               transitionSpeed: 5)
        
        // Activating it:
        scroller?.scroll()
        
        // (Optional) Changing the instance's zPosition:
        scroller?.zPosition = 1
    }
    
}
