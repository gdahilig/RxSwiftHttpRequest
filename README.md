# RxSwiftHttpRequest
Simple http request using RxSwift/RxCocoa


 Class: ViewController
 
 Method: performHttpRequest(address: String)

* Create an Observable that will emit either success or error.
* The Observables takes a closure that
  * creates url from the address
  * creates URL session
  * passes a closure that is called on completion of the request.  It will:
      * check if request ended in error
      * if it's an error it emits an error (see observable(.error))
      * if not an error it returns the contents of the page by emitting success (see observable(.success))
  * Start the download
3) Returns a disposable that does nothing when disposed (nothing needs to be done).
