//
//  Client.swift
//  CoronaTrackerClient
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

public protocol Client {

    func send(_ request: Request, response: @escaping (Response) -> Void)
}
