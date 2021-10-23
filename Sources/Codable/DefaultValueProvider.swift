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

import Foundation

public protocol DefaultValueProvider {
    associatedtype Value: Equatable & Codable
    static var `default`: Value { get }
}

public protocol DefaultValue {
    init()
}

public enum EmptyValue<A>: DefaultValueProvider where A: Codable, A: Equatable, A: DefaultValue {
    public static var `default`: A { A() }
}

extension Int64: DefaultValueProvider {
    public static let `default` = Self()
}

extension Bool: DefaultValueProvider {
    public static let `default` = Self()
}

extension Double: DefaultValueProvider {
    public static let `default`: Double = Self()
}

extension Bool: DefaultValue {}
extension Int64: DefaultValue {}
extension Double: DefaultValue {}

public enum Empty<A>: DefaultValueProvider where A: Codable, A: Equatable, A: RangeReplaceableCollection {
    public static var `default`: A { A() }
}

public enum EmptyDictionary<K, V>: DefaultValueProvider where K: Hashable & Codable, V: Equatable & Codable {
    public static var `default`: [K: V] { Dictionary() }
}
