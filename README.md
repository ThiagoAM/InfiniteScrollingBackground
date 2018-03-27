# InfiniteScrollingBackground
How to use:
• Create a InfiniteScrollingBackground instance
• Call the "scroll" method
• That's it!

# Example (inside a SKScene)
```
// Creating the instance:
let images : [UIImage] = [UIImage(named: "bg1"), UIImage(named: "bg2")]
let scrollingBackground = InfiniteScrollingBackground(images: images, scene: self, scrollDirection: .bottom, speed: 3)
// Calling the "scroll" method:
scrollingBackground.scroll()
// (Optional) Changhing the instance's zPosition:
scrollingBackground.zPosition = 0.5
```

# Advices
• Use images with a similar aspect ratio to the device's display. Example: If it's an iPhone on landscape, try to use a 16:9 image. On portrait, use 9:16 images.
• Remember to set the zPosition after initializing the scrolling background object.
