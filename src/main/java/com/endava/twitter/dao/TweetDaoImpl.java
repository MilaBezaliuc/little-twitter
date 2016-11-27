package com.endava.twitter.dao;

import com.endava.twitter.model.Comment;
import com.endava.twitter.model.Like;
import com.endava.twitter.model.Tweet;
import com.endava.twitter.model.User;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by mbezaliuc on 11/2/2016.
 */

@Repository
@SuppressWarnings("unchecked")
public class TweetDaoImpl {

    private static final Logger logger = Logger.getLogger(TweetDaoImpl.class);

    @Autowired
    private SessionFactory sessionFactory;

    public Tweet addTweet(Tweet tweet) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(tweet);
        logger.info("Tweet was added");

        return tweet;
    }

    public void updateTweet(Tweet tweet) {
        Session session = sessionFactory.getCurrentSession();
        session.update(tweet);
        logger.info("Tweet was updated");
    }

    public Tweet deleteTweet(Tweet tweet) {
        Session session = sessionFactory.getCurrentSession();
        if (tweet.getUser().getUsername().equals(SecurityContextHolder.getContext().getAuthentication().getName())) {
            session.delete(tweet);
            logger.info("Tweet was deleted");
        } else {
            logger.info("Couldn't delete tweet");
            return null;
        }
        return tweet;
    }

    public Tweet getTweetById(int id) {
        return (Tweet) sessionFactory.getCurrentSession()
                .createNativeQuery("SELECT * FROM tweet WHERE id=:id", Tweet.class)
                .setParameter("id", id)
                .getSingleResult();
    }

    public List<Tweet> allTweets() {
        return sessionFactory.getCurrentSession()
                .createNativeQuery("SELECT * FROM tweet ORDER BY postDateTime DESC", Tweet.class)
                .getResultList();
    }

//    public List<Tweet> allTweets(int limit, int id) {
//        return sessionFactory.getCurrentSession()
//                .createNativeQuery("SELECT TOP "+limit+" * FROM tweet WHERE id>"+id+"ORDER BY postDateTime DESC", Tweet.class)
//                .getResultList();
//    }

    public List<Comment> getComments(int tweet_id) {
        return sessionFactory.getCurrentSession()
                .createNativeQuery("SELECT * FROM comments WHERE tweet_id=:tweet_id", Comment.class)
                .setParameter("tweet_id", tweet_id)
                .getResultList();
    }

    public String tweetLikesById(int tweet_id){
       return  String.valueOf(sessionFactory.getCurrentSession()
               .createNativeQuery("SELECT count(*) FROM likes WHERE tweet_id=:tweet_id")
               .setParameter("tweet_id", tweet_id)
               .getSingleResult());
    }

    public void addLike(int tweetId){
        Tweet tweet = getTweetById(tweetId);
    }


    public List<Like> getLikes(int tweet_id) {
        return sessionFactory.getCurrentSession()
                .createNativeQuery("SELECT * FROM likes WHERE tweet_id=:tweet_id", Like.class)
                .setParameter("tweet_id", tweet_id)
                .getResultList();
    }
//    public List<Tweet> getTweetsByUserId(int user_id) {
//        return sessionFactory.getCurrentSession()
//                .createNativeQuery("SELECT * FROM from Tweet WHERE user_id=:user_id", Tweet.class)
//                .setParameter("user_id", user_id)
//                .getResultList();
//    }
}
