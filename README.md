# i2nzip

__A tool for converting your intellij projects to a Netbeans friendly format.__

**Important:** This tool currently doesn't support reading files as netbeans and intellij work through a different CWD but I haven't been able to figure out how they're different...

#### Why does this exist? Can't I just export my intellij project as a zip file?

Ah, my sweet summer child... Netbeans only recognizes projects that contains 
Netbeans-specific metadata files as Netbeans projects. 

If your professor told you to only use Netbeans, they're definitely not interested 
in running your code in any other IDE.

### Installation:

1. Clone the repo
2. [Install stack](https://docs.haskellstack.org/en/stable/README/)
3. `stack install`
4. If ~/.local/bin isn't in your path, make sure to add it

If you get an error saying something about bz2 or whatever, make sure to install `libbz2-dev`

### Usage:

`i2nzip-exe [project-name]`

**Make sure to use this in your project root!**

This will take all your files under the `src` directory, add the ~~toxic~~ magic Netbeans sauce
and save it as `[project-name].zip` in the same directory. You can then submit it directly on
canvas or whatever other terrible academics website you're stuck with.

**Important:** This will _not_ copy over anything that's not under `src`. If you're using
maven or gradle or any other build tool they will not be copied.

The configuration found under `resources/` is copied over to the zip file when converting.
## Known bugs

* For some reason, building the project doesn't work but running the code works fine.
If unlike me, you actually use java or netbeans, raise an issue or a pull request and we'll fix it.

* Only `src` is copied over. Not really a bug, I just can't be bothered to add more features
since I'm only using this for an intro to cs class and we haven't even gotten to build tools yet.

