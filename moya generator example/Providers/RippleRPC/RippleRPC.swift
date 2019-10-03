import Foundation
import Moya

enum RippleRPC {
	case account(address: String)
	case broadcast(hex: String)
	case transaction(ID: String)
	case serverState
}

extension RippleRPC: TargetType {
    var baseURL: URL {
        return URL(string: "https://ripple-rpc.trustwalletapp.com")!
    }

    var path: String {
        switch self {
        case .account:
			return "/"
		case .broadcast:
			return "/"
		case .transaction:
			return "/"
		case .serverState:
			return "/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .account, .broadcast, .transaction, .serverState:
			return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .account(let address):
			let parameters: [String: Any]
			parameters = [
				"account": address,
				"strict": true,
				"ledger_index": "current",
				"queue": true
			]
			return .requestParameters(parameters: [
				"method": "account_info",
				"params": [parameters]
			], encoding: JSONEncoding())
		case .broadcast(let hex):
			let parameters: [String: Any]
			parameters = [
				"tx_blob": hex
			]
			return .requestParameters(parameters: [
				"params": [parameters],
				"method": "submit"
			], encoding: JSONEncoding())
		case .transaction(let ID):
			let parameters: [String: Any]
			parameters = [
				"transaction": ID
			]
			return .requestParameters(parameters: [
				"params": [parameters],
				"method": "tx"
			], encoding: JSONEncoding())
		case .serverState:
			let parameters: [String: Any]
			parameters = [:]
			return .requestParameters(parameters: [
				"params": [parameters],
				"method": "server_state"
			], encoding: JSONEncoding())
        }
    }

    var headers: [String: String]? {
        return [
            "content-type": "application/json",
			"accept": "application/json"
        ]
    }
}