# Codable

[![Swift Package Manager](https://img.shields.io/badge/swift%20package%20manager-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![Release](https://img.shields.io/github/v/release/DanboDuan/Codable)](https://github.com/DanboDuan/Codable/releases)
[![License](https://img.shields.io/github/license/DanboDuan/Codable)](https://github.com/DanboDuan/Codable/blob/main/LICENSE)

Default Value propertyWrapper for Codable Value

## Installation

### Swift Package Manager

Add the dependency in your `Package.swift` file:

```swift
let package = Package(
    name: "myproject",
    dependencies: [
        .package(url: "git@github.com:DanboDuan/Codable.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "myproject",
            dependencies: ["Codable"]),
        ]
)
```

## Usage

see Example code

- Supprt basic type, `Int64`, `Bool`, `Double`
- Support basic collection, `String`, `Array`, `Set`, `Dictionary`
- Support custom type extended to `Codable & Equatable & DefaultValue`

```swift
import Codable

struct Car: Codable, Equatable, DefaultValue {
    @Default<Empty>
    public var name: String

    @Default<EmptyValue>
    public var age: Int64

    public init() {}

    public static func == (left: Self, right: Self) -> Bool {
        return left.name == right.name
    }
}

struct Pet: Codable, Equatable, DefaultValue {
    @Default<Empty>
    public var name: String

    @Default<Int64>
    public var age: Int64

    public init() {}

    public static func == (left: Self, right: Self) -> Bool {
        return left.name == right.name
    }
}

struct Person: Codable, Equatable, DefaultValue {
    @Default<Empty>
    public var name: String

    @Default<EmptyDictionary>
    public var cars: [String: Car]

    @Default<Empty>
    public var pets: [Pet]

    public init() {}

    public static func == (left: Self, right: Self) -> Bool {
        return left.name == right.name
    }
}

struct RequestPayload: Codable {
    @Default<Empty>
    public var method: String
    @Default<EmptyValue>
    public var payload: Person
}

var json: String = ""
json = """
{
    "payload": {
        "name":"bob",
        "pets":[
            {
                "name":"Snoopy"
            }
        ],
        "cars":{
            "first_car":{
                "name":"Tesla",
                "age":1
            },
            "second_car":{
            }
        }
    }
}
"""
if let data = json.data(using: .utf8),
   let requestPayload = try? JSONDecoder().decode(RequestPayload.self, from: data)
{
    if let pet = requestPayload.payload.pets.first {
        print("pet:", pet.name, pet.age)
    }
    if let car = requestPayload.payload.cars["second_car"] {
        print("second_car:", car.name, car.age)
    }
}
```

## Contributing

1. Git clone the repository `git@github.com:DanboDuan/Codable.git`.
2. Open `Package.swift`.

## License

Codable is released under the Apache License license. [See LICENSE](https://github.com/DanboDuan/Codable/blob/main/LICENSE) for details.
