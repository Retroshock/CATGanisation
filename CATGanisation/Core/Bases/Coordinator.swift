//
//  Coordinator.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 12.09.2021.
//

import RxCocoa
import RxSwift
import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set }
    var disposeBag: DisposeBag { get }
    var navigationController: UINavigationController { get }
    var endFlow: (() -> Void)? { get }
    func start()
    func finishedChildFlow(flow: Coordinator)
    func addChildCoordinator(_ coordinator: Coordinator)

    init(navigationController: UINavigationController)
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        children.append(coordinator)
        coordinator.navigationController.rx.deallocating.subscribe { [weak self] _ in
            self?.finishedChildFlow(flow: coordinator)
        }.disposed(by: disposeBag)
    }
}
