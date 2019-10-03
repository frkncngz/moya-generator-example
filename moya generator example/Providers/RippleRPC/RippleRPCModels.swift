struct JSONResult <T: Codable>: Codable {
    let result: T
}
struct RippleAccount: Codable {
    let data: RippleAccountData

    private enum CodingKeys: String, CodingKey {
        case data = "account_data"
    }
}
struct RippleAccountData: Codable {
    let Balance: String
	let Sequence: Int64
}
struct RippleLedger: Codable {
    let index: UInt64

    private enum CodingKeys: String, CodingKey {
        case index = "ledger_index"
    }
}
struct RippleJSONTransaction: Codable {
    let hash: String
}
struct RippleSentTransaction: Codable {
    let code: Int
	let message: String
	let tx: RippleJSONTransaction

    private enum CodingKeys: String, CodingKey {
        case code = "engine_result_code"
		case message = "engine_result_message"
		case tx = "tx_json"
    }
}
struct RippleTransaction: Codable {
    let validated: Bool
}
struct RippleServerState: Codable {
    let state: State
}
struct Ledger: Codable {
    let base_fee: Int64
}
struct State: Codable {
    let load_base: Int64
	let load_factor: Int64
	let validated_ledger: Ledger
}
