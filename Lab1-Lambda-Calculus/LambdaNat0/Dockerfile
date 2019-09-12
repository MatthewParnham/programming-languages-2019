FROM haskell:8.6.5 AS builder

# Create and move into project folder
RUN mkdir -p /LambdaNat
WORKDIR /LambdaNat

# Install BNFC
RUN cabal new-update
RUN cabal new-install BNFC-2.8.3

# Add just the .cabal file to capture dependencies
COPY LambdaNat.cabal ./

# Copy over and install application code

# Copy and generate grammer code
COPY grammar ./grammar
WORKDIR grammar
RUN bnfc -m -haskell LambdaNat0.cf
WORKDIR /LambdaNat

# Copy rest of project files
COPY app ./app
COPY src ./src
COPY test ./test
COPY LICENSE .

RUN cabal new-build

# cabal needs 'new-exe' or it won't be able to find the executable
CMD ["cabal", "new-exec", "LambdaNat-exe"]


# Stage 2, pure binary

FROM scratch
COPY --from=builder /LambdaNat/dist-newstyle/build/x86_64-linux/ghc-*/LambdaNat-*/x/LambdaNat-exe/build/LambdaNat-exe/LambdaNat-exe /

ENTRYPOINT ["/LambdaNat-exe"]
