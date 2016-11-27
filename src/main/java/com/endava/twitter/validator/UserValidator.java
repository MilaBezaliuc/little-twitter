package com.endava.twitter.validator;

import com.endava.twitter.model.User;
import com.endava.twitter.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;


@Component
public class UserValidator implements Validator {

    @Autowired
    private UserServiceImpl userService;

    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "Required");
        if (user.getUsername().length() < 3 || user.getUsername().length() > 10) {
            errors.rejectValue("username", "Size.user.username");
        }

        if (userService.getUserByName(user.getUsername()) != null) {
            errors.rejectValue("username", "Duplicate.user.username");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "Required");
        if (user.getPassword().length() < 6 || user.getPassword().length() > 32) {
            errors.rejectValue("password", "Size.user.password");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "Required");
        if (!user.getEmail().matches("^[_A-Za-z0-9-]{2,}(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$")) {
            errors.rejectValue("email", "Wrong.user.email");
        }
        if (userService.listOfEmails().contains(user.getEmail())) {
            errors.rejectValue("email", "Duplicate.user.email");
        }

        if (!user.getConfirmPassword().equals(user.getPassword())) {
            errors.rejectValue("confirmPassword", "Different.user.password");
        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "first_name", "Required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "last_name", "Required");
    }
}
