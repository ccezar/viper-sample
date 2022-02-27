import SnapshotTesting
import XCTest
@testable import ___VARIABLE_sdkName___

final class ___VARIABLE_moduleName___ViewControllerSnapshotTests: XCTestCase {
    private lazy var sut = ___VARIABLE_moduleName___ViewController(presenter: ___VARIABLE_moduleName___PresenterInputProtocolDummy())

    override func setUp() {
        super.setUp()
        SnapshotTesting.isRecording = true
    }

    func test_loadingState() {
        
    }
}