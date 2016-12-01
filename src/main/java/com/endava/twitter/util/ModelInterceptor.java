package com.endava.twitter.util;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ModelInterceptor extends HandlerInterceptorAdapter {

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {


//        User user = (User) modelAndView.getModel().get("user");
//        if (user == null) {
//            response.sendRedirect(request.getContextPath() + "/failed");
//        }


    }
}
