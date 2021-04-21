package com.example.demo.resolver

import com.example.demo.NotFoundException
import com.example.demo.type.User
import com.example.demo.repository.UserMapper
import graphql.kickstart.tools.GraphQLQueryResolver
import org.springframework.stereotype.Component

@Component
class UserQueryResolver(private val mapper: UserMapper): GraphQLQueryResolver {
    fun getUser(id: Long): User {
        return mapper.select(id) ?: throw NotFoundException()
    }

    fun getAllUser(): List<User> {
        return mapper.selectAll()
    }

    fun getApplicants(userId: Long): List<User> {
        return mapper.getApplicants(userId)
    }
}
