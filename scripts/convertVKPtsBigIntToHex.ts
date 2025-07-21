import { readFileSync, writeFileSync } from "fs"

async function main() {
    const vkeys = JSON.parse(readFileSync(`./verification-keys.json`, "utf8"))

    const contractVkPoints = []

    let tempResult

    for (let i = 0; i < vkeys.vk_delta_2.length; i += 1) {
        tempResult = []
        for (let j = 0; j < vkeys.vk_delta_2[i].length - 1; j += 1) {
            tempResult.push(...vkeys.vk_delta_2[i][j].slice().reverse().map(BigInt))
        }
        for (let j = 0; j < vkeys.IC[i].length; j += 1) {
            tempResult.push(...vkeys.IC[i][j].slice(0, -1).map(BigInt))
        }
        contractVkPoints.push(tempResult)
    }

    const VK_POINTS: string[] = []

    const array = contractVkPoints.flat()
    array.forEach((v) => {
        // convert to 32 bytes, 64-char string
        let bytes = v.toString(16)
        if (bytes.length < 64) {
            bytes = `${"0".repeat(64 - bytes.length)}${bytes}`
        }
        console.info(`hex"${bytes}"`)
        VK_POINTS.push(`hex"${bytes}"`)
    })

    const result = `${VK_POINTS.join("\n")}`
    writeFileSync("./contract-verification-keys-hex.txt", result)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
