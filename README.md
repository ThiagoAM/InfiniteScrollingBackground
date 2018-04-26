# InfiniteScrollingBackground (Swift 4.1)
**How to use:** <br />
• Create a `InfiniteScrollingBackground` instance <br />
• Call the `scroll` method <br />
• That's it! <br />

# Example (inside a SKScene)
```
class ExampleGameScene : SKScene {
    
    // Declaring the InfiniteScrollingBackground Instance:
    var scrollingBackground : GameAudioPlayer?
    
    override init() {
        super.init()
        
        // Getting the images:
        let images : [UIImage] = [UIImage(named: "bg1"), UIImage(named: "bg2")]
        
        // Initializing InfiniteScrollingBackground's Instance:
        scrollingBackground = InfiniteScrollingBackground(images: images, scene: self, scrollDirection: .bottom, speed: 3)
        
        // (Optional) Changing the instance's zPosition:
        scrollingBackground?.zPosition = 0.5
        
        // Using it:
        scrollingBackground?.scroll()
       
    }
    
}
```

# Advices
• Use images with a similar aspect ratio to the device's display. Example: If it's an iPhone on landscape, try to use a 16:9 image. On portrait, use 9:16 images; <br />
• Remember to set the `zPosition` after initializing the scrolling background object.
