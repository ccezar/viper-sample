import UIKit

public final class ___VARIABLE_moduleName___Configurator {
        
    public func createModule() -> UIViewController {
        let router = ___VARIABLE_moduleName___Router()
        let network = NetworkRequestService()
        let interactor = ___VARIABLE_moduleName___Interactor(network: network)
        let presenter = ___VARIABLE_moduleName___Presenter(router: router, interactor: interactor)
        interactor.output = presenter
        let viewController = ___VARIABLE_moduleName___ViewController(presenter: presenter)
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
