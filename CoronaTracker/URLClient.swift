//
//  URLClient.swift
//  CoronaTracker
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import Foundation
import CoronaTrackerClient

final class URLClient: Client {

    init(serverAddress: String) {
        self.serverAddress = serverAddress
        session = URLSession(configuration: .ephemeral)
    }

    func send(_ request: Request, response: @escaping (Response) -> Void) {
        send(self.request(request.method, request.uri, request.body), completion: response)
    }

    private func request(_ method: String, _ uri: String, _ body: Data?) -> URLRequest {
        var request = URLRequest(url: URL(string: serverAddress + uri)!)
        request.httpMethod = method
        request.httpBody = body
        return request
    }

    private func send(_ request: URLRequest, completion: @escaping (Response) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            completion(((response as? HTTPURLResponse)?.statusCode, data, error))
        }
        task.resume()
    }

    private let serverAddress: String

    private let session: URLSession
}
