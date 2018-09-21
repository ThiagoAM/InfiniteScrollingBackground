//
//  Infinite Scrolling Background.swift
//  Created by Thiago Martins on 27/03/2018.
//  github.com/ThiagoAM/InfiniteScrollingBackground
//

import SpriteKit

class InfiniteScrollingBackground {
    
    // MARK: Enumerations
    enum ScrollDirection {
        case top, bottom, left, right
    }
    
    // MARK: Public Properties
    public var speed : CGFloat {
        get { return getSpeed() }
        set { setSpeed(newValue) }
    }
    
    public var zPosition : CGFloat {
        get { return getZPosition() }
        set { setZPosition(newValue) }
    }
    
    public var alpha : CGFloat {
        get { return getAlpha() }
        set { setAlpha(newValue) }
    }
    
    public var isPaused : Bool {
        get { return getIsPaused() }
        set { setIsPaused(newValue) }
    }
    
    // MARK: Public Properties
    public unowned let scene : SKScene
    public let sprites : [SKSpriteNode]
    public let transitionSpeed : TimeInterval
    public let scrollDirection : ScrollDirection
    
    // MARK: Initialization
    
    /*
     Creates an Infinite Scrolling Background for a SKScene.
     - images: use at least 2 images
     - scene: your SKScene instance
     - scrollDirection: use .top, .bottom, .left or .right
     - transitionSpeed: any value between 0 and 100. The bigger, the faster!
     */
    init?(images : [UIImage], scene : SKScene, scrollDirection : ScrollDirection, transitionSpeed : Double) {
        
        // handling invalid initializations:
        guard images.count > 1 else {
            InfiniteScrollingBackground.printInitErrorMessage("You must provide at least 2 images!")
            return nil
        }
        guard (transitionSpeed > 0) && (transitionSpeed <= 100) else {
            InfiniteScrollingBackground.printInitErrorMessage("The transitionSpeed must be between 0 and 100!")
            return nil
        }
        
        // initiating attributes:
        let spriteSize = InfiniteScrollingBackground.spriteNodeSize(scrollDirection, images[0].size, scene)
        self.sprites = InfiniteScrollingBackground.createSpriteNodes(from: images, spriteSize)
        self.scene = scene
        self.scrollDirection = scrollDirection
        self.transitionSpeed = transitionSpeed
        
        // Setup the anchor point for every sprite:
        setSpritesAnchorPoints()
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
    
    /**
     Scrolls the background images to the right.
    */
    private func scrollToTheRight() {
        let numberOfSprites = sprites.count
        let transitionDuration = self.transitionDuration(transitionSpeed: transitionSpeed)
        for index in 0...numberOfSprites - 1 {
            sprites[index].position = CGPoint(x: sprites[index].size.width/2 - (CGFloat(index) * sprites[index].size.width), y: sceneSize().height/2)
            let initialMovementAction = SKAction.moveTo(x: 1.5 * sprites[index].size.width, duration: transitionDuration * Double(index + 1))
            let permanentMovementAction = SKAction.moveTo(x: 1.5 * sprites[index].size.width, duration: transitionDuration * Double(numberOfSprites))
            let putsImageOnTheRight = SKAction.moveTo(x: sprites[index].size.width/2 - (sprites[index].size.width * CGFloat(numberOfSprites - 1)), duration: 0.0)
            sprites[index].run(SKAction.sequence([initialMovementAction, putsImageOnTheRight, SKAction.repeatForever(SKAction.sequence([permanentMovementAction, putsImageOnTheRight]))]))
            scene.addChild(sprites[index])
        }
    }
    
    /**
     Scrolls the background images to the left.
    */
    private func scrollToTheLeft() {
        let numberOfSprites = sprites.count
        let transitionDuration = self.transitionDuration(transitionSpeed: transitionSpeed)
        for index in 0...numberOfSprites - 1 {
            sprites[index].position = CGPoint(x: sprites[index].size.width/2 + (CGFloat(index) * sprites[index].size.width), y: sceneSize().height/2)
            let initialMovementAction = SKAction.moveTo(x: -1 * sprites[index].size.width/2, duration: transitionDuration * Double(index + 1))
            let permanentMovementAction = SKAction.moveTo(x: -1 * sprites[index].size.width/2, duration: transitionDuration * Double(numberOfSprites))
            let putsImageOnTheLeft = SKAction.moveTo(x: sprites[index].size.width/2 + (sprites[index].size.width * CGFloat(numberOfSprites - 1)), duration: 0.0)
            sprites[index].run(SKAction.sequence([initialMovementAction, putsImageOnTheLeft, SKAction.repeatForever(SKAction.sequence([permanentMovementAction, putsImageOnTheLeft]))]))
            scene.addChild(sprites[index])
        }
    }
    
    /**
     Scrolls up the background images.
     */
    private func scrollUp() {
        let numberOfSprites = sprites.count
        let transitionDuration = self.transitionDuration(transitionSpeed: transitionSpeed)
        for index in 0...numberOfSprites - 1 {
            sprites[index].position = CGPoint(x: sceneSize().width/2, y: sprites[index].size.height/2 - (CGFloat(index) * sprites[index].size.height))
            let initialMovementAction = SKAction.moveTo(y: 1.5 * sprites[index].size.height, duration: transitionDuration * Double(index + 1))
            let permanentMovementAction = SKAction.moveTo(y: 1.5 * sprites[index].size.height, duration: transitionDuration * Double(numberOfSprites))
            let putsImageOnBottomAction = SKAction.moveTo(y: sprites[index].size.height/2 - (sprites[index].size.height * CGFloat(numberOfSprites - 1)), duration: 0.0)
            sprites[index].run(SKAction.sequence([initialMovementAction, putsImageOnBottomAction, SKAction.repeatForever(SKAction.sequence([permanentMovementAction, putsImageOnBottomAction]))]))
            scene.addChild(sprites[index])
        }
    }
    
    /**
     Scrolls down the background images.
    */
    private func scrollDown() {
        let numberOfSprites = sprites.count
        let transitionDuration = self.transitionDuration(transitionSpeed: transitionSpeed)
        for index in 0...numberOfSprites - 1 {
            sprites[index].position = CGPoint(x: sceneSize().width/2, y: sprites[index].size.height/2 + (CGFloat(index) * sprites[index].size.height))
            let initialMovementAction = SKAction.moveTo(y: -1 * sprites[index].size.height/2, duration: transitionDuration * Double(index + 1))
            let permanentMovementAction = SKAction.moveTo(y: -1 * sprites[index].size.height/2, duration: transitionDuration * Double(numberOfSprites))
            let putsImageOnTopAction = SKAction.moveTo(y: sprites[index].size.height/2 + (sprites[index].size.height * CGFloat(numberOfSprites - 1)), duration: 0.0)
            sprites[index].run(SKAction.sequence([initialMovementAction, putsImageOnTopAction, SKAction.repeatForever(SKAction.sequence([permanentMovementAction, putsImageOnTopAction]))]))
            scene.addChild(sprites[index])
        }
    }
    
    /**
     Converts the transitionSpeed to the transition duration.
    */
    private func transitionDuration(transitionSpeed : Double) -> TimeInterval {
        return 50.0/transitionSpeed
    }
    
    /**
     Returns the scene size.
    */
    private func sceneSize() -> CGSize {
        return scene.size
    }
    
    /**
     Sets the anchor points of every sprite node to match the scene's anchor point.
    */
    private func setSpritesAnchorPoints() {
        for sprite in sprites {
            sprite.anchorPoint.x = scene.anchorPoint.x + 0.5
            sprite.anchorPoint.y = scene.anchorPoint.y + 0.5
        }
    }
    
    /**
     Returns the size the background sprite node objects.
    */
    private static func spriteNodeSize(_ direction : ScrollDirection, _ imageSize : CGSize, _ scene : SKScene) -> CGSize {
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
    
    /**
     Creates every sprite node from a image array.
    */
    private static func createSpriteNodes(from images : [UIImage], _ size : CGSize) -> [SKSpriteNode] {
        var tempSprites = [SKSpriteNode]()
        for image in images {
            let texture = SKTexture(image: image)
            let sprite = SKSpriteNode(texture: texture, color: .clear, size: size)
            tempSprites.append(sprite)
        }
        return tempSprites
    }
    
    // MARK: Getters and Setters:
    private func getSpeed() -> CGFloat {
        return sprites[0].speed
    }
    
    private func setSpeed(_ value : CGFloat) {
        for sprite in sprites {
            sprite.speed = value
        }
    }
    
    private func getIsPaused() -> Bool {
        return sprites[0].isPaused
    }
    
    private func setIsPaused(_ value : Bool) {
        for sprite in sprites {
            sprite.isPaused = value
        }
    }
    
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
    
    // MARK: Static Private Methods
    
    /**
     Prints an initialization error message.
    */
    static private func printInitErrorMessage(_ message : String) {
        print("InfiniteScrollingBackground Initialization Error - \(message)")
    }
}
