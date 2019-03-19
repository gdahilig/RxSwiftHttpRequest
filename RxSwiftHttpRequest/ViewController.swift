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
        let tranactionId = 23452345
        getTransationDetail(id: tranactionId).subscribe(
            onSuccess: { [weak self] id in
                self?.showMessage("Download succeeded.")
            },
            onError: { [weak self] error in
                self?.showMessage("Error", description: error.localizedDescription)
        })
        .disposed(by: bag)
    }
    
    func getTransationDetail(id: Int) -> Single<String> {
     
        return  Single.create(subscribe: { observer in
            // create a url
            let url = URL(string: "http://www.stackoverflow.com")
            
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
