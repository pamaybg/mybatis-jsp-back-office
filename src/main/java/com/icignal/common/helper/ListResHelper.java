package com.icignal.common.helper;

import java.util.List;

import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.annotation.handler.CommCodeHandler;
import com.icignal.core.annotation.handler.PersonalDataHandler;

public class ListResHelper {

    static public <T> List<T> convertAnnotationData(List<T> items, AnnotationType annotationType) {
        AnnotationType _annotationType;
        if (annotationType == null) {
            _annotationType = AnnotationType.Nothing;
        } else {
            _annotationType = annotationType;
        }

        if (items == null || items.size() == 0) return items;

        boolean isPersonalData = (_annotationType == AnnotationType.ALL || _annotationType == AnnotationType.PersonalData);
        boolean isCommonCode = (_annotationType == AnnotationType.ALL || _annotationType == AnnotationType.CommCode);

        for (T item : items) {
        	//데상트용 마스킹 처리
            //if (isPersonalData) new PersonalDataDecodeHandler<>(item);
            if (isPersonalData) new PersonalDataHandler<>(item);
            if (isCommonCode) new CommCodeHandler(item);
        }

        return items;
    }

}