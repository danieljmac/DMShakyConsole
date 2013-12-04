DMShakyConsole
==============
**IMPORTANT**
This control is designed strictly for dev & testing.  It uses the ASL (Apple System Log) API.  It appears there have been apps approved to the App Store which use ASL, but just to be safe, you should remove this control completely in the production version you submit to Apple.
**END IMPORTANT**

DMShakeyConsole is a simple control to help you catch those pesky bugs and problems while you are testing your app on the go.  For those times when you're app or server does something random and strange, but you weren't wired in with your debug console to check what actually happened.

Shake your iPhone to present a view controller with a built in debug console.

Really simple to use:

Create a strong, nonatomic property of DMShakyView: 
`````objective-c
@property (strong, nonatomic) DMShakyView *shakyView;
`````

And just put these 3 lines of code in viewDidAppear in your rootVC (MUST be viewDidAppear, not viewDidLoad):
`````objective-c
if (_shakyView == nil)
        _shakyView = [[DMShakyView alloc] init];
    [_shakyView enableShakyShaky];
`````  
  

Although it is probably unnecessary because it's already so simple, I've included a little demo app anyways, just to make it a little easier to use & install.
Don't forget to remove this control before you submit to apple, I can not guarantee Apple will approve of you using ASL in production apps.
