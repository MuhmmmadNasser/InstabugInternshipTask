//
//  ViewController.swift
//  InstabugInternshipTask
//
//  Created by Yosef Hamza on 19/04/2021.
//

import UIKit
import InstabugLogger

class ViewController: UIViewController {

    override func loadView() {
        super.loadView()
        InstabugLogger.shared.log(1, message: "Welcom Mohamed")
        InstabugLogger.shared.log(2, message: "Welcom Mahmpoud")
        InstabugLogger.shared.log(3, message: "Welcom ali")
        InstabugLogger.shared.log(4, message: "Welcom samy")
        InstabugLogger.shared.log(5, message: "Welcom omar")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        InstabugLogger.shared.fetchAllLogs()
        print("===============")
        InstabugLogger.shared.fetchAllLogs { result in
            print(result)
        }
    }
/*
    override func viewWillAppear(_ animated: Bool) {
        InstabugLogger.shared.fetchAllLogs()
    }
*/
}

