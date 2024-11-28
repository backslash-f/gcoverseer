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

    @Test("Returns only DualShock controllers")
    func dualshockControllerTest() {
        // Create a mock DualShock profile
        let dualShockProfile = MockGCPhysicalInputProfile(mockClass: GCDualShockGamepad.self)
        let dualShockController = MockGCController(physicalInputProfile: dualShockProfile)

        // Create a mock non-DualShock profile
        let nonDualShockProfile = MockGCPhysicalInputProfile(mockClass: GCPhysicalInputProfile.self)
        let nonDualShockController = MockGCController(physicalInputProfile: nonDualShockProfile)

        // Initialize the overseer with mocked controllers
        let overseer = GCOverseer(controllers: [dualShockController, nonDualShockController])

        // Retrieve DualShock controllers
        let dualShockControllers = overseer.dualshockControllers()

        // Assertions
        #expect(dualShockControllers.count == 1)
        #expect(dualShockControllers.contains(dualShockController))
        #expect(!dualShockControllers.contains(nonDualShockController))
    }
}
