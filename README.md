DerelictSFML2
==========

Dynamic bindings to version 2 of [the SFML libraries](http://assimp.sourceforge.net/) for the D Programming Language.

For information on how to build DerelictSFML2 and link it with your programs, please see the post [Building and Using Packages in DerelictOrg](http://dblog.aldacron.net/forum/index.php?topic=841.0) at the Derelict forums.

For information on how to load the SFML2 libraries via DerelictSFML2, see the page [DerelictUtil for Users](https://github.com/DerelictOrg/DerelictUtil/wiki/DerelictUtil-for-Users) at the DerelictUtil Wiki. Note that SFML2 is not a single library, but a collection of libraries. Each library has a loader in DerelictSFML2. Here's an example:

```D
import derelict.sfml2.system; // For the system library.
import derelict.sfml2.window; // For the window library.
import derelict.sfml2.audio; // For the audio library.
import derelict.sfml2.graphics; // For the graphics library.
import derelict.sfml2.network; // For the network library.

void main() {
    // Load the SFML2 System libraries you need. Note that this sample inports
    // and loads them all, but you only need to do so for the libraries you intend
    // to actually use.
    DerelictSFML2System.load();
    DerelictSFML2Window.load();
    DerelictSFML2Audio.load();
    DerelictSFML2Graphics.load();
    DerelictSFML2Network.load();

    // Now you can call functions from the all of the SFML2 libraries.
}
```

Finally, it should be noted that there are two versions of the SDL shared libraries. One is written in C++, the other in C. For DerelictSFML2, you need to use the C version of the libraries, known as CSFML. DerelictSFML2 cannot load the C++ SFML2 libraries.
