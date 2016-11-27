package com.endava.twitter.service;

import com.endava.twitter.dao.UserDaoImpl;
import com.endava.twitter.model.User;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/dispatcher-servlet.xml")
@Service
@Transactional
public class UserServiceImplTest {

    @Autowired
    UserDaoImpl userDao;

    @Test
    @Rollback(false)
    public void testAddUser() throws Exception {
        User user = new User();
//        user.setId(1000);
        user.setUsername("Vova");
        user.setFirst_name("V");
        user.setPassword("123456");
        user.setEmail("vova@gmail.com");
        userDao.addUser(user);
        Assert.assertNotNull(userDao.findByUsername("Vova"));
    }

    @Test
    @Rollback(false)
    public void testUpdateUser() throws Exception {
        User updated = userDao.findByUsername("Vova");
        updated.setFirst_name("Vovan");
        userDao.updateUser(updated);

        Assert.assertEquals(updated, userDao.findByUsername("Vova"));
    }

    @Test
    @Rollback(false)
    public void testDeleteUser() throws Exception {
        userDao.deleteUser(userDao.findByUsername("Vova"));
        Assert.assertNull(userDao.findByUsername("Vova"));
    }

    @Test
    public void testGetUserById() throws Exception {

    }

    @Test
    public void testGetUserByName() throws Exception {

    }

    @Test
    public void testGetIdByName() throws Exception {

    }

    @Test
    public void testGetAllUsers() throws Exception {

    }

    @Test
    public void testGetUsersIFollow() throws Exception {

    }

    @Test
    public void testGetUsersIFollow1() throws Exception {

    }

    @Test
    public void testGetFollowersOffers() throws Exception {

    }

    @Test
    public void testRemoveUserFromUsersIFollow() throws Exception {

    }

    @Test
    public void testAddUserToFollower() throws Exception {

    }

    @Test
    public void testGetAllUsersTweets() throws Exception {

    }

    @Test
    public void testGetAllTweetsOfUsersIFollow() throws Exception {

    }

    @Test
    public void testAllTweetsToShow() throws Exception {

    }

    @Test
    public void testAllTweetsToShow1() throws Exception {

    }

    @Test
    public void testSort() throws Exception {

    }

    @Test
    public void testListOfEmails() throws Exception {

    }

    @Test
    public void testListOfUsernames() throws Exception {

    }

    @Test
    public void testListOfPasswords() throws Exception {

    }

    @Test
    public void testGetUsersWhoFollowMe() throws Exception {

    }

    @Test
    public void testGetUsersWhoFollowMe1() throws Exception {

    }

    @Test
    public void testGetPrincipal() throws Exception {

    }

    @Test
    public void testAutologin() throws Exception {

    }
}