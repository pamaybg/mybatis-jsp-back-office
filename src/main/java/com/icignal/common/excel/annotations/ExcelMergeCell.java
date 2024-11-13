package com.icignal.common.excel.annotations;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.ANNOTATION_TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Documented
@Retention(RUNTIME)
@Target(ANNOTATION_TYPE)
public @interface ExcelMergeCell {

    String startReference();

    String endReference();

    int mergeRows() default 0;

    String title() default "";

}