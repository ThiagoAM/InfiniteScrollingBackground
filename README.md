# InfiniteScrollingBackground (Swift 5.0 or 4.2)
**How to use:** <br />
• Add the "InfiniteScrollingBackground.swift" file to your project <br />
• Create a `InfiniteScrollingBackground` instance <br />
• Call the `scroll` method <br />
• That's it! <br />

**Check and run the Xcode project inside the Example_Project folder!**<br />

# Example
```swift
class GameScene: SKScene {
    
    // Declaring the InfiniteScrollingBackground instance:
    var scroller : InfiniteScrollingBackground?
    
    override func didMove(to view: SKView) {
        
        // Getting the images:
        let images = [
            UIImage(named: "bgImage1")!,
            UIImage(named: "bgImage2")!
        ]
        
        // Initializing InfiniteScrollingBackground's instance:
        scroller = InfiniteScrollingBackground(images: images,
                                               scene: self,
                                               scrollDirection: .bottom,
                                               transitionSpeed: 3)
        
        // Activating it:
        scroller?.scroll()
        
        // (Optional) Changing the instance's zPosition:
        scroller?.zPosition = 1
    }
    
}
```

# Advices
• Use images with a similar aspect ratio to the device's display. Example: If it's an iPhone on landscape, try to use a 16:9 image. On portrait, use 9:16 images; <br />
• Remember to set a `zPosition` after initializing the scrolling background object so it's visible.

# License
InfiniteScrollingBackground project is licensed under MIT License ([MIT-License](MIT-License) or https://opensource.org/licenses/MIT)
