package com.endava.twitter.model;

import javax.persistence.*;

/**
 * Created by mbezaliuc on 11/24/2016.
 */

@Entity
@Table(name = "likes")
public class Like {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @OneToOne
    @JoinColumn(name = "tweet_id")
    private Tweet tweet;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    public Like() {
    }

    public Like(Tweet tweet, User user) {
        this.tweet = tweet;
        this.user = user;
    }

    public Tweet getTweet() {
        return tweet;
    }

    public void setTweet(Tweet tweet) {
        this.tweet = tweet;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Like like = (Like) o;

        if (tweet != null ? !tweet.equals(like.tweet) : like.tweet != null) return false;
        return user != null ? user.equals(like.user) : like.user == null;

    }

    @Override
    public int hashCode() {
        int result = tweet != null ? tweet.hashCode() : 0;
        result = 31 * result + (user != null ? user.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Like{" +
                "tweet=" + tweet +
                ", user=" + user +
                '}';
    }
}
