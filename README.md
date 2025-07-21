# Generate Semaphore v4 zk artifacts

This is a project to generate all the zk-artifacts for Semaphore v4.

> [!WARNING]
> These zk-artifacts are just for testing. Do not use them in production applications.

## Run Locally

### Clone the Repository

```bash
git clone https://github.com/vplasencia/semaphorev4-generate-zk-artifacts.git
```

### Install dependencies

```bash
yarn
```

### Generate the zk artifacts for tree depth 1 - 32

```bash
yarn run:all
```

The command will take some minutes (around 10 min in a MacBook Pro, Apple M2 Pro, 16 GB).

The zk-artifacts needed to use Semaphore will be inside a folder named `artifacts` with the following structure.

```text
├── artifacts
│   ├── 1
│   │   ├── semaphore.wasm
│   │   ├── semaphore.zkey
│   │   ├── semaphore.json
│   ├── 2
│   │   ├── semaphore.wasm
│   │   ├── semaphore.zkey
│   │   ├── semaphore.json
│   ├── 3
│   │   ├── semaphore.wasm
│   │   ├── semaphore.zkey
│   │   ├── semaphore.json

        ...

│   ├── 32
│   │   ├── semaphore.wasm
│   │   ├── semaphore.zkey
│   │   ├── semaphore.json
```

## Versions used to generate the zk artifacts for Semaphore v4

```bash
circom compiler 2.2.2
```

```bash
snarkjs@0.7.5
```

## Production Trusted Setup Ceremony

The P0tion project is used for the production Trusted Setup Ceremony.

Steps to follow after the production Trusted Setup Ceremony is finished:

1. Clone this repo: https://github.com/vplasencia/semaphorev4-generate-zk-artifacts and run `yarn` to install dependencies.

2. Add the zkey files to a folder called `p0tion-artifacts`.

3. Run `yarn export-keys`.

This will generate two files:

-   A file called `verification-keys.json` with the verification keys for the Semaphore proof package.

-   A file called `contract-verification-keys-hex.txt` with the `VK_POINTS` values for the Semaphore verifier contract.

4. Update the Semaphore repo.

-   Copy/paste `verification-keys.json` file from the `semaphorev4-generate-zk-artifacts` project into:

https://github.com/semaphore-protocol/semaphore/blob/main/packages/proof/src/verification-keys.json

-   Update contract variable `VK_POINT_BYTES` with the new values from the `contract-verification-keys-hex.txt` file in the `semaphorev4-generate-zk-artifacts` project :

https://github.com/semaphore-protocol/semaphore/blob/v4.12.0/packages/contracts/contracts/base/SemaphoreVerifierKeyPts.sol#L12

5. Release a new Semaphore version.
