import GameController

class MockGCPhysicalInputProfile: GCPhysicalInputProfile {
    private let mockClass: AnyClass

    init(mockClass: AnyClass) {
        self.mockClass = mockClass
        super.init()
    }

    override func isKind(of aClass: AnyClass) -> Bool {
        return aClass == mockClass
    }
}
