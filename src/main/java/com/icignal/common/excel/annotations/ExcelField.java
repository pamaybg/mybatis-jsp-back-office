package com.icignal.common.excel.annotations;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.ANNOTATION_TYPE;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Documented
@Retention(RUNTIME)
@Target({FIELD, ANNOTATION_TYPE})
public @interface ExcelField {

    int index() default -1;

    String headerKey() default "";

    String headerName() default "";

    String cellReference() default "";

    Class<?> cellType() default String.class;

    String styleName() default "ALIGN_L";

    boolean isSequence() default false;

    boolean isRequired() default false;

}
