// Copyright 2021 Bob
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Codable
import Foundation

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
