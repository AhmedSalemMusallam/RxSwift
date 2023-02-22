import UIKit
import RxSwift

//Mark:- Creating Obserables
let obserable1 = Observable.just(1)
let obserable2 = Observable.of(1,2,3)
let obserable3 = Observable.of([1,2,3])
let obserable4 = Observable.from([1,2,3,4])

//Mark:- Subscribing to Observables
obserable4.subscribe{ event in
    if let element = event.element
    {
        print(element)
    }
    
}

obserable4.subscribe(onNext: { element in
        print(element)
})

obserable3.subscribe{ event in
    if let element = event.element
    {
        print(element)
    }
    
}

//Mark:- disposing subscribtion to observables
let disposeBag =  DisposeBag()

Observable.of("A","B","C").subscribe{
    print($0)
}.disposed(by: disposeBag)

//Mark:- another way to create, dispose, and subscribe to an observable
Observable<String>.create{ observer in
    observer.onNext("A")
    observer.onNext("B")
    observer.onCompleted()
    observer.onNext("C")
    return Disposables.create()
}.subscribe(onNext: { print($0) }, onError: { print($0) }, onCompleted: { print("Completed") }, onDisposed: { print("Disposed") }).disposed(by: disposeBag)
