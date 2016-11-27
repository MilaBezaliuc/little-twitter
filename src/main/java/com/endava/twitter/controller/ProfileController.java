package com.endava.twitter.controller;

import com.endava.twitter.model.User;
import com.endava.twitter.service.TweetServiceImpl;
import com.endava.twitter.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.ArrayList;

@Controller
@RequestMapping("user/profile")
public class ProfileController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserServiceImpl userService;

    @Autowired
    private TweetServiceImpl tweetService;

    private void init(Model model) {
        model.addAttribute("ifollow", userService.getUsersIFollow());
        model.addAttribute("followMe", userService.getUsersWhoFollowMe());
        model.addAttribute("currentUser", userService.getUserByName(getPrincipal()));
        model.addAttribute("followingOffers", userService.getFollowersOffers(5));
        model.addAttribute("avatar", User.list);
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String showCurUserProfile(Model model) {
        User user = userService.getUserByName(getPrincipal());
        model.addAttribute("usersTweets", userService.getAllUsersTweets(user.getId()));
        init(model);
        return "coolprofile";
    }

    @RequestMapping(value = "/settings", method = RequestMethod.GET)
    public String showCurUserSettings(Model model) {
        String username = getPrincipal();
        model.addAttribute("user", userService.getUserByName(username));
        User user = userService.getUserByName(username);
        model.addAttribute("ifollow", userService.getUsersIFollow());
        model.addAttribute("followMe", userService.getUsersWhoFollowMe());
        model.addAttribute("usersTweets", userService.getAllUsersTweets(user.getId()));
        model.addAttribute("currentUser", userService.getUserByName(username));
        model.addAttribute("avatar", User.list);
        return "usersettings";
    }


    @RequestMapping(value = "{username}", method = RequestMethod.GET)
    public String showProfile(Model model, @PathVariable String username) {
        User user = userService.getUserByName(username);
        model.addAttribute("usersTweets", userService.getAllUsersTweets(user.getId()));
        init(model);
        model.addAttribute("user", userService.getUserByName(username));
        model.addAttribute("ifollow_counter", userService.getUsersIFollow(userService.getIdByName(username)).size());
        model.addAttribute("followMe_counter", userService.getUsersWhoFollowMe(userService.getIdByName(username)).size());
        model.addAttribute("isFollowed", userService.isFollowed(userService.getIdByName(getPrincipal()), userService.getIdByName(username)));
        return "profile";
    }

    @RequestMapping(value = "edit", method = RequestMethod.POST)
    public String editProfile( @ModelAttribute("user") User user,BindingResult bindingResult) {
        User loggedUser = userService.getUserByName(getPrincipal());
        user.setUsersIFollow(new ArrayList<User>());
        user.setUsersIFollow(loggedUser.getUsersIFollow());
//        editFormValidator.validate(user, bindingResult);
        if (bindingResult.hasErrors()) {
            return "redirect:/user/profile/settings";
        }
        userService.updateUser(user);
        return "redirect:/user/profile/settings";
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
