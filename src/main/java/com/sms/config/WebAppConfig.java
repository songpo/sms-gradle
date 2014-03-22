package com.sms.config;

import org.springframework.orm.jpa.support.OpenEntityManagerInViewFilter;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.DelegatingFilterProxy;
import org.springframework.web.servlet.DispatcherServlet;
import ch.qos.logback.ext.spring.web.LogbackConfigListener;
import javax.servlet.*;
import java.util.EnumSet;

/**
 * Created by songpo on 14-3-17.
 */
public class WebAppConfig implements WebApplicationInitializer {
    @Override
    public void onStartup(ServletContext servletContext) throws ServletException {
        AnnotationConfigWebApplicationContext context = new AnnotationConfigWebApplicationContext();
        context.setConfigLocation("com.sms.config");

        //加入logback监听器
        servletContext.addListener(new LogbackConfigListener());

        //加入spring监听器
        servletContext.addListener(new ContextLoaderListener(context));

        EnumSet<DispatcherType> dispatcherTypes = EnumSet.of(DispatcherType.REQUEST, DispatcherType.FORWARD);

        //加入spring mvc配置
        ServletRegistration.Dynamic dispatcher = servletContext.addServlet("spring-mvc", new DispatcherServlet(context));
        dispatcher.setLoadOnStartup(1);
        dispatcher.addMapping("/");

        //加入OpenEntityManagerInViewFilter
        FilterRegistration.Dynamic openEntityManagerInViewFilter = servletContext.addFilter("openEntityManagerInViewFilter", OpenEntityManagerInViewFilter.class);
        openEntityManagerInViewFilter.addMappingForUrlPatterns(dispatcherTypes, true, "/*");

        //加入security过滤器
        FilterRegistration.Dynamic securityFilterChain = servletContext.addFilter("springSecurityFilterChain", new DelegatingFilterProxy());
        securityFilterChain.addMappingForUrlPatterns(dispatcherTypes, true, "/*");

        //加入Spring编码过滤器
        CharacterEncodingFilter characterEncodingFilter = new CharacterEncodingFilter();
        characterEncodingFilter.setEncoding("UTF-8");
        characterEncodingFilter.setForceEncoding(true);

        FilterRegistration.Dynamic encodingFilter = servletContext.addFilter("characterEncodingFilter", characterEncodingFilter);
        encodingFilter.addMappingForUrlPatterns(dispatcherTypes, true, "/");

    }

}
