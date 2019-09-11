FROM haskell:8.6.5

RUN mkdir -p /LambdaNat
WORKDIR /LambdaNat

RUN cabal new-update
RUN cabal new-install BNFC

# Add just the .cabal file to capture dependencies
COPY LambdaNat.cabal ./

# Add and Install Application Code
COPY ./app .
COPY ./src .
COPY ./grammar .

RUN bnfc -m -haskell ./grammar/LambdaNat.cf
RUN cabal new-build

CMD []
