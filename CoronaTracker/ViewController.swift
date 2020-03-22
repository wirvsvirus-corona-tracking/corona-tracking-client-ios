//
//  ViewController.swift
//  CoronaTracker
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import UIKit
import CoronaTrackerClient
import CoronaTrackerClientTest

final class ViewController: UIViewController {

    @IBOutlet weak var profileStateView: UIView!
    @IBOutlet weak var profileStateEmojiLabel: UILabel!
    @IBOutlet weak var thoughtBallonEmojiLabel: UILabel!
    @IBOutlet weak var faceWithThermometerEmojiLabel: UILabel!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tracker.start { _, profileState in
            DispatchQueue.main.async { [weak self] in
                self?.updateViews(forProfileState: profileState)
            }
        }
    }

    private lazy var tracker: Tracker = { .init() }()

    private func updateViews(forProfileState state: Int) {
        switch state {
        case 0:
            self.profileStateView.backgroundColor = .systemGreen
            self.profileStateView.accessibilityLabel = "You are not infected"
            self.profileStateEmojiLabel.text = "😃"
            self.thoughtBallonEmojiLabel.isHidden = true
            self.faceWithThermometerEmojiLabel.isHidden = true
        default:
            self.profileStateView.backgroundColor = .white
            self.profileStateView.accessibilityLabel = ""
            self.profileStateEmojiLabel.text = "🤔"
            self.thoughtBallonEmojiLabel.isHidden = false
            self.faceWithThermometerEmojiLabel.isHidden = false
        }
    }
}

private extension Tracker {

    convenience init() {
        self.init(
            profileIdentifierProvider: DefaultProfileIdentifierProvider(), client: TestClient(), tokenProvider: TestTokenProvider())
    }
}

private final class DefaultProfileIdentifierProvider: ProfileIdentifierProvider {

    let profileIdentifier: String? = nil
}
