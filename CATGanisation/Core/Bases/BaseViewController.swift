//
//  BaseViewController.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 12.09.2021.
//

import RxSwift
import UIKit

class BaseViewController<ViewModel: BaseViewModel>: UIViewController {
    let disposeBag = DisposeBag()
    var viewModel: ViewModel!
    weak var coordinatorProtocol: Coordinator?
}
