package com.endava.twitter.service;

import com.endava.twitter.dao.UserDaoImpl;
import com.endava.twitter.model.Tweet;
import com.endava.twitter.model.User;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * Created by mbezaliuc on 11/2/2016.
 */

@Service("userServiceImpl")
@Transactional
public class UserServiceImpl {

    private static final Logger logger = Logger.getLogger(UserServiceImpl.class);

    @Autowired
    private UserDaoImpl userDao;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserDetailsService userDetailsService;

    public User addUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userDao.addUser(user);
    }

    public void updateUser(User user) {
        userDao.updateUser(user);
    }

    public User deleteUser(User user) {
        return userDao.deleteUser(user);
    }

    public User getUserById(int id) {
        return userDao.getUserById(id);
    }

    public User getUserByName(String name) {
        return userDao.findByUsername(name);
    }

    public int getIdByName(String username) {
        return userDao.getIdByName(username);
    }

    public List<User> getAllUsers() {
        return userDao.getAllUsers();
    }

    public List<User> getUsersIFollow(int follower_id) {
        return userDao.getUsersIFollow(follower_id);
    }

    public List<User> getUsersIFollow() {
        return userDao.getUsersIFollow();
    }

    public List getFollowersOffers(int limit) {
        List<User> followersOffers = getAllUsers();
        followersOffers.removeAll(getUsersIFollow());
        followersOffers.remove(getUserByName(SecurityContextHolder.getContext().getAuthentication().getName()));
        Collections.shuffle(followersOffers);
        if (limit > followersOffers.size()) limit = followersOffers.size();
        return followersOffers.subList(0, limit);

//        return userDao.getFollowersOffers(limit);
    }

    public void removeUserFromUsersIFollow(User me,
                                           String username) {
        for (User user : me.getUsersIFollow()) {
            if (user.getUsername().equals(username)) {
                me.getUsersIFollow().remove(user);
                userDao.updateUser(me);
                logger.info("User deleted from followers");
                return;
            }
        }
    }

    public void addUserToFollower(User me, User toFollow) {
        me.getUsersIFollow().add(toFollow);
        userDao.updateUser(me);
    }

    public List<Tweet> getAllUsersTweets(int id) {
        return sort(userDao.getAllUsersTweets(id));
    }

    public List<Tweet> getAllTweetsOfUsersIFollow() {
        List<Tweet> allTweetsOfUsersIFollow = new ArrayList<>();
        for (User u : getUsersIFollow()) {
            allTweetsOfUsersIFollow.addAll(u.getAllTweets());
        }
        return sort(allTweetsOfUsersIFollow);
    }

    public List<Tweet> allTweetsToShow() {
        List<Tweet> alltweets = new ArrayList<>();
        alltweets.addAll(getAllTweetsOfUsersIFollow());
        alltweets.addAll(getAllUsersTweets(getIdByName(SecurityContextHolder.getContext().getAuthentication().getName())));
        return sort(alltweets);
    }

    public List<Tweet> allTweetsToShow(int start, int size) {
        List<Tweet> list = allTweetsToShow();
        if (start + size > list.size()) return list.subList(start, list.size());
        return list.subList(start, start + size);
    }

    public List<Tweet> sort(List<Tweet> tweets) {
        Collections.sort(tweets, new Comparator<Tweet>() {
            @Override
            public int compare(Tweet o1, Tweet o2) {
                return o2.getPostDateTime().compareTo(o1.getPostDateTime());
            }
        });
        return tweets;
    }

    public List<String> listOfEmails() {
        return userDao.listOfEmails();
    }

    public List<String> listOfUsernames() {
        return userDao.listOfUsernames();
    }

    public List<String> listOfPasswords() {
        return userDao.listOfPasswords();
    }

    public List<User> getUsersWhoFollowMe() {
        return userDao.getUsersWhoFollowMe();
    }

    public List<User> getUsersWhoFollowMe(int id) {
        return userDao.getUsersWhoFollowMe(id);
    }

    public void autologin(User user) {
        if (user.getPassword() != null)
            SecurityContextHolder.getContext().setAuthentication(
                    new UsernamePasswordAuthenticationToken(
                            user.getUsername(),
                            user.getPassword(),
                            userDetailsService.loadUserByUsername(user.getUsername()).getAuthorities()));
    }

    public int isFollowed(int thisUserId, int otherUserId) {
        return userDao.isFollowed(thisUserId, otherUserId);
    }

}
