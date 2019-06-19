# InfiniteScrollingBackground (Swift 5.0 or 4.2)
This is the very same moving background used in the Galactic Paper Battles iOS Game! Check it out to see how it looks in action: http://itunes.apple.com/app/id1417391531 <br/> <br/>
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
        
        // Get your images here:
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

# Tips and Advices
• Use images with a similar aspect ratio to the device's display. Example: If it's running on an iPhone on landscape, try using images with an aspect ratio close to 16:9. If on portrait, use images close to 9:16; <br />
• Remember to set a `zPosition` after initializing the scrolling background object so it's visible.
• You can use multiple InfiniteScrollingBackground instances at once, on top of each other. Just remember to set the correct zPositions. You can use opaque images and different speeds to give a nice effect.

# License
InfiniteScrollingBackground project is licensed under MIT License ([MIT-License](MIT-License) or https://opensource.org/licenses/MIT)
