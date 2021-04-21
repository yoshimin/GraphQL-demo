package com.example.demo

import graphql.ErrorClassification
import graphql.GraphQLError
import graphql.language.SourceLocation
import org.springframework.dao.DuplicateKeyException
import org.springframework.stereotype.Component
import org.springframework.web.bind.annotation.ExceptionHandler

@Component
class DemoAppExceptionHandler {
    @ExceptionHandler(Throwable::class)
    fun handleException(e: Throwable): GraphQLError {
        return DemoAppGraphQLError(e)
    }
}

class DemoAppGraphQLError(private val e: Throwable): GraphQLError {
    override fun getMessage(): String? {
        return e.message
    }

    override fun getLocations(): List<SourceLocation>? {
        return null
    }

    override fun getErrorType(): ErrorClassification {
        return when (e) {
            is GraphQLException -> e.type
            else -> ErrorType.UNKNOWN
        }
    }

}

enum class ErrorType: ErrorClassification {
    UNKNOWN,
    INVALID_ARGUMENT,
    NOT_FOUND,
    ALREADY_EXISTS,
    OperationNotSupported,
    ExecutionAborted
}
open class GraphQLException(override val message: String?, val type: ErrorType): RuntimeException()
class NotFoundException: GraphQLException("user not found with the provided id.", ErrorType.NOT_FOUND)
class DuplicateException: GraphQLException("already exists.", ErrorType.ALREADY_EXISTS)
