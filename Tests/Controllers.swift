import GameController
import Testing
@testable import GCOverseer

@Suite struct Controllers {
    @Test("Returns extended gamepads")
    func extendedGamepadControllerTest() {
        let extendedController = GCController.withExtendedGamepad()
        let overseer = GCOverseer(controllers: [extendedController])

        #expect(overseer.extendedGamepadControllers().count == 1)
        #expect(overseer.extendedGamepadControllers().contains(extendedController))
    }
}
