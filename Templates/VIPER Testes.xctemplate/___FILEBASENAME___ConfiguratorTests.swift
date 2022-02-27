import TestUtils
import XCTest
@testable import ___VARIABLE_sdkName___

final class ___VARIABLE_moduleName___ConfiguratorTests: XCTestCase {
        
    private let sut = ___VARIABLE_moduleName___Configurator()

    func test_createModule() throws {
        let viewController = sut.createModule()
        
        XCTAssertTrue(viewController is ___VARIABLE_moduleName___ViewController)
        let viewControllerMirrored = Mirror(reflecting: viewController)
        let presenter = try XCTUnwrap(viewControllerMirrored.firstChild(of: ___VARIABLE_moduleName___Presenter.self))
        let presenterMirrored = Mirror(reflecting: presenter)
        XCTAssertNotNil(presenterMirrored.firstChild(of: ___VARIABLE_moduleName___RouterProtocol.self))
        XCTAssertNotNil(presenter.viewController)
        let interactor = try XCTUnwrap(presenterMirrored.firstChild(of: ___VARIABLE_moduleName___Interactor.self))
        XCTAssertNotNil(interactor.output)
    }
}
