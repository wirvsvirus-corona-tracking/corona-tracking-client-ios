//
//  CoronaTrackerClient.swift
//  CoronaTrackerClient
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

public struct CoronaTrackerClient {

    public init(client: Client) {
        self.client = client
    }

    public func createProfile(_ completion: @escaping (_ profileIdentifier: String?) -> Void) {
        client.send(("", "", nil)) { response in
            completion(response.message)
        }
    }

    private let client: Client
}
