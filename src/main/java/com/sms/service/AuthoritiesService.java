package com.sms.service;

import com.sms.dao.IAuthoritiesDAO;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

/**
 * Created by songpo on 2014/3/21.
 */
@Service
public class AuthoritiesService {

    @Resource
    private IAuthoritiesDAO authoritiesDAO;

}
