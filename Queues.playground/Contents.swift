import UIKit
import PlaygroundSupport

class basicQueue {
    func basicSerial() {
        let label = "com.mahaeshwaridilip.serial.queue"
        let queue = DispatchQueue(label: label)
        print("\(#function) \(queue)")
        
    }
    
    
    func basicConcurrent() {
        let label = "com.mahaeshwaridilip.concurrent.queue"
        let queue = DispatchQueue(label: label, attributes: .concurrent)
        print("\(#function) \(queue)")
    }
    

    
    func basicGlobal() {
        let queue = DispatchQueue.global(qos: .userInteractive)
        print("\(#function) \(queue)")
    }
   
    
    func globalUtilityQueue() {
      let queue =  DispatchQueue.global(qos: .utility) .async { [weak self] in
            guard let self = self else { return }
            // Perform your work here
            // ...
            // Switch back to the main queue to
            // update your UI
          print("\(#function) \(Thread.current)")
          DispatchQueue.main.async {
              print("\(#function) \(Thread.current)")
          }
        }
        print("\(#function) \(queue)")
    }
    
    func workItemExample() {
        let queue = DispatchQueue(label: "com.maheshwaridilip.queue.workItems")
        let workItem = DispatchWorkItem {
            print("The block of workitems: \(queue)")
        }
        queue.async(execute: workItem)
    }
   

    func poorMansDependancy() {
        let queue = DispatchQueue(label: "com.maheshwaridilip.queue.poormansDependancy")
        let backgroundItem = DispatchWorkItem { }
        let updatedWorkItem = DispatchWorkItem { }
        backgroundItem.notify(queue: DispatchQueue.main, execute: updatedWorkItem)
        queue.async(execute: backgroundItem)
    }
    
    
    func dispatchGroupsExample() {
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        queue.async(group: group) {
            print("Start job1")
            Thread.sleep(until: Date().addingTimeInterval(10))
            print("End Job1")
        }
        
        queue.async(group: group) {
            print("Start job2")
            Thread.sleep(until: Date().addingTimeInterval(2))
            print("End Job2")
        }
        
        if group.wait(timeout: .now() + 5) == .timedOut {
            print("I got tired in waiting....")
        } else {
            print("All the jobs have completed...")
        }
    }
    
    func downloadImages() {
        print("downloadImages")
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInitiated)
        
        let base = "https://wolverine.raywenderlich.com/books/con/image-from-rawpixel-id-"
        let ids = [466881, 466910, 466925, 466931, 466978, 467028, 467032, 467042, 467052]
        var images: [UIImage] = []
        
        for id in ids {
            guard let url = URL(string: "\(base)\(id)-jpeg.jpg") else {
                continue
            }
            group.enter()
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                defer { group.leave() }
                if error == nil, let data = data, let image = UIImage(data: data) {
                    images.append(image)
                }
            }
            
            task.resume()
        }
            
        group.notify(queue: queue) {
            images[0]
        }
    }
    
    func exampleOfSemaphores() {
        let group = DispatchGroup()
        let queue = DispatchQueue.global(qos: .userInteractive)
        let semaphore = DispatchSemaphore(value: 2)
        let base = "https://wolverine.raywenderlich.com/books/con/image-from-rawpixel-id-"
        let ids = [466881, 466910, 466925, 466931, 466978, 467028, 467032, 467042, 467052]
        var images: [UIImage] = []

        
        for id in ids {
            guard let url = URL(string: "\(base)\(id)-jpeg.jpg") else {
                continue
            }
            semaphore.wait()
            group.enter()
            print("Downloading image id: \(id)")
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                defer {
                    group.leave()
                    semaphore.signal()
                }
                if error == nil, let data = data, let image = UIImage(data: data) {
                    print("Downloaded image id: \(id)")
                    images.append(image)
                }
            }
            
            task.resume()
        }
        
        group.wait()
        PlaygroundPage.current.finishExecution()

    }
}



//PlaygroundPage.current.needsIndefiniteExecution = true

//let bq = basicQueue()
//bq.basicSerial()
//bq.basicConcurrent()
//bq.basicGlobal()
//bq.globalUtilityQueue()
//bq.workItemExample()
//bq.dispatchGroupsExample()
//bq.downloadImages()
//bq.exampleOfSemaphores()

class ThreadSafeRaceCondition {
    private let threadSafeCountQueue = DispatchQueue(label: "...")
    private var _count = 0
    public var count: Int  {
        get {
            return threadSafeCountQueue.sync {
                _count
            }
        }
        set {
            threadSafeCountQueue.sync {
                _count = newValue
            }
        }
    }
    
    
}

//let th = ThreadSafeRaceCondition()
//DispatchQueue.global(qos: .userInteractive).async  {
//    th.count = 0
//}
//DispatchQueue.global(qos: .background).async {
//    th.count = 2
//}
//
//DispatchQueue.global(qos: .utility).async {
//    print(th.count)
//}

class ThreadBarrierExample {
    private let threadSafeCountQueue = DispatchQueue(label: "...", attributes: .concurrent)
    private var _count = 0
    public var count: Int {
        get {
            return threadSafeCountQueue.sync {
                return _count
            }
        }
        set {
            threadSafeCountQueue.async(flags: .barrier) { [unowned self] in
                self._count = newValue
            }
        }
    }
}

//let thb = ThreadBarrierExample()
//DispatchQueue.global(qos: .utility).async  {
//    thb.count = 0
//}
//DispatchQueue.global(qos: .utility).async {
//    thb.count = 2
//}
//
//DispatchQueue.global(qos: .utility).async {
//    print(thb.count)
//}


func priorityInversion() {
    PlaygroundPage.current.needsIndefiniteExecution = true
    let high = DispatchQueue.global(qos: .userInteractive)
    let medium = DispatchQueue.global(qos: .userInitiated)
    let low = DispatchQueue.global(qos: .background)
    
    let semaphore = DispatchSemaphore(value: 1)
    high.async {
        Thread.sleep(forTimeInterval: 2)
        semaphore.wait()
        defer { semaphore.signal() }
        print("High Priority Task is running")
    }
    
    for i in 1...10 {
        medium.async {
            let waitTime = Double(exactly: arc4random_uniform(7))!
            print("Running medium task \(i) waitTime \(waitTime)")
            Thread.sleep(forTimeInterval: waitTime)
        }
    }
    
    low.async {
        semaphore.wait()
        defer { semaphore.signal() }
        print("Running long, lowes quality Task")
        Thread.sleep(forTimeInterval: 5)
    }
}

//priorityInversion()


func operationBlocksExample() {
    let operation = BlockOperation {
        print("2 + 3 = \(2+3)")
    }
    print(operation.isReady)
    print(operation.isExecuting)
    print(operation.isCancelled)
    print(operation.isFinished)

}

//operationBlocksExample()

func multipleOperations() {
    let sentence = "Dilip is the best!"
    let wordOperations = BlockOperation()
    for word in sentence.split(separator: " ") {
        wordOperations.addExecutionBlock {
            print(word)
            sleep(2)
        }
    }
    
    wordOperations.completionBlock = {
        print("Thank you all set!!!")
    }
    
    print("Time taken: ", duration {
        wordOperations.start()
    })
}

multipleOperations()
