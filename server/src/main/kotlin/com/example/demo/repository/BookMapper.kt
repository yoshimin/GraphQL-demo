package com.example.demo.repository

import com.example.demo.repository.entity.BookEntity
import com.example.demo.type.Book
import org.apache.ibatis.annotations.Insert
import org.apache.ibatis.annotations.Mapper
import org.apache.ibatis.annotations.Options
import org.apache.ibatis.annotations.Select

@Mapper
interface BookMapper {
    @Insert("""
        insert into book
            (name, price)
        value
            (#{name}, #{price})
    """)
    @Options(useGeneratedKeys = true, keyProperty = "id")
    fun insert(entity: BookEntity)

    @Select("""
        select
            *
        from
            book
        where
            id = #{id}
    """)
    fun select(id: Long): Book?

    @Select("""
        select
            *
        from
            book
    """)
    fun selectAll(): List<Book>

    @Select("""
        select
            book.*
        from
            pre_order left join book on pre_order.book_id = book.id
        where
            pre_order.user_id = #{userId}
    """)
    fun getPreOrderedBooks(userId: Long): List<Book>
}
