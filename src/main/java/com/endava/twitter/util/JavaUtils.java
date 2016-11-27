package com.endava.twitter.util;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

public class JavaUtils {

    public static String uploadFile(MultipartFile file) {
        String rootPath = System.getProperty("catalina.home") + File.separator + "webapps";
        String name;
        if (!file.isEmpty()) {
            try {
                byte[] bytes = file.getBytes();
                name = file.getOriginalFilename();
                File dir = new File(rootPath + File.separator + "images");
                System.out.println(dir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                File uploadedFile = new File(dir.getAbsolutePath() + File.separator + name);
                BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(uploadedFile));
                stream.write(bytes);
                stream.flush();
                stream.close();

                return name;

            } catch (Exception e) {

            }
        } else {
            return null;
        }
        return null;
    }

    public static void validateImage(MultipartFile image) throws ImageUploadException {
//        if(!image.getContentType().equals("image/jpeg")) {
//            throw new ImageUploadException("Only JPG images accepted.");
//        }
    }

    public static String getPrincipal() {
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
