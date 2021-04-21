package com.example.demo.resolver

import com.example.demo.DuplicateException
import com.example.demo.repository.BookMapper
import com.example.demo.repository.entity.BookEntity
import com.example.demo.type.Book
import graphql.kickstart.tools.GraphQLMutationResolver
import org.springframework.dao.DuplicateKeyException
import org.springframework.stereotype.Component

@Component
class BookMutationResolver(private val mapper: BookMapper): GraphQLMutationResolver {
    fun registerBook(name: String, price: Int): Book {
        try {
            val entity = BookEntity(name = name, price = price)
            mapper.insert(entity)
            return Book(entity.id!!, name, price)
        } catch (e: DuplicateKeyException) {
            throw DuplicateException()
        }
    }
}
