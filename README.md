DerelictSFML2
==========

Dynamic bindings to version 2.4 of [the SFML libraries][1] for the D Programming Language.

Please see the pages [Building and Linking Derelict][2] and [Using Derelict][3], in the Derelict documentation, for information on how to build DerelictSFML2 and load the SFML2 libraries at run time. In the meantime, here's some sample code.

```D
import derelict.sfml2;  // For all libraries

/+
// Alternatively, import only the modules for the libraries you need:
import derelict.sfml2.system; 
import derelict.sfml2.window;
import derelict.sfml2.audio;
import derelict.sfml2.graphics;
import derelict.sfml2.network;
+/

void main() {
    // Load the SFML2 System libraries you need. Note that this sample imports
    // and loads them all, but you only need to do so for the libraries you intend
    // to actually use.
    DerelictSFML2System.load();
    DerelictSFML2Window.load();
    DerelictSFML2Audio.load();
    DerelictSFML2Graphics.load();
    DerelictSFML2Network.load();

    // Now you can call functions from the all of the SFML2 libraries that were loaded.
}
```

Finally, it should be noted that there are two versions of the SFML2 shared libraries. One is written in C++, the other in C. For DerelictSFML2, you need to use the C version of the libraries, known as CSFML. DerelictSFML2 cannot load the C++ SFML2 libraries.

[1]: http://www.sfml-dev.org/
[2]: http://derelictorg.github.io/compiling.html
[3]: http://derelictorg.github.io/using.html
