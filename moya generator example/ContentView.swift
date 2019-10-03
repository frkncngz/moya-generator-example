//
//  ContentView.swift
//  moya generator example
//
//  Created by Furkan Cengiz on 3.10.2019.
//  Copyright © 2019 epcsht. All rights reserved.
//

import SwiftUI
import Moya

struct ContentView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("moya-generator-example")
            Button(action: {
                let provider = MoyaProvider<WavesRPC>()
                provider.request(.nodeInfo) { (result) in
                    switch result {
                    case let .success(moyaResponse):
                        do {
                            _ = try moyaResponse.filterSuccessfulStatusCodes()
                            let data = try moyaResponse.mapJSON()
                            print("json data \(data)")
                        }
                        catch {
                            print("error \(error)")
                        }
                                                
                    case let .failure(error):
                        print("error \(error)")
                    }
                }
            }) {
                Text("Waves Node Info")
            }
            Button(action: {
                let provider = MoyaProvider<WavesRPC>()
                provider.request(.balance(address: "3PJjwFREg8F9V6Cp9fnUuEwRts6HQQa5nfP")) { (result) in
                    switch result {
                    case let .success(moyaResponse):
                        do {
                            _ = try moyaResponse.filterSuccessfulStatusCodes()
                            let data = try moyaResponse.mapJSON()
                            print("json data \(data)")
                            
                            let decoder = JSONDecoder()
                            do {
                                let balance = try decoder.decode(WavesBalance.self, from: moyaResponse.data)
                                print("balance \(balance)")
                            } catch let error {
                                print("error \(error)")
                            }
                        }
                        catch {
                            print("error \(error)")
                        }
                                                
                    case let .failure(error):
                        print("error \(error)")
                    }
                }
            }) {
                Text("Waves Balance")
            }
            Button(action: {
                
                let ripple = MoyaProvider<RippleRPC>()
                ripple.request(.serverState) { (result) in
                    switch result {
                    case let .success(moyaResponse):
                        do {
                            _ = try moyaResponse.filterSuccessfulStatusCodes()
                            let data = try moyaResponse.mapJSON()
                            print("json data \(data)")
                            
                            let decoder = JSONDecoder()
                            do {
                                let serverState = try decoder.decode(JSONResult<RippleServerState>.self, from: moyaResponse.data)
                                print("serverState \(serverState.result)")
                            } catch let error {
                                print("error \(error)")
                            }
                        }
                        catch {
                            print("error \(error)")
                        }
                                                
                    case let .failure(error):
                        print("error \(error)")
                    }
                }
                
            }) {
                Text("Ripple Server State")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
