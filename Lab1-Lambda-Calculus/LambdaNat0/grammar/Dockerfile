FROM haskell:8.6.5 AS builder

# Create and move into project folder
RUN mkdir -p /LambdaNat
WORKDIR /LambdaNat

# Install BNFC
RUN cabal new-update
RUN cabal new-install BNFC-2.8.3
RUN cabal new-install alex-3.2.4 happy-1.19.12

# Copy over and install application code

# Copy and generate grammer code
COPY LambdaNat0.cf ./
RUN bnfc -m -haskell LambdaNat0.cf
RUN make

# cabal needs 'new-exe' or it won't be able to find the executable
CMD ["./TestLambdaNat"]
