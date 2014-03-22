package com.sms.controller;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import java.util.List;

/**
 * Created by songpo on 2014/3/21.
 */
@RestController
public class HomeController {

//    @RequestMapping(value = "/home")
//    public ModelAndView home()
//    {
//        ModelAndView mav = new ModelAndView("login/login");
//        Object authorities = SecurityContextHolder.getContext().getAuthentication().getAuthorities();
//        if(authorities != null)
//        {
//            for(GrantedAuthority authority : (List<GrantedAuthority>)authorities)
//            {
//                if(authority.getAuthority().equals("ROLE_ADMIN"))
//                {
//                    mav.setViewName("/home/admin");
//                }
//                else if (authority.getAuthority().equals("ROLE_WORKER"))
//                {
//                    mav.setViewName("/home/worker");
//                }
//            }
//        }
//        return mav;
//    }

}
