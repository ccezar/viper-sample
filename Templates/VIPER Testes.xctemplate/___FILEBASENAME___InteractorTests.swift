import NetworkCore
import XCTest
@testable import ___VARIABLE_sdkName___

final class ___VARIABLE_moduleName___InteractorTests: XCTestCase {
    private let presenterSpy = ___VARIABLE_moduleName___InteractorOutputProtocolSpy()
    private let networkSpy = NetworkRequestableSpy()
    private lazy var sut = ___VARIABLE_moduleName___Interactor(network: networkSpy)

    override func setUp() {
        super.setUp()
        sut.output = presenterSpy
    }
}