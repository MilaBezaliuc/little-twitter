package com.endava.twitter.controller;

import com.endava.twitter.model.User;
import com.endava.twitter.service.UserServiceImpl;
import com.endava.twitter.validator.UserValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by MAD-TEAM on 11/1/2016.
 */

@Controller
public class LoginController {

    @Autowired
    @Qualifier("userDetailsService")
    private UserDetailsService userDetailsService;

    @Autowired
    @Qualifier("userServiceImpl")
    UserServiceImpl userService;

    @Autowired
    UserValidator userValidator;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String loginPage() {
        return "redirect:/tweet";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "login";
    }

    @RequestMapping(value = "/login/badcredentials")
    public String errorLogin(Model model) {
        model.addAttribute("errormsg", "Invalid credentials. Try again");
        return "login";
    }

    @RequestMapping(value="/logout", method = RequestMethod.GET)
    public String logoutPage (HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        for (Cookie cookie : request.getCookies())
        {
            System.out.println(cookie.getName());
            if (cookie.getName().equals("remember-me")) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }
        if (auth != null){
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/login?logout";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("user", new User());
        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("user") User user, BindingResult bindingResult, Model model) {
        userValidator.validate(user, bindingResult);
        if (bindingResult.hasErrors()) {
            return "registration";
        }
        userService.addUser(user);
        userService.autologin(user);
        return "redirect:tweet";
    }

    @RequestMapping(value = "/ajax", method = RequestMethod.GET)
    public String carousel(Model model){
        return "ajax";
    }


}
