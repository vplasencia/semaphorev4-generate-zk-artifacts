import { mkdirSync, copyFileSync } from "fs"

/**
 * This script generates the snark artifacts repo files.
 * It copies the zkey and wasm files for each semaphore version
 * from the p0tion-artifacts and build directories to the snark-artifacts-repo-files directory.
 *
 * Usage: ts-node generate-snark-artifacts-repo-files.ts <start> <end>
 * where <start> and <end> are the range of semaphore versions to process.
 */
if (process.argv.length === 4) {
    const start = Number(process.argv[2])
    const end = Number(process.argv[3])

    mkdirSync(`./snark-artifacts-repo-files`, { recursive: true })

    for (let i = start; i <= end; i += 1) {
        copyFileSync(`./p0tion-artifacts/semaphore-${i}_final.zkey`, `./snark-artifacts-repo-files/semaphore-${i}.zkey`)
        copyFileSync(
            `./build/semaphore-${i}/groth16/semaphore-${i}_js/semaphore-${i}.wasm`,
            `./snark-artifacts-repo-files/semaphore-${i}.wasm`
        )
    }
} else {
    console.error("Expected one argument!")
    process.exit(1)
}
