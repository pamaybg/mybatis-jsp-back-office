package com.icignal.common.excel.annotations;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Documented
@Retention(RUNTIME)
@Target(TYPE)
public @interface ExcelHeader {

    int startLineNum() default -1;

    boolean useHeader() default true;

    ExcelMergeCells[] mergeCellsList() default {};

    ExcelField[] fields() default {};

}