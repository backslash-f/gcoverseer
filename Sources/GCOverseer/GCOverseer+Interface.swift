import GameController

/// Public APIs go here.
public extension GCOverseer {

    /// Returns the controller for the player 1, player 2, etc.
    ///
    /// - Parameter playerIndex: The player number that may have a controller associated with. E.g.: `.index1`
    /// - Returns: An optional `GCController` associated with the given player number (`GCControllerPlayerIndex`).
    func controllerFor(playerIndex: GCControllerPlayerIndex) -> GCController? {
        connectedControllers.first(where: { $0.playerIndex == playerIndex })
    }
}
