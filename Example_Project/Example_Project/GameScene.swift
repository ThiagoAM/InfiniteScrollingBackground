//
//  GameScene.swift
//  Example_Project
//  Created by Thiago Martins on 27/04/2018.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Declaring the InfiniteScrollingBackground Instance:
    var scroller : InfiniteScrollingBackground?
    
    override func didMove(to view: SKView) {
        
        // Getting the images:
        let images = [UIImage(named: "bgImage1")!, UIImage(named: "bgImage2")!]
        
        // Initializing InfiniteScrollingBackground's Instance:
        scroller = InfiniteScrollingBackground(images: images, scene: self, scrollDirection: .bottom, speed: 3)
        
        // Using it:
        scroller?.scroll()
        
        // (Optional) Changing the instance's zPosition:
        scroller?.zPosition = 1
        
    }
    
}