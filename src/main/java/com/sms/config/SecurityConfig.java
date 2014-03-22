package com.sms.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

/**
 * Created by King on 14-3-18.
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    public void configure(WebSecurity web) throws Exception {
        web
            .ignoring()
                .antMatchers("/js/**")
                .antMatchers("/css/**")
                .antMatchers("/files/**")
                .and()
            .debug(false);
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth
            .jdbcAuthentication()
                .usersByUsernameQuery("select username,password,enabled from users where username = ?")
                .authoritiesByUsernameQuery("select username,authority from authorities where username = ?")
                .and()
            .eraseCredentials(false);
    }

    @Override
    public void configure(HttpSecurity http) throws Exception {
        http
            .authorizeRequests()
                .antMatchers("/", "/login", "logout", "/js/**", "/css/**")
                    .permitAll()
            .anyRequest()
                .authenticated();
        http
            .csrf().disable()
            .formLogin()
                .loginPage("/")
                .loginProcessingUrl("/login")
                .defaultSuccessUrl("/home")
                .failureUrl("/?login_error=true")
                .permitAll()
                .and()
            .logout()
                .logoutUrl("/logout")
                    .permitAll()
                .logoutSuccessUrl("/")
                .invalidateHttpSession(true)
                .and()
            .rememberMe();
    }

}
