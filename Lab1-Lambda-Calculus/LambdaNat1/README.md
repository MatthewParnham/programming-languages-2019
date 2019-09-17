# LambdaNat1

To run a program in the language LambdaNat:

- Install [Docker](https://docs.docker.com/install/). (On Windows make sure to run Linux containers)

- Enter this folder in terminal.

- Run `docker build . -t lambdanat`. (warning: may take a while since a lot has to be downloaded/built)

- Run `echo "\x.x" | docker run -i --rm lambdanat` to test that the setup is working.

## Run a File

Easiest way to run a file is with `cat test/test-xxyz.lc | docker run -i --rm temp`.

## Debug

The following commands can help debugging issues when building.

`docker build . -t lambdanat --target builder` for stopping the build before discarding everything.

`docker run -it --rm lambdanat bash` to inspect the building stage.

The `/grammar` folder also has a Dockerfile only for running the parser, although it can't generate a binary executable.

## Saving Image

Save the image with: `docker save lambdanat > lambdanat.tar`.

And import it with `docker load < lambdanat.tar` in the same directory as `lambdanat.tar`.

If you just want to parse a program in the language Lambda Nat, see [here](https://github.com/alexhkurz/programming-languages-2019/tree/master/Lambda-Calculus/LambdaNat/grammar#readme).
