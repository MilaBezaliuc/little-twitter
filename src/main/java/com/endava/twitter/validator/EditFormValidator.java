package com.endava.twitter.validator;

import com.endava.twitter.model.User;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class EditFormValidator implements Validator {

    @Override
    public boolean supports(Class<?> aClass) {
        return User.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {
        User user = (User) o;

//        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username", "Required");
//        if (user.getUsername().length() < 4 || user.getUsername().length() > 16) {
//            errors.rejectValue("username", "Size.user.username");
//        }

        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "first_name", "Required");
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "last_name", "Required");

//        ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "Required");
//        if (user.getPassword().length() < 6 || user.getPassword().length() > 32) {
//            errors.rejectValue("password", "Size.user.password");
//        }
//
//        if (!user.getConfirmPassword().equals(user.getPassword())) {
//            errors.rejectValue("confirmPassword", "Different.user.password");
//        }
    }
}
