import GameController

class MockGCMotion: GCMotion {
    private var mockController: GCController?

    override var controller: GCController? {
        return mockController
    }

    init(controller: GCController? = nil) {
        self.mockController = controller
        super.init()
    }
}
