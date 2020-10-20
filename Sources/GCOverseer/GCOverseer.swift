import Foundation
import GameController
import Combine

/// Observes MFI or Remote Controllers in the area. Sets them up.
public class GCOverseer: ObservableObject {

    // MARK: - Properties

    /// Subscribe to this variable to keep track of connect / disconnect events of game controllers.
    @Published public var isGameControllerConnected: Bool = false

    /// Subscribe to this variable to keep track of any type of controllers (e.g.: `extendedGamepad`, `microGamepad`) that are connected to the
    /// device.
    @Published public var connectedControllers: [GCController] = []

    /// Subscribe to this variable to keep track of `extendedGamepad` controllers that are connected to the device. E.g. *Dualshock*, *Xbox*
    /// controllers, etc.
    ///
    /// The controls associated with the extended gamepad profile include the following:
    /// - Two shoulder buttons.
    /// - Two triggers.
    /// - Four face buttons arranged in a diamond pattern.
    /// - One directional pad.
    /// - Two thumbsticks.
    ///
    /// See: https://developer.apple.com/documentation/gamecontroller/gcextendedgamepad
    ///
    /// Notice: the `gamepad` type is deprecated and it's now included in the `extendedGamepad` type, as *... a controller supporting the Extended
    /// Gamepad profile for example supports the Gamepad profile and more...*.
    @Published public var connectedExtendedGamepads: [GCController] = []

    /// Subscribe to this variable to keep track of `microGamepad` controllers that are connected to the device. E.g. Apple's *Siri Remote*.
    ///
    /// The controls associated with the micro gamepad profile include the following:
    /// - Two digital face buttons (A and X).
    /// - One analog directional pad (D-pad), implemented as a touchpad.
    ///
    /// Controllers that implement the micro gamepad profile can be used in either landscape or portrait orientations. By default, these devices are usually
    /// used in portrait mode.
    ///
    /// See: https://developer.apple.com/documentation/gamecontroller/gcmicrogamepad
    @Published public var connectedMicroGamepads: [GCController] = []

    /// Enables / disables logging output to both *Xcode's Console* and the macOS *Console app*. `true` by default.
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
            .handleEvents(receiveOutput: { [weak self] in
                self?.log(notification: $0)
                let currentControllers = GCController.controllers()
                self?.connectedControllers = currentControllers
                self?.connectedExtendedGamepads = currentControllers.filter { $0.extendedGamepad != nil }
                self?.connectedMicroGamepads = currentControllers.filter { $0.microGamepad != nil }
            })
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
