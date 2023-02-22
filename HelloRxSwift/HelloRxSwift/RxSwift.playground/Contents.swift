import UIKit
import RxSwift
import RxCocoa

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

//Mark:- Publish Subject Example
let subject = PublishSubject<String>()
subject.onNext("Issue 1")
subject.subscribe{ event in
    print(event)
    
}
subject.onNext("Issue 2")
subject.onNext("Issue 3")
subject.dispose()
//subject.onCompleted()
subject.onNext("Issue 4")

//Mark:- Behaviour Subject
let subjectB = BehaviorSubject<String>(value: "Initial Value")

subjectB.onNext("Last Issue")
subjectB.subscribe{ event in
    print(event)
}

subjectB.onNext("Issue 1")
subjectB.onCompleted()
subjectB.dispose()


//Mark:- Relay Subject
print("*****************************")
let subjectR = ReplaySubject<String>.create(bufferSize: 2)
subjectR.onNext("Issue 1")
subjectR.onNext("Issue 2")
subjectR.onNext("Issue 3")
subjectR.subscribe{
    print($0)
}
print("****")
subjectR.onNext("Issue 4")
subjectR.onNext("Issue 5")
subjectR.onNext("Issue 6")
subjectR.subscribe{ event in
    if let element = event.element
    {
        print(element)
    }
}

//Mark:- Variable Subject
let subjectV = Variable([String]())
subjectV.value.append("Item 1")
subjectV.asObservable().subscribe{
    print($0)
}
subjectV.value.append("Item 2")
//Variable` is planned for future deprecation. Please consider `BehaviorRelay` as a replacement.


//Mark:- Behavior Relay
let relay = BehaviorRelay(value: ["Item 1"])
relay.accept(relay.value + ["Item 2"])
relay.asObservable().subscribe{
    print($0)
}.dispose()
print("**************")

// another exsmple
let relay2 = BehaviorRelay(value: ["Item 1"])
var value1 = relay2.value
value1.append("Item 2")
value1.append("Item 3")
value1.append("Item 4")
relay2.accept(value1)
relay2.asObservable().subscribe{
    print($0)
}
