package com.sms.dao;

import com.sms.model.Users;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by songpo on 2014/3/21.
 */
public interface IUsersDao extends PagingAndSortingRepository<Users, Integer> {

    Users findByUsername(String username);
}
