//
//  Infinite Scrolling Background.swift
//  Star One
//
//  Created by Thiago Martins on 27/03/2018.
//  Copyright © 2018 Thiago Martins. All rights reserved.
//

import SpriteKit

class InfiniteScrollingBackground {
    
    // MARK: Enumerations
    enum ScrollDirection {
        case top
        case bottom
        case left
        case right
    }
    
    // MARK: Public Properties
    public var zPosition : CGFloat {
        get {
            return getZPosition()
        }
        set {
            setZPosition(newValue)
        }
    }
    
    public var alpha : CGFloat {
        get {
            return getAlpha()
        }
        set {
            setAlpha(newValue)
        }
    }
    
    // MARK: Private Properties
    private let sprites : [SKSpriteNode]
    private weak var scene : SKScene?
    
    // MARK: Public Properties
    public let speed : TimeInterval
    public let scrollDirection : ScrollDirection
    
    // MARK: Initialization
    
    /**
     Creates an Infinite Scrolling Background for a SKScene.
     - images: use at least 1 image
     - scene: your SKScene instance
     - scrollDirection: use .top, .bottom, .left or .right
     - speed: the lower, the faster. Needs to be bigger than 0
    **/
    init?(images : [UIImage], scene : SKScene, scrollDirection : ScrollDirection, speed : TimeInterval) {
        // handling invalid initializations:
        if images.count < 1 {
            print("InfiniteScrollingBackground Initialization Error - You must provide at least 1 image!")
            return nil
        }
        if speed <= 0 {
            print("InfiniteScrollingBackground Initialization Error - The speed must be bigger than zero!")
            return nil
        }
        // setup attributes:
        let spriteSize = InfiniteScrollingBackground.calculateSpriteSize(scrollDirection, images[0].size, scene)
        self.sprites = InfiniteScrollingBackground.makeSpriteNodes(images, spriteSize)
        self.scene = scene
        self.scrollDirection = scrollDirection
        self.speed = speed
    }
    
    // MARK: Public Methods
    
    /**
     Scrolls the background images indefinitely.
    */
    public func scroll() {
        switch scrollDirection {
        case .bottom:
            scrollDown()
        case .top:
            scrollUp()
        case .right:
            scrollToTheRight()
        case .left:
            scrollToTheLeft()
        }
    }
    
    // MARK: Private Methods
    private func scrollToTheRight() {
        let numberOfSprites = sprites.count
        let transitionDuration = self.speed
        for index in 0...numberOfSprites - 1 {
            sprites[index].position = CGPoint(x: sprites[index].size.width/2 - (CGFloat(index) * sprites[index].size.width), y: UIScreen.main.bounds.height/2)
            let initialMovementAction = SKAction.moveTo(x: 1.5 * sprites[index].size.width, duration: transitionDuration * Double(index + 1))
            let permanentMovementAction = SKAction.moveTo(x: 1.5 * sprites[index].size.width, duration: transitionDuration * Double(numberOfSprites))
            let putsImageOnTheRight = SKAction.moveTo(x: sprites[index].size.width/2 - (sprites[index].size.width * CGFloat(numberOfSprites - 1)), duration: 0.0)
            sprites[index].run(SKAction.sequence([initialMovementAction, putsImageOnTheRight, SKAction.repeatForever(SKAction.sequence([permanentMovementAction, putsImageOnTheRight]))]))
            scene?.addChild(sprites[index])
        }
    }
    
    private func scrollToTheLeft() {
        let numberOfSprites = sprites.count
        let transitionDuration = self.speed
        for index in 0...numberOfSprites - 1 {
            sprites[index].position = CGPoint(x: sprites[index].size.width/2 + (CGFloat(index) * sprites[index].size.width), y: UIScreen.main.bounds.height/2)
            let initialMovementAction = SKAction.moveTo(x: -1 * sprites[index].size.width/2, duration: transitionDuration * Double(index + 1))
            let permanentMovementAction = SKAction.moveTo(x: -1 * sprites[index].size.width/2, duration: transitionDuration * Double(numberOfSprites))
            let putsImageOnTheLeft = SKAction.moveTo(x: sprites[index].size.width/2 + (sprites[index].size.width * CGFloat(numberOfSprites - 1)), duration: 0.0)
            sprites[index].run(SKAction.sequence([initialMovementAction, putsImageOnTheLeft, SKAction.repeatForever(SKAction.sequence([permanentMovementAction, putsImageOnTheLeft]))]))
            scene?.addChild(sprites[index])
        }
    }
    
    private func scrollUp() {
        let numberOfSprites = sprites.count
        let transitionDuration = self.speed
        for index in 0...numberOfSprites - 1 {
            sprites[index].position = CGPoint(x: UIScreen.main.bounds.width/2, y: sprites[index].size.height/2 - (CGFloat(index) * sprites[index].size.height))
            let initialMovementAction = SKAction.moveTo(y: 1.5 * sprites[index].size.height, duration: transitionDuration * Double(index + 1))
            let permanentMovementAction = SKAction.moveTo(y: 1.5 * sprites[index].size.height, duration: transitionDuration * Double(numberOfSprites))
            let putsImageOnBottomAction = SKAction.moveTo(y: sprites[index].size.height/2 - (sprites[index].size.height * CGFloat(numberOfSprites - 1)), duration: 0.0)
            sprites[index].run(SKAction.sequence([initialMovementAction, putsImageOnBottomAction, SKAction.repeatForever(SKAction.sequence([permanentMovementAction, putsImageOnBottomAction]))]))
            scene?.addChild(sprites[index])
        }
    }
    
    private func scrollDown() {
        let numberOfSprites = sprites.count
        let transitionDuration = self.speed
        for index in 0...numberOfSprites - 1 {
            sprites[index].position = CGPoint(x: UIScreen.main.bounds.width/2, y: sprites[index].size.height/2 + (CGFloat(index) * sprites[index].size.height))
            let initialMovementAction = SKAction.moveTo(y: -1 * sprites[index].size.height/2, duration: transitionDuration * Double(index + 1))
            let permanentMovementAction = SKAction.moveTo(y: -1 * sprites[index].size.height/2, duration: transitionDuration * Double(numberOfSprites))
            let putsImageOnTopAction = SKAction.moveTo(y: sprites[index].size.height/2 + (sprites[index].size.height * CGFloat(numberOfSprites - 1)), duration: 0.0)
            sprites[index].run(SKAction.sequence([initialMovementAction, putsImageOnTopAction, SKAction.repeatForever(SKAction.sequence([permanentMovementAction, putsImageOnTopAction]))]))
            scene?.addChild(sprites[index])
        }
    }
    
    private static func calculateSpriteSize(_ direction : ScrollDirection, _ imageSize : CGSize, _ scene : SKScene) -> CGSize {
        var size = CGSize()
        switch direction {
        case .top, .bottom:
            let width = scene.frame.width
            let aspectRatio = imageSize.width/imageSize.height
            size = CGSize(width: width, height: width/aspectRatio)
        case .left, .right:
            let width = scene.frame.width
            let aspectRatio = imageSize.width/imageSize.height
            size = CGSize(width: width, height: width/aspectRatio)
        }
        return size
    }
    
    private static func makeSpriteNodes(_ images : [UIImage], _ size : CGSize) -> [SKSpriteNode] {
        var tempSprites = [SKSpriteNode]()
        for image in images {
            let texture = SKTexture(image: image)
            let sprite = SKSpriteNode(texture: texture, color: .clear, size: size)
            tempSprites.append(sprite)
        }
        return tempSprites
    }
    
    // Getters and Setters
    private func getAlpha() -> CGFloat {
        return sprites[0].alpha
    }
    
    private func setAlpha(_ value : CGFloat) {
        for sprite in sprites {
            sprite.alpha = value
        }
    }
    
    private func getZPosition() -> CGFloat {
        return sprites[0].zPosition
    }
    
    private func setZPosition(_ value : CGFloat) {
        for sprite in sprites {
            sprite.zPosition = value
        }
    }
    
}
















