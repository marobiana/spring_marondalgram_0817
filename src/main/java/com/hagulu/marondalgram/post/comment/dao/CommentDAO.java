package com.hagulu.marondalgram.post.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.hagulu.marondalgram.post.comment.model.Comment;

@Repository
public interface CommentDAO {
	
	public int insertComment(@Param("userId") int userId
			, @Param("postId") int postId
			, @Param("userName") String userName
			, @Param("content") String content);
	
	public List<Comment> selectCommentByPostId(
			@Param("postId") int postId);
	
}


