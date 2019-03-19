# RxSwiftHttpRequest
Simple http request done using RxSwift/RxCocoa


Class: ViewController
Method: performHttpRequest(address: String)

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
