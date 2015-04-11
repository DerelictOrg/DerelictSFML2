DerelictSFML2
==========

Dynamic bindings to version 2.2 of [the SFML libraries][1] for the D Programming Language.

Please see the pages [Building and Linking Derelict][2] and [Using Derelict][3], in the Derelict documentation, for information on how to build DerelictSFML2 and load the SFML2 libraries at run time. In the meantime, here's some sample code.

```D
import derelict.sfml2.system; // For the system library.
import derelict.sfml2.window; // For the window library.
import derelict.sfml2.audio; // For the audio library.
import derelict.sfml2.graphics; // For the graphics library.
import derelict.sfml2.network; // For the network library.

void main() {
    // Load the SFML2 System libraries you need. Note that this sample imports
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

Finally, it should be noted that there are two versions of the SFML2 shared libraries. One is written in C++, the other in C. For DerelictSFML2, you need to use the C version of the libraries, known as CSFML. DerelictSFML2 cannot load the C++ SFML2 libraries.

[1]: http://www.sfml-dev.org/
[2]: http://derelictorg.github.io/compiling.html
[3]: http://derelictorg.github.io/using.html
