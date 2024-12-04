import GameController

class MockGCController: GCController {
    private let mockPhysicalInputProfile: GCPhysicalInputProfile
    private let mockMotion: GCMotion?
    private var mockPlayerIndex: GCControllerPlayerIndex

    override var physicalInputProfile: GCPhysicalInputProfile {
        return mockPhysicalInputProfile
    }

    override var motion: GCMotion? {
        return mockMotion
    }

    override var playerIndex: GCControllerPlayerIndex {
        get { return mockPlayerIndex }
        set { mockPlayerIndex = newValue }
    }

    init(
        physicalInputProfile: GCPhysicalInputProfile,
        motion: GCMotion? = nil,
        playerIndex: GCControllerPlayerIndex = .indexUnset
    ) {
        self.mockPhysicalInputProfile = physicalInputProfile
        self.mockMotion = motion
        self.mockPlayerIndex = playerIndex
        super.init()
    }
}
