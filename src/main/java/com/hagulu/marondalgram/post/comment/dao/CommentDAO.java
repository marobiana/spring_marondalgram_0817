package com.hagulu.marondalgram.post.comment.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentDAO {
	
	public int insertComment(@Param("userId") int userId
			, @Param("postId") int postId
			, @Param("userName") String userName
			, @Param("content") String content);
	

}


public class PostWithComment {
	private Post post;
	private List<Comment> commentList;
	
	
}

PostWithComment postComment = new PostWithComment();
postComment.setPost(post);
postComent.setCommentList(commentlist);

list.add(postComment);



