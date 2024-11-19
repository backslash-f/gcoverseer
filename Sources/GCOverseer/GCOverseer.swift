import Foundation
import GameController
import Combine

/// Observes MFI or Remote Controllers in the area. Sets them up.
public class GCOverseer: ObservableObject, GCOverseerProtocol {
    // MARK: - Properties

    /// Returns all controllers that are connected to the device. E.g. *Dualshock*, *Xbox*, *Siri Remote* controllers, etc.
    ///
    /// The returned controllers support any gamepad profile: `extendedGamepad`, `microGamepad`, `motion`, etc.
    ///
    /// - Returns: All controllers that are connected to the device.
    public var controllers: [GCController] {
        didSet {
            if isLoggingEnabled {
                log(information: "Number of connected controllers: \(self.controllers.count)", category: .controller)
                self.controllers.enumerated().forEach {
                    let productCategoryPrefix = "Product category of controller \($0.offset + 1):"
                    let productCategory = String(describing: $0.element.productCategory) // E.g.: "Dualshock 4"
                    log(information: "\(productCategoryPrefix) \(productCategory)", category: .controller)
                }
            }
        }
    }

    /// Subscribe to this variable to keep track of connect / disconnect events of game controllers.
    @Published public var isGameControllerConnected: Bool = GCController.controllers().count >= 1

    // MARK: Internal Properties

    /// Enables / disables logging output to both *Xcode's Console* and the macOS *Console app*. `true` by default.
    internal var isLoggingEnabled: Bool = true

    // MARK: Private Properties

    private var cancellableNotifications = Set<AnyCancellable>()

    private let notificationCenter = NotificationCenter.default

    // MARK: - Lifecycle

    /// Creates an instance of the `GCOverseer` and listens to game controller notifications.
    ///
    /// - Parameter controllers: Allows for mocking during tests.
    /// Defaults to `GCController.controllers()`.
    public init(controllers: [GCController]? = nil) {
        self.controllers = controllers ?? GCController.controllers()
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
                self?.controllers = GCController.controllers()
            })
            .receive(on: DispatchQueue.main)
            .map({ _ in didConnect })
            .assign(to: \.isGameControllerConnected, on: self)
            .store(in: &cancellableNotifications)
    }
}
