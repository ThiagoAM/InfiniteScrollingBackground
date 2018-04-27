# InfiniteScrollingBackground (Swift 4.1)
**How to use:** <br />
• Create a `InfiniteScrollingBackground` instance <br />
• Call the `scroll` method <br />
• That's it! <br /><br />

**Check out the Xcode project inside the Example_Project folder!**<br />

# Example (inside a SKScene)
```
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
```

# Advices
• Use images with a similar aspect ratio to the device's display. Example: If it's an iPhone on landscape, try to use a 16:9 image. On portrait, use 9:16 images; <br />
• Remember to set the `zPosition` after initializing the scrolling background object.
