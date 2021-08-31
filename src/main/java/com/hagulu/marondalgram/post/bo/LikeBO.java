package com.hagulu.marondalgram.post.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hagulu.marondalgram.post.dao.LikeDAO;

@Service
public class LikeBO {
	
	@Autowired
	private LikeDAO likeDAO;
	
	public boolean existLike(int postId, int userId) {
		int count = likeDAO.selectCountLike(postId, userId);
		
		if(count >= 1) {
			return true;
		} else {
			return false;
		}
	}
	
	public int like(int postId, int userId) {
		return likeDAO.insertLike(postId, userId);
	}

}
