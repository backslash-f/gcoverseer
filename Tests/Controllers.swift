import GameController
import Testing
@testable import GCOverseer

@Suite struct Controllers {
    @Test("Returns extended gamepads")
    func extendedGamepadControllerTest() {
        // Given
        let extendedController = GCController.withExtendedGamepad()
        let microGamepadController = GCController.withMicroGamepad()

        // When
        let overseer = GCOverseer(controllers: [extendedController, microGamepadController])

        // Then
        #expect(overseer.extendedGamepadControllers().count == 1)
        #expect(overseer.extendedGamepadControllers().contains(extendedController))
    }

    @Test("Returns only DualShock controllers")
    func dualshockControllerTest() {
        // Given
        let dualShockProfile = MockGCPhysicalInputProfile(mockClass: GCDualShockGamepad.self)
        let dualShockController = MockGCController(physicalInputProfile: dualShockProfile)

        let nonDualShockProfile = MockGCPhysicalInputProfile(mockClass: GCPhysicalInputProfile.self)
        let nonDualShockController = MockGCController(physicalInputProfile: nonDualShockProfile)

        // When
        let overseer = GCOverseer(controllers: [dualShockController, nonDualShockController])
        let dualShockControllers = overseer.dualshockControllers()

        // Then
        #expect(dualShockControllers.count == 1)
        #expect(dualShockControllers.contains(dualShockController))
        #expect(!dualShockControllers.contains(nonDualShockController))
    }

    @Test("Returns only Xbox controllers")
    func xboxControllerTest() {
        // Given
        let xboxProfile = MockGCPhysicalInputProfile(mockClass: GCXboxGamepad.self)
        let xboxController = MockGCController(physicalInputProfile: xboxProfile)

        let dualShockProfile = MockGCPhysicalInputProfile(mockClass: GCDualShockGamepad.self)
        let dualShockController = MockGCController(physicalInputProfile: dualShockProfile)

        // When
        let overseer = GCOverseer(controllers: [xboxController, dualShockController])
        let xboxControllers = overseer.xboxControllers()

        // Then
        #expect(xboxControllers.count == 1)
        #expect(xboxControllers.contains(xboxController))
        #expect(!xboxControllers.contains(dualShockController))
    }

    @Test("Returns only MicroGamepad controllers")
    func microGamepadControllerTest() {
        // Given
        let microGamepadController = GCController.withMicroGamepad()

        let dualShockProfile = MockGCPhysicalInputProfile(mockClass: GCDualShockGamepad.self)
        let dualShockController = MockGCController(physicalInputProfile: dualShockProfile)

        // When
        let overseer = GCOverseer(controllers: [microGamepadController, dualShockController])
        let microGamepadControllers = overseer.microGamepadControllers()

        // Then
        #expect(microGamepadControllers.count == 1)
        #expect(microGamepadControllers.contains(microGamepadController))
        #expect(!microGamepadControllers.contains(dualShockController))
    }

    @Test("Returns only Motion controllers")
    func motionControllerTest() {
        // Given
        let motionProfile = MockGCPhysicalInputProfile(mockClass: GCMotion.self)
        let mockMotion = MockGCMotion()
        let motionController = MockGCController(physicalInputProfile: motionProfile, motion: mockMotion)

        let xboxProfile = MockGCPhysicalInputProfile(mockClass: GCXboxGamepad.self)
        let xboxController = MockGCController(physicalInputProfile: xboxProfile, motion: nil)

        // When
        let overseer = GCOverseer(controllers: [motionController, xboxController])
        let motionControllers = overseer.motionControllers()

        // Then
        #expect(motionControllers.count == 1)
        #expect(motionControllers.contains(motionController))
        #expect(!motionControllers.contains(xboxController))
    }

    @Test("Returns controller for specific player index")
    func controllerForPlayerIndexTest() {
        // Given
        let player1InputProfile = MockGCPhysicalInputProfile(mockClass: GCPhysicalInputProfile.self)
        let player1Controller = MockGCController(physicalInputProfile: player1InputProfile, playerIndex: .index1)

        let player2InputProfile = MockGCPhysicalInputProfile(mockClass: GCDualShockGamepad.self)
        let player2Controller = MockGCController(physicalInputProfile: player2InputProfile, playerIndex: .index2)

        let unsetInputProfile = MockGCPhysicalInputProfile(mockClass: GCXboxGamepad.self)
        let unsetController = MockGCController(physicalInputProfile: unsetInputProfile, playerIndex: .indexUnset)

        // When
        let overseer = GCOverseer(controllers: [player1Controller, player2Controller, unsetController])
        let controllerForPlayer1 = overseer.controllerFor(playerIndex: .index1)
        let controllerForPlayer2 = overseer.controllerFor(playerIndex: .index2)
        let controllerForUnset = overseer.controllerFor(playerIndex: .indexUnset)

        // Then
        #expect(controllerForPlayer1 === player1Controller)
        #expect(controllerForPlayer2 === player2Controller)
        #expect(controllerForUnset === unsetController)
    }
}
