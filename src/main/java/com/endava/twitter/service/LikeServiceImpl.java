package com.endava.twitter.service;

import com.endava.twitter.dao.LikeDaoImpl;
import com.endava.twitter.model.Like;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by mbezaliuc on 11/24/2016.
 */

@Service
@Transactional
public class LikeServiceImpl {

    @Autowired
    private LikeDaoImpl likeDao;

    public Like addLike(Like like) {
        return likeDao.addLike(like);
    }
}
