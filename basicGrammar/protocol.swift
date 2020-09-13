protocol SomeProtocol {
    var computedA: String { get }
    func methodA(_ str: String)
    func methodB(a: Int, b: Int) -> Int
}

class someClass {}

extension someClass: SomeProtocol {
    var computedA: String {
        return "a"
    }

    func methodA(_ str: String) {
        print(str)
    }

    func methodB(a: Int, b: Int) -> Int {
        return a+b
    }
}

var test: SomeProtocol
print(test)
