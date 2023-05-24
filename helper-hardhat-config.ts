export type NetworkConfigItem = {
    name?: string
    //ERC20 tokens
    stEth?: string
    WETH?: string
    // Curve pool Addresses
    curveEthStEthPool?: string
    // Yam and team addresses
    yamGovernance?: string
    yamReserves?: string
    teamMultisig?: string
}

export type NetworkConfigInfo = {
    [key: number]: NetworkConfigItem
}

export const networkConfig: NetworkConfigInfo = {
    31337: {
        name: "hardhat",
        curveEthStEthPool: "0xDC24316b9AE028F1497c275EB9192a3Ea0f67022",
        stEth: "0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84",
        WETH: "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
        yamGovernance: "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266", // deployer TODO: change to yam governance
        yamReserves: "0x97990B693835da58A281636296D2Bf02787DEa17",
        teamMultisig: "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266", // deployer TODO: change to team multisig
    },
    5: {
        name: "goerli",
        curveEthStEthPool: "0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506",
        stEth: "0x1643E812aE58766192Cf7D2Cf9567dF2C37e9B7F",
        WETH: "0xb4fbf271143f4fbf7b91a5ded31805e42b2208d6",
        yamGovernance: "0xA3f4d9497Bf09800a76472251fAdaa86B1Af9c01",
        yamReserves: "0xA3f4d9497Bf09800a76472251fAdaa86B1Af9c01",
        teamMultisig: "0xA3f4d9497Bf09800a76472251fAdaa86B1Af9c01",
    },
    11155111: {
        name: "sepolia",
        curveEthStEthPool: "", // TODO: change to sepolia curve pool
        stEth: "",
        yamGovernance: "0xA3f4d9497Bf09800a76472251fAdaa86B1Af9c01", // deployer TODO: change to yam governance
        yamReserves: "0x97990B693835da58A281636296D2Bf02787DEa17",
        teamMultisig: "0xA3f4d9497Bf09800a76472251fAdaa86B1Af9c01", // deployer TODO: change to team multisig
    },
}

export const developmentChains = ["hardhat", "localhost", "local"]
export const yiqiBaseURI = "https://api.yiqi.us/token/" // TODO: Change this to the correct baseURI
export const yiqiBackgroundBaseURI = "https://api.yiqi.io/background/" // TODO: Change this to the correct baseURI

export const yiqiRoyaltiesFeeNumerator = "300" // TODO: check this value. Denominator 10000 -- so 300 = 3%

export const yiqiBackgroundRoyaltiesFeeNumerator = "300" // TODO: check this value. Denominator 10000 -- so 300 = 3%

export const frontEndContractsFile = "../yiqi-marketplace/constants/networkMapping.json"
export const frontEndAbiLocation = "../yiqi-marketplace/constants/"
