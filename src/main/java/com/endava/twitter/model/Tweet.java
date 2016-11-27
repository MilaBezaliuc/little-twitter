package com.endava.twitter.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by mbezaliuc on 11/2/2016.
 */

@Entity
@Table(name = "tweet")
//@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class Tweet implements Serializable{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;  //owner of the tweet

    @Column(name = "text")
    private String text;

    @Column(name = "postDateTime")
    private LocalDateTime postDateTime;

    @Column(name="likes")
    private int likes;

    @Column(name = "image")
    private String image;

    @JsonIgnore
    @OneToMany(mappedBy = "tweet", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Comment> tweetComments = new ArrayList<>();

    public Tweet() {
    }

    public Tweet(User user, String text, LocalDateTime postDateTime) {
        this.user = user;
        this.text = text;
        this.postDateTime = postDateTime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public LocalDateTime getPostDateTime() {
        return postDateTime;
    }

    public void setPostDateTime(LocalDateTime postDateTime) {
        this.postDateTime = postDateTime;
    }

    public List<Comment> getTweetComments() {
        return tweetComments;
    }

    public void setTweetComments(List<Comment> tweetComments) {
        this.tweetComments = tweetComments;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Tweet tweet = (Tweet) o;

        if (id != tweet.id) return false;
        if (user != null ? !user.equals(tweet.user) : tweet.user != null) return false;
        if (text != null ? !text.equals(tweet.text) : tweet.text != null) return false;
        return postDateTime != null ? postDateTime.equals(tweet.postDateTime) : tweet.postDateTime == null;

    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (user != null ? user.hashCode() : 0);
        result = 31 * result + (text != null ? text.hashCode() : 0);
        result = 31 * result + (postDateTime != null ? postDateTime.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Tweet{" +
                "id=" + id +
                ", user=" + user +
                ", text='" + text + '\'' +
                ", postDateTime=" + postDateTime +
                '}';
    }
}
