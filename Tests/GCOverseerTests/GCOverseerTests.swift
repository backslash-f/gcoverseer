import Testing
@testable import GCOverseer

@Test("No controllers by default") func initialState() {
    let overseer = GCOverseer()
    #expect(!overseer.isGameControllerConnected)
}

@Test("isLogging is enabled by default") func isLoggingEnabled() {
    let overseer = GCOverseer()
    #expect(overseer.isLoggingEnabled)
}
