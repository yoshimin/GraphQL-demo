package com.example.demo.repository

import com.example.demo.repository.entity.PreOrderEntity
import com.example.demo.repository.entity.UserEntity
import com.example.demo.type.User
import org.apache.ibatis.annotations.Insert
import org.apache.ibatis.annotations.Mapper
import org.apache.ibatis.annotations.Options
import org.apache.ibatis.annotations.Select

@Mapper
interface UserMapper {
    @Insert("""
        insert into user
            (name, email)
        value
            (#{name}, #{email})
    """)
    @Options(useGeneratedKeys = true, keyProperty = "id")
    fun insert(entity: UserEntity)

    @Select("""
        select
            *
        from
            user
        where
            id = #{id}
    """)
    fun select(id: Long): User?

    @Select("""
        select
            *
        from
            user
    """)
    fun selectAll(): List<User>

    @Select("""
        select
            user.*
        from
            pre_order left join user on pre_order.user_id = user.id
        where
            pre_order.book_id = #{userId}
    """)
    fun getApplicants(userId: Long): List<User>

    @Insert("""
        insert into pre_order 
            (user_id, book_id) 
        value
            (#{userId},#{bookId})
    """)
    @Options(useGeneratedKeys = true, keyProperty = "id")
    fun preOrder(entity: PreOrderEntity)
}
