package com.endava.twitter.controller;

import com.endava.twitter.model.User;
import com.endava.twitter.service.TweetServiceImpl;
import com.endava.twitter.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by mbezaliuc on 11/2/2016.
 */

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserServiceImpl userService;

    @Autowired
    private TweetServiceImpl tweetService;

    @RequestMapping(value = "")
    public String listUsers(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("listUsers", userService.getAllUsers());
        model.addAttribute("myTweets", userService.getAllUsersTweets(userService.getIdByName(getPrincipal())));
        model.addAttribute("followMe", userService.getUsersWhoFollowMe());
        model.addAttribute("currentUser", userService.getUserByName(getPrincipal()));
        model.addAttribute("IFollow", userService.getUsersIFollow());
        return "users";
    }

    @RequestMapping(value = "delete", method = RequestMethod.GET)
    public String deleteUser() {
        User user = userService.getUserByName(getPrincipal());
        userService.deleteUser(user);
        return "redirect:/login";
    }

    @Transactional
    @RequestMapping(value = "/addfollower/{username}", method = RequestMethod.GET)
    public String addFollower(Model model, @PathVariable String username) {
        User me = userService.getUserByName(getPrincipal());
        User user = userService.getUserByName(username);
        model.addAttribute("followingOffers", userService.getFollowersOffers(3));
        model.addAttribute("isFollowed", userService.isFollowed(userService.getIdByName(getPrincipal()),
                userService.getIdByName(username)));
        userService.addUserToFollower(me, user);
        return "redirect:/tweet";
    }

    @Transactional
    @RequestMapping(value = "unfollow/{username}", method = RequestMethod.GET)
    public String unfollow(Model model, @PathVariable String username, HttpServletRequest request) {
        User me = userService.getUserByName(getPrincipal());
        model.addAttribute("isFollowed", userService.isFollowed(userService.getIdByName(getPrincipal()),
                userService.getIdByName(username)));
        userService.removeUserFromUsersIFollow(me, username);
        return "redirect:/user/profile/";
    }

    @RequestMapping(value = "/addAvatar/{avatar}", method = RequestMethod.POST)
    public String addAvatar(@PathVariable String avatar) {
        avatar = "/resources/logos/" + avatar;
        User user = userService.getUserByName(getPrincipal());
        user.setAvatar(avatar);
        userService.updateUser(user);
        return "redirect:/user/profile";
    }

    public String getPrincipal() {
        String userName = null;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            userName = ((UserDetails) principal).getUsername();
        } else {
            userName = principal.toString();
        }
        return userName;
    }

}
