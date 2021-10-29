//
//  WebsocketService.swift
//  CryptoTracker
//
//  Created by Juan Pablo Ramos on 28/10/21.
//

import Foundation
import Combine

class WebSocketService: ObservableObject {
    
    private let urlSession = URLSession(configuration: .default)
    private var webSocketTask: URLSessionWebSocketTask?
    
    private let baseURL = URL(string: "wss://ws.finnhub.io?token=\(API.finnhub.token)")!
    
    let didChange = PassthroughSubject<Void, Never>()
    @Published var price: String = ""
    
    private var cancellable: AnyCancellable? = nil
    
    var priceResult: String = "" {
        didSet {
            didChange.send()
        }
    }
    
    init() {
        cancellable = AnyCancellable($price
                                        .debounce(for: 0.5, scheduler: DispatchQueue.main)
                                        .removeDuplicates()
                                        .assign(to: \.priceResult, on: self))
        
    }
    
    func connect() {
        stop()
        
        webSocketTask = urlSession.webSocketTask(with: baseURL)
        webSocketTask?.resume()
        
        sendMessage()
        receiveMessage()
    }
    
    func stop() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    func sendMessage() {
        let dataString = "{\"type\":\"subscribe\",\"symbol\":\"BINANCE:BTCUSDT\"}"
        let message = URLSessionWebSocketTask.Message.string(dataString)
        
        webSocketTask?.send(message) { error in
            if let error = error {
                print("[WebsocketService] error sending message (\(dataString)) - \(error)")
            }
        }
    }
    
    func receiveMessage() {
        webSocketTask?.receive {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(.string(let data)):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(APIResponse.self, from: Data(data.utf8))
                    DispatchQueue.main.async {
                        self.price = String(result.data[0].p)
                    }
                } catch {
                    print("[WebsocketService] error decoding message - \(error.localizedDescription)")
                }
                
                self.receiveMessage()
                
            case .failure(let error):
                print("[WebsocketService] error receiving message - \(error)")
                
            default:
                break
            }
        }
    }
}
