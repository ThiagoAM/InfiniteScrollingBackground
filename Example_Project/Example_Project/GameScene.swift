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
        
        // Get your images here:
        let images = [
            UIImage(named: "myBgImage1")!,
            UIImage(named: "myBgImage2")!,
        ]
        
        // Initializing InfiniteScrollingBackground's instance:
        scroller = InfiniteScrollingBackground(images: images,
                                               scene: self,
                                               scrollDirection: .bottom,
                                               transitionSpeed: 3) // from 0 to 100
        
        // Activating it:
        scroller?.scroll()
        
        // (Optional) Changing the instance's zPosition:
        scroller?.zPosition = 1
    }
    
}
