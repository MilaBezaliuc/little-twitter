package com.endava.twitter.service;

import com.endava.twitter.dao.TweetDaoImpl;
import com.endava.twitter.model.Comment;
import com.endava.twitter.model.Like;
import com.endava.twitter.model.Tweet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by mbezaliuc on 11/2/2016.
 */

@Service
@Transactional
public class TweetServiceImpl {

    @Autowired
    private TweetDaoImpl tweetDao;

    public Tweet addTweet(Tweet tweet) {
        return tweetDao.addTweet(tweet);
    }

    public void updateTweet(Tweet tweet) {
        tweetDao.updateTweet(tweet);
    }

    public Tweet deleteTweet(Tweet tweet) {
       return tweetDao.deleteTweet(tweet);
    }

    public Tweet getTweetById(int id) {
        return tweetDao.getTweetById(id);
    }

    public List<Tweet> allTweets() {
        return tweetDao.allTweets();
    }

    public List<Comment> getComments(int id) {
        return tweetDao.getComments(id);
    }

    public String tweetLikesById(int tweetId){
        return tweetDao.tweetLikesById(tweetId);
    }

    public void addLike(int tweetId){
        tweetDao.addLike(tweetId);
    }

    public List<Like> getLikes(int tweet_id) {
        return tweetDao.getLikes(tweet_id);
    }

//    public List<Tweet> allTweets(int limit, int id) {
//        return tweetDao.allTweets(limit, id);
//    }

//    public List<Tweet> getTweetsByUserId(int id){
//        return tweetDao.getTweetsByUserId(id);
//    }


}
