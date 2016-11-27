package com.endava.twitter.dao;

import com.endava.twitter.model.Tweet;
import com.endava.twitter.model.User;
import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

/**
 * Created by mbezaliuc on 11/2/2016.
 */

@Repository
@SuppressWarnings(value = "unchecked")
public class UserDaoImpl {

    private static final Logger logger = Logger.getLogger(UserDaoImpl.class);

    @Autowired
    private SessionFactory sessionFactory;

    public User addUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(user);
        logger.info("User was added");
        return user;
    }

    public void updateUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        user.setUsersIFollow(user.getUsersIFollow());
        session.update(user);
        logger.info("User was updated");
    }

    public User deleteUser(User user) {
        Session session = sessionFactory.getCurrentSession();
        session.createNativeQuery("delete from followers where (followed_id=:user_id) or (follower_id=:user_id)")
                .setParameter("user_id", user.getId());
        session.delete(user);
        logger.info("User was deleted");
        return user;
    }

    public User getUserById(int id) {
        return (User) sessionFactory.getCurrentSession()
                .createNativeQuery(
                        "SELECT * FROM users WHERE id=:id", User.class)
                .setParameter("id", id)
                .uniqueResult();
    }

    public List<User> getAllUsers() {
        return sessionFactory.getCurrentSession()
                .createNativeQuery("SELECT * FROM users", User.class)
                .getResultList();
    }

    public List<Tweet> getAllUsersTweets(int user_id) {
        return sessionFactory.getCurrentSession().createNativeQuery(
                "SELECT * FROM tweet WHERE user_id=:user_id", Tweet.class)
                .setParameter("user_id", user_id)
                .getResultList();
    }

    public List<User> getUsersIFollow(int follower_id) {
        Session session = sessionFactory.getCurrentSession();
        return session.createNativeQuery(
                "SELECT u.* FROM users u " +
                        "JOIN followers f ON u.id=followed_id " +
                        "WHERE follower_id=:follower_id", User.class)
                .setParameter("follower_id", follower_id)
                .getResultList();
    }

    public List<User> getUsersWhoFollowMe(int followed_id) {
        Session session = sessionFactory.getCurrentSession();
        return session.createNativeQuery(
                "SELECT u.* FROM users u " +
                        "JOIN followers f ON u.id=follower_id " +
                        "WHERE followed_id=:followed_id", User.class)
                .setParameter("followed_id", followed_id)
                .getResultList();
    }

    public List<User> getUsersWhoFollowMe() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        return getUsersWhoFollowMe(getIdByName(username));
    }

    public List<User> getUsersIFollow() {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        return getUsersIFollow(getIdByName(username));
    }

//    TEST IN MS SQL!!!!
//    public List getFollowersOffers(int limit) {
//        Session session = sessionFactory.getCurrentSession();
//        String username = SecurityContextHolder.getContext().getAuthentication().getName();
//        int id = getIdByName(username);
//        return session.createNativeQuery(
//                "SELECT top " + limit + " * FROM USERS \n" +
//                        "WHERE id!=id\n" +
//                        "AND id not in\n" +
//                        "(SELECT followed_id FROM followers where follower_id=:id)\n" +
//                        "ORDER BY newid()", User.class)
//                .setParameter("id", id)
//                .getResultList();
//    }

    public int getIdByName(String username) {
        User user = findByUsername(username);
        return user.getId();
    }

    public User findByUsername(String username) {
        return (User) sessionFactory.getCurrentSession()
                .createNativeQuery(
                        "SELECT * FROM users " +
                                "WHERE username=:username", User.class)
                .setParameter("username", username)
                .uniqueResult();
    }

    public List<String> listOfEmails() {
        return sessionFactory.getCurrentSession()
                .createNativeQuery("select email from users")
                .list();
    }

    public List<String> listOfUsernames() {
        return sessionFactory.getCurrentSession()
                .createNativeQuery("select username from users")
                .list();
    }

    public List<String> listOfPasswords() {
        return sessionFactory.getCurrentSession()
                .createNativeQuery("select password from users")
                .list();
    }

    public int isFollowed(int thisUserId, int otherUserId) {
        return
                Integer.parseInt(String.valueOf(sessionFactory.getCurrentSession()
                        .createNativeQuery("select count(*) from followers where follower_id="
                                + thisUserId + " and followed_id=" + otherUserId)
                        .getSingleResult()));
    }

}
