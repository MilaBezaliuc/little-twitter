package com.endava.twitter.dao;

import com.endava.twitter.model.Like;
import com.endava.twitter.model.Tweet;
import com.endava.twitter.model.User;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * Created by mbezaliuc on 11/24/2016.
 */

@Repository
public class LikeDaoImpl {

    private static final Logger logger = Logger.getLogger(TweetDaoImpl.class);

    @Autowired
    private SessionFactory sessionFactory;

    public Like addLike(Like like) {
        Session session = sessionFactory.getCurrentSession();
        session.save(like);
        logger.info("Like was added");

        return like;
    }
}
