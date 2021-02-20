import Foundation
import GameController
import Combine

/// Observes MFI or Remote Controllers in the area. Sets them up.
public class GCOverseer: ObservableObject {

    // MARK: - Properties

    /// Subscribe to this variable to keep track of connect / disconnect events of game controllers.
    @Published public var isGameControllerConnected: Bool = GCController.controllers().count >= 1

    // MARK: Internal Properties

    /// Enables / disables logging output to both *Xcode's Console* and the macOS *Console app*. `true` by default.
    internal var isLoggingEnabled: Bool = true

    // MARK: Private Properties

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
            .handleEvents(receiveOutput: { [weak self] in self?.log(notification: $0) })
            .receive(on: DispatchQueue.main)
            .map({ _ in didConnect })
            .assign(to: \.isGameControllerConnected, on: self)
            .store(in: &cancellableNotifications)
    }
}
