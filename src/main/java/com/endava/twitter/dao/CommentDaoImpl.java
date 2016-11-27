package com.endava.twitter.dao;

import com.endava.twitter.model.Comment;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class CommentDaoImpl {

    private static final Logger logger = Logger.getLogger(CommentDaoImpl.class);

    @Autowired
    SessionFactory sessionFactory;

    public Comment addComment(Comment comment) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(comment);
        logger.info("comment added!");
        return comment;
    }

    public void updateComment(Comment comment) {
        Session session = sessionFactory.getCurrentSession();
        session.update(comment);
        logger.info("comment updated!");

    }

    public Comment deleteComment(Comment comment) {
        Session session = sessionFactory.getCurrentSession();
        session.delete(comment);
        logger.info("comment updated");
        return comment;
    }

    public Comment getCommentById(int id) {
        return (Comment) sessionFactory.getCurrentSession()
                .createNativeQuery("SELECT * FROM comments WHERE id=:id", Comment.class)
                .setParameter("id", id)
                .getSingleResult();
    }

}
