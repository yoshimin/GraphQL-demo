package com.example.demo.resolver

import com.example.demo.DuplicateException
import com.example.demo.repository.UserMapper
import com.example.demo.repository.entity.PreOrderEntity
import com.example.demo.repository.entity.UserEntity
import com.example.demo.type.PreOrder
import com.example.demo.type.User
import graphql.kickstart.tools.GraphQLMutationResolver
import org.springframework.dao.DuplicateKeyException
import org.springframework.stereotype.Component

@Component
class UserMutationResolver(private val mapper: UserMapper): GraphQLMutationResolver {
    fun registerUser(name: String, email: String): User {
        try {
            val entity = UserEntity(name = name, email = email)
            mapper.insert(entity)
            return User(entity.id!!, name, email)
        } catch (e: DuplicateKeyException) {
            throw DuplicateException()
        }
    }

    fun preOrder(userId: Long, bookId: Long): PreOrder {
        try {
            val entity = PreOrderEntity(userId = userId, bookId = userId)
            mapper.preOrder(entity)
            return PreOrder(entity.id!!, userId, bookId)
        } catch (e: DuplicateKeyException) {
            throw DuplicateException()
        }
    }
}
