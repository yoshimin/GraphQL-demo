// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class BooksQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Books($userId: ID!) {
      getAllBook {
        __typename
        id
        name
        price
      }
      getPreOrderedBooks(userId: $userId) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "Books"

  public var userId: GraphQLID

  public init(userId: GraphQLID) {
    self.userId = userId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("getAllBook", type: .nonNull(.list(.object(GetAllBook.selections)))),
        GraphQLField("getPreOrderedBooks", arguments: ["userId": GraphQLVariable("userId")], type: .nonNull(.list(.object(GetPreOrderedBook.selections)))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getAllBook: [GetAllBook?], getPreOrderedBooks: [GetPreOrderedBook?]) {
      self.init(unsafeResultMap: ["__typename": "Query", "getAllBook": getAllBook.map { (value: GetAllBook?) -> ResultMap? in value.flatMap { (value: GetAllBook) -> ResultMap in value.resultMap } }, "getPreOrderedBooks": getPreOrderedBooks.map { (value: GetPreOrderedBook?) -> ResultMap? in value.flatMap { (value: GetPreOrderedBook) -> ResultMap in value.resultMap } }])
    }

    public var getAllBook: [GetAllBook?] {
      get {
        return (resultMap["getAllBook"] as! [ResultMap?]).map { (value: ResultMap?) -> GetAllBook? in value.flatMap { (value: ResultMap) -> GetAllBook in GetAllBook(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: GetAllBook?) -> ResultMap? in value.flatMap { (value: GetAllBook) -> ResultMap in value.resultMap } }, forKey: "getAllBook")
      }
    }

    public var getPreOrderedBooks: [GetPreOrderedBook?] {
      get {
        return (resultMap["getPreOrderedBooks"] as! [ResultMap?]).map { (value: ResultMap?) -> GetPreOrderedBook? in value.flatMap { (value: ResultMap) -> GetPreOrderedBook in GetPreOrderedBook(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: GetPreOrderedBook?) -> ResultMap? in value.flatMap { (value: GetPreOrderedBook) -> ResultMap in value.resultMap } }, forKey: "getPreOrderedBooks")
      }
    }

    public struct GetAllBook: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Book"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("price", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, price: Int) {
        self.init(unsafeResultMap: ["__typename": "Book", "id": id, "name": name, "price": price])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var price: Int {
        get {
          return resultMap["price"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "price")
        }
      }
    }

    public struct GetPreOrderedBook: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Book"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID) {
        self.init(unsafeResultMap: ["__typename": "Book", "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}

public final class UserMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation User($name: String!, $email: String!) {
      registerUser(name: $name, email: $email) {
        __typename
        id
        name
      }
    }
    """

  public let operationName: String = "User"

  public var name: String
  public var email: String

  public init(name: String, email: String) {
    self.name = name
    self.email = email
  }

  public var variables: GraphQLMap? {
    return ["name": name, "email": email]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("registerUser", arguments: ["name": GraphQLVariable("name"), "email": GraphQLVariable("email")], type: .object(RegisterUser.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(registerUser: RegisterUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "registerUser": registerUser.flatMap { (value: RegisterUser) -> ResultMap in value.resultMap }])
    }

    public var registerUser: RegisterUser? {
      get {
        return (resultMap["registerUser"] as? ResultMap).flatMap { RegisterUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "registerUser")
      }
    }

    public struct RegisterUser: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["User"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String) {
        self.init(unsafeResultMap: ["__typename": "User", "id": id, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }
  }
}

public final class PreOrderMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation PreOrder($userId: ID!, $bookId: ID!) {
      preOrder(userId: $userId, bookId: $bookId) {
        __typename
        id
      }
    }
    """

  public let operationName: String = "PreOrder"

  public var userId: GraphQLID
  public var bookId: GraphQLID

  public init(userId: GraphQLID, bookId: GraphQLID) {
    self.userId = userId
    self.bookId = bookId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId, "bookId": bookId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("preOrder", arguments: ["userId": GraphQLVariable("userId"), "bookId": GraphQLVariable("bookId")], type: .object(PreOrder.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(preOrder: PreOrder? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "preOrder": preOrder.flatMap { (value: PreOrder) -> ResultMap in value.resultMap }])
    }

    public var preOrder: PreOrder? {
      get {
        return (resultMap["preOrder"] as? ResultMap).flatMap { PreOrder(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "preOrder")
      }
    }

    public struct PreOrder: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["PreOrder"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID) {
        self.init(unsafeResultMap: ["__typename": "PreOrder", "id": id])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }
    }
  }
}
