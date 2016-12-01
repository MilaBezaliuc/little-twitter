package com.endava.twitter.controller;

import com.endava.twitter.model.Comment;
import com.endava.twitter.model.Tweet;
import com.endava.twitter.model.User;
import com.endava.twitter.service.CommentServiceImpl;
import com.endava.twitter.service.TweetServiceImpl;
import com.endava.twitter.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.File;
import java.time.LocalDateTime;

/**
 * Created by mbezaliuc on 11/2/2016.
 */

@Controller
@RequestMapping("tweet")
public class TweetController {

    @Autowired
    private TweetServiceImpl tweetService;

    @Autowired
    @Qualifier("userServiceImpl")
    private UserServiceImpl userService;

    @Autowired
    private CommentServiceImpl commentService;

    private void init(Model model) {
        model.addAttribute("tweet", new Tweet());
        model.addAttribute("followMe", userService.getUsersWhoFollowMe());
        model.addAttribute("myTweets", userService.getAllUsersTweets(userService.getIdByName(getPrincipal())));
        model.addAttribute("allTweets", userService.allTweetsToShow(0, 25));
        model.addAttribute("IFollow", userService.getUsersIFollow());
        model.addAttribute("followingOffers", userService.getFollowersOffers(5));
        model.addAttribute("currentUser", userService.getUserByName(getPrincipal()));
        model.addAttribute("avatar", User.list);
        model.addAttribute("maxPage", userService.allTweetsToShow().size());
        model.addAttribute("currentPage", 0);
    }

    @RequestMapping
    public String allTweets(Model model) {
        init(model);
        return "tweet";
    }

    @RequestMapping("/page={page}")
    public String allTweetsPagination(Model model, @PathVariable int page) {
        int size = 25;
        model.addAttribute("currentPage", page);
        model.addAttribute("tweet", new Tweet());
        model.addAttribute("allTweets", userService.allTweetsToShow(page * size, size));
        model.addAttribute("IFollow", userService.getUsersIFollow());
        model.addAttribute("followingOffers", userService.getFollowersOffers(5));
        model.addAttribute("currentUser", userService.getUserByName(getPrincipal()));
        model.addAttribute("maxPage", userService.allTweetsToShow().size());
        model.addAttribute("avatar", User.list);
        model.addAttribute("uploaded", new String("file:/" + System.getProperty("catalina.home") + File.separator + "webapps" + File.separator + "images" + File.separator));
        return "tweet";
    }

    @RequestMapping("/{id}")
    public String showCurrentTweet(Model model, @PathVariable int id) {
        model.addAttribute("tweet", tweetService.getTweetById(id));
        model.addAttribute("comment", new Comment());
        model.addAttribute("comments", tweetService.getComments(id));
        return "redirect:/tweet";
    }

    @RequestMapping(value = "/addtweet", method = RequestMethod.POST)
    public String addTweet(@RequestParam String text, @RequestParam String image) {
        Tweet tweet = new Tweet(userService.getUserByName(getPrincipal()), text, LocalDateTime.now());
        if (image != null && !image.isEmpty()) {
            tweet.setImage(image);
        }
        tweetService.addTweet(tweet);
        return "redirect:/tweet";
    }

    @RequestMapping(value = "/edittweet/{id}", method = RequestMethod.POST)
    public String editTweet(@PathVariable int id, @RequestParam String text) {
        Tweet tweet = tweetService.getTweetById(id);
        tweet.setText(text);
        tweetService.updateTweet(tweet);
        return "redirect:/user/profile/";
    }

//    @RequestMapping(value = "/{id}/addComment", method = RequestMethod.GET)
//    public String addCommentGet(@PathVariable int id, Model model) {
//        init(model);
////        model.addAttribute("tweet", new Tweet());
////        model.addAttribute("allTweets", userService.allTweetsToShow(0, 5));
////        model.addAttribute("IFollow", userService.getUsersIFollow());
////        model.addAttribute("followingOffers", userService.getFollowersOffers(5));
////        model.addAttribute("currentUser", userService.getUserByName(getPrincipal()));
////        model.addAttribute("avatar", User.list);
////        model.addAttribute("maxPage", userService.allTweetsToShow().size());
//        model.addAttribute("currentTweet", tweetService.getTweetById(id));
//        model.addAttribute("comments", tweetService.getComments(id));
//        return "tweet";
//    }

    @RequestMapping(value = "/addComment", method = RequestMethod.POST)
    public String addComment(@RequestParam int id, @RequestParam String text, Model model) {
        init(model);
        model.addAttribute("allComments", tweetService.getComments(id));
//        model.addAttribute("tweet", new Tweet());
//        model.addAttribute("allTweets", userService.allTweetsToShow(0, 5));
//        model.addAttribute("IFollow", userService.getUsersIFollow());
//        model.addAttribute("followingOffers", userService.getFollowersOffers(5));
//        model.addAttribute("currentUser", userService.getUserByName(getPrincipal()));
//        model.addAttribute("avatar", User.list);
//        model.addAttribute("maxPage", userService.allTweetsToShow().size());
        commentService.addComment(new Comment(userService.getUserByName(getPrincipal()), tweetService.getTweetById(id), text));
        return "redirect:/tweet";
    }

    private String getPrincipal() {
        String userName = null;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            userName = ((UserDetails) principal).getUsername();
        } else {
            userName = principal.toString();
        }
        return userName;
    }

//    @RequestMapping(value = "/{id}/addComment", method = RequestMethod.POST)
//    public String addComment(@RequestParam String text, @PathVariable int id) {
//        commentService.addComment(new Comment(userService.getUserByName(getPrincipal()), tweetService.getTweetById(id),text));
//        return "redirect:/tweet/{id}";
//    }

    @RequestMapping(value = "/deleteTweet/{id}", method = RequestMethod.GET)
    public String deleteTweet(@PathVariable int id) {
        tweetService.deleteTweet(tweetService.getTweetById(id));
        return "redirect:/user/profile/";
    }


}