//
//  ViewController.swift
//  RxSwiftHttpRequest
//
//  Created by Gene Dahilig on 3/16/19.
//  Copyright © 2019 Gene Dahilig. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let bag = DisposeBag()
    enum Errors: Error {
        case downloadFailed
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func showMessage(_ title: String, description: String? = nil) {
        alert(title: title, text: description)
            .subscribe()
            .disposed(by: bag)
    }
    
    @IBAction func pressDownload(_ sender: Any) {
        performHttpRequest(address: "http://www.stackoverflow.com").subscribe(
            onSuccess: { [weak self] id in
                self?.showMessage("Download succeeded.")
            },
            onError: { [weak self] error in
                self?.showMessage("Error", description: error.localizedDescription)
        })
        .disposed(by: bag)
    }
    
    /*
     Method: performHttpRequest(address: String)
     But it merely performs a simple request.
     
     1) Create an Observable that will emit either success or error.
     2) The Observables takes a closure that
        a) creates url from the address
        b) creates URL session
        c) passes a closure that is called on completion of the request.  It will:
            1) check if request ended in error
            2) if it's an error it emits an error (see observable(.error)
            3) if not an error it returns the contents of the page by emitting
               success (see observable(.success))
        d) Start the download
     3) Returns a disposable that does nothing when disposed (nothing needs to be done).
     
    */
    func performHttpRequest(address: String) -> Single<String> {
     
        return  Single.create(subscribe: { observer in
            // create a url
            let url = URL(string: address)
            
            // create a data task
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                
                if error != nil {
                    print("there's a problem")
                    observer(.error(error ?? Errors.downloadFailed))
                }
                else {
                    let strData = String(data: data!, encoding: String.Encoding.utf8) ?? ""
                    print(strData)
                    observer(.success(strData))
                }
            }
            
            //running the task w/ resume
            task.resume()

        return Disposables.create()
        })
      }

}

extension UIViewController {
    func alert(title: String, text: String?) -> Completable {
        return Completable.create { [weak self] completable in
            let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Close", style: .default, handler: {_ in
                completable(.completed)
            }))
            self?.present(alertVC, animated: true, completion: nil)
            return Disposables.create {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
