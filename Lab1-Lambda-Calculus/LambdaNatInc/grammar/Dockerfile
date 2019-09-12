FROM haskell:8.6.5 AS builder

# Create and move into project folder
RUN mkdir -p /LambdaNat
WORKDIR /LambdaNat

# Install BNFC, and other needed packages
RUN cabal new-update
RUN cabal new-install BNFC-2.8.3
RUN cabal new-install alex-3.2.4 happy-1.19.12

# Copy and generate grammer code
COPY LambdaNatInc.cf ./
RUN bnfc -m -haskell LambdaNatInc.cf
RUN make

# Execute the binary
CMD ["./TestLambdaNatInc"]
