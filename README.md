
This project is the result of the near certification development course. It aims
to create an online index of papers for researchers.

## Samples

This repository includes a complete project structure for AssemblyScript contracts targeting the NEAR platform.

This project contain the very basic concepets of smart contract:
- a single contract
- the application of `view` and `change` methods.
- a basic storage

There is 1 AssemblyScript contracct in this project. We modified the singleton of the original:

- **singleton** in the `src/singleton` folder

## Usage

### Getting started

INSTALL `NEAR CLI` first like this: `npm i -g near-cli`

1. clone this repo to a local folder
3. go to `./scripts`
2. run `yarn`
2. run `yarn build`
5. run `./index-paper.sh`


## The file system

```sh
├── README.md                          # this file
├── as-pect.config.js                  # configuration for as-pect (AssemblyScript unit testing)
├── asconfig.json                      # configuration for AssemblyScript compiler (supports multiple contracts)
├── package.json                       # NodeJS project manifest
├── scripts
│   ├── index-paper.sh                 # helper: build and deploy contracts
│   ├── 3.cleanup.sh                   # helper: delete build and deploy artifacts
│   └── README.md                      # documentation for helper scripts
├── src
│   ├── as_types.d.ts                  # AssemblyScript headers for type hints
│   ├── singleton                      # Contract 2: "Singleton-style example"
│   │   ├── __tests__
│   │   │   ├── as-pect.d.ts           # as-pect unit testing headers for type hints
│   │   │   └── index.unit.spec.ts     # unit tests for contract 2
│   │   ├── asconfig.json              # configuration for AssemblyScript compiler (one per contract)
│   │   └── assembly
│   │       └── index.ts               # contract code for contract 2
│   ├── tsconfig.json                  # Typescript configuration
│   └── utils.ts                       # common contract utility functions
└── yarn.lock                          # project manifest version lock
```
