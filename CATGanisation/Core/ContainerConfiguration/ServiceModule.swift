//
//  ServiceModule.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 12.09.2021.
//

import Swinject
import SwinjectAutoregistration

class ServiceModule: Assembly {
    func assemble(container: Container) {
        container.autoregister(AuthService.self, initializer: AuthService.init).inObjectScope(.container)
        container.autoregister(CatsService.self, initializer: CatsService.init).inObjectScope(.weak)
    }
}
