import Foundation
import GameController
import Combine

/// Observes MFI or Remote Controllers in the area. Sets them up.
public class GCOverseer: ObservableObject {

    // MARK: - Properties

    @Published var isGameControllerConnected: Bool = false

    var isLoggingEnabled: Bool = true

    // MARK: - Private Properties

    private var cancellableNotifications = Set<AnyCancellable>()

    private let notificationCenter = NotificationCenter.default

    // MARK: - Lifecycle

    public init() {
        listenToGameControllerNotifications()
    }
}

// MARK: - Private

private extension GCOverseer {

    // MARK: - GCController Notification

    func listenToGameControllerNotifications() {
        setupSubscription(for: .GCControllerDidConnect)
        setupSubscription(for: .GCControllerDidDisconnect)
    }

    // MARK: Subscription Setup

    func setupSubscription(for notificationName: Notification.Name) {
        let didConnect = (notificationName == .GCControllerDidConnect)
        notificationCenter
            .publisher(for: notificationName)
            .handleEvents(receiveOutput: { self.log(notification: $0) })
            .receive(on: DispatchQueue.main)
            .map({ _ in didConnect })
            .assign(to: \.isGameControllerConnected, on: self)
            .store(in: &cancellableNotifications)
    }

    // MARK: Logging

    func log(notification: Notification) {
        log(information: "Received game controller notification: \(notification)", category: .gcNotification)
    }
}
