# iOSCore
Core module for NativeBrige between game and iOS.
Make it easy to call between iOS and game.

1. In Game or iOS, Set Handler with 'key'
2. On the other side, Create Message with 'key' and data, call 'Notify' function
3. handler with 'key' will be called with 'data'
4. If you want to return result, call 'giveBack' function with 'data'

