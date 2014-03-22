package com.sms.model;

import javax.persistence.*;

/**
 * Created by songpo on 2014/3/21.
 */
@Entity
public class Users {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    String id;
    @Column
    String username;
    @Column
    String password;
    @Column
    int enabled;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getEnabled() {
        return enabled;
    }

    public void setEnabled(int enabled) {
        this.enabled = enabled;
    }
}
