package com.sms.service;

import com.sms.dao.IUsersDao;
import com.sms.model.Users;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

/**
 * Created by songpo on 2014/3/21.
 */
@Service
public class UsersService {

    @Resource
    private IUsersDao usersDao;


    public Users findByUsername(String username) {
        return usersDao.findByUsername(username);
    }
}
