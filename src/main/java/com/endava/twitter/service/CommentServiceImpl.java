package com.endava.twitter.service;

import com.endava.twitter.dao.CommentDaoImpl;
import com.endava.twitter.model.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by acusnir on 11/4/2016.
 */
@Service
@Transactional
public class CommentServiceImpl {

    @Autowired
    CommentDaoImpl commentDao;

    public Comment addComment(Comment comment){
       return commentDao.addComment(comment);

    }

    public void updateComment(Comment comment){
        commentDao.updateComment(comment);
    }

    public Comment deleteComment(Comment comment){
      return commentDao.deleteComment(comment);
    }

    public Comment getCommentById(int id){
        return commentDao.getCommentById(id);
    }

}
