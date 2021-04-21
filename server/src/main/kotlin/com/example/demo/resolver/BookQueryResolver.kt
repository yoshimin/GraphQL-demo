package com.example.demo.resolver

import com.example.demo.NotFoundException
import com.example.demo.repository.BookMapper
import com.example.demo.type.Book
import graphql.kickstart.tools.GraphQLQueryResolver
import org.springframework.stereotype.Component

@Component
class BookQueryResolver(private val mapper: BookMapper): GraphQLQueryResolver {
    fun getBook(id: Long): Book {
        return mapper.select(id) ?: throw NotFoundException()
    }

    fun getAllBook(): List<Book> {
        return mapper.selectAll()
    }

    fun getPreOrderedBooks(userId: Long): List<Book> {
        return mapper.getPreOrderedBooks(userId)
    }
}
