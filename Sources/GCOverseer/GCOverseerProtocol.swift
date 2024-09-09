import Foundation
import GameController

/// Protocol for GCOverseer operations, used for abstraction and testing.
public protocol GCOverseerProtocol {

    /// Subscribe to this variable to keep track of connect / disconnect events of game controllers.
    var isGameControllerConnected: Bool { get }

    /// Returns all controllers that are connected to the device.
    func controllers() -> [GCController]

    /// Returns all controllers supporting the `extendedGamepad` profile that are connected to the device.
    func extendedGamepadControllers() -> [GCController]

    /// Returns all *DualShock* controllers that are connected to the device.
    func dualshockControllers() -> [GCController]

    /// Returns all *Xbox* controllers that are connected to the device.
    func xboxControllers() -> [GCController]

    /// Returns all controllers supporting the `microGamepad` profile that are connected to the device.
    func microGamepadControllers() -> [GCController]

    /// Returns all controllers supporting the `motion` profile that are connected to the device.
    func motionControllers() -> [GCController]

    /// Returns the controller for the player 1, player 2, etc.
    func controllerFor(playerIndex: GCControllerPlayerIndex) -> GCController?
}
