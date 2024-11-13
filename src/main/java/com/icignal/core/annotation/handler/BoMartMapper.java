package com.icignal.core.annotation.handler;

import org.springframework.stereotype.Component;

import java.lang.annotation.*;

@Target({ElementType.TYPE}) 
@Retention(RetentionPolicy.RUNTIME) 
@Documented 
@Component
public @interface BoMartMapper {
}
