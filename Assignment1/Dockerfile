FROM haskell:8.6.5 AS parser

# Create and move into project folder
RUN mkdir -p /LambdaNat
WORKDIR /LambdaNat

# Install dependancies
COPY LambdaNat.cabal ./
RUN cabal new-update && cabal new-install BNFC-2.8.3 alex-3.2.4 happy-1.19.12

# Copy, generate and build grammer code
COPY grammar ./grammar
RUN cd grammar && bnfc -m -haskell LambdaNat5.cf && make && cd ..

CMD ["./grammar/TestLambdaNat"] # CMD only for testing parser


# Stage 2, build the full executable with interpreter
From parser AS full

RUN cabal new-build --only-dependencies

# Copy some unused directories, but needed
#COPY test ./test
COPY LICENSE .

# Move generated grammer to src directory
RUN mkdir ./src && cp -r /LambdaNat/grammar/*.hs ./src && cp -r /LambdaNat/grammar/*.x ./src

# Copy application code
COPY app ./app
COPY src ./src

# Compile everything
RUN cabal new-build

# Cabal needs 'new-exe' or it won't be able to find the executable
CMD ["cabal", "new-exec", "LambdaNat-exe"]

ENTRYPOINT ["/LambdaNat-exe"] # ENTRYPOINT used so the image behaves as a binary

FROM bash:5.0.11 AS test
RUN mkdir test
WORKDIR /test
COPY --from=full /LambdaNat/dist-newstyle/build/x86_64-linux/ghc-*/LambdaNat-*/x/LambdaNat-exe/build/LambdaNat-exe/LambdaNat-exe /test
COPY test .
RUN sh run_tests.sh

# Stage 4, pure binary
FROM scratch

# Copy ONLY the single binary
COPY --from=full /LambdaNat/dist-newstyle/build/x86_64-linux/ghc-*/LambdaNat-*/x/LambdaNat-exe/build/LambdaNat-exe/LambdaNat-exe /
