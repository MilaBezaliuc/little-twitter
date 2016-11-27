package com.endava.twitter.enums;

/**
 * Created by acusnir on 11/10/2016.
 */
public enum Avatars {

    NOGENDER("https://www.fernco.com/sites/default/files/default_images/icon-testimonial-user.png"),
    MAN("https://cdn2.iconfinder.com/data/icons/user/539/default-avatar.png"),
    WOMAN("https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQuw-VDkS9HCpRzy0EEpu1wpCI8EFlpnPmLT_6pIRL0f0TPnEV9"),
    NICEGUY("https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQjll0nFuEh6qrSWctPN_QyBuG7v_xtsww4xrNKzE5yrHlUp9hB"),
    BADGUY("http://www.itnetwork.cz/images/5/html/avatar.png"),
    NICEGIRL("https://www.tm-town.com/assets/default_female600x600-3702af30bd630e7b0fa62af75cd2e67c.png"),
    BADGIRL("http://www.shinyshiny.tv/Susi%20avatar-thumb-176x176.jpg");

    String url;
    Avatars(String url){
        this.url = url;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
