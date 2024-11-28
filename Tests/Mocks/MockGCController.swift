import GameController

class MockGCController: GCController {
    private let mockPhysicalInputProfile: GCPhysicalInputProfile

    init(physicalInputProfile: GCPhysicalInputProfile) {
        self.mockPhysicalInputProfile = physicalInputProfile
        super.init()
    }

    override var physicalInputProfile: GCPhysicalInputProfile {
        return mockPhysicalInputProfile
    }
}
