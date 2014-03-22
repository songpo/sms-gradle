package com.sms.dao;

import com.sms.model.Authorities;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by songpo on 2014/3/21.
 */
public interface IAuthoritiesDAO extends PagingAndSortingRepository<Authorities, Integer> {
}
