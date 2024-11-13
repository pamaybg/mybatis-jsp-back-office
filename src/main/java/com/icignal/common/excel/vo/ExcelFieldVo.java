package com.icignal.common.excel.vo;

import com.icignal.common.excel.annotations.ExcelField;

import java.lang.reflect.Field;

public class ExcelFieldVo {
    private String headerKey;
    private String headerName;
    private Integer index;
    private Class<?> cellType;
    private Field field;
    private String styleName;
    private Boolean isSequence = false;

    public ExcelFieldVo(String headerKey, String headerName) {
        this.headerKey = headerKey;
        this.headerName = headerName;
    }

    public ExcelFieldVo(String headerKey, String headerName, int index) {
        this.headerKey = headerKey;
        this.headerName = headerName;
        this.index = index;
    }

    public ExcelFieldVo(ExcelField annotation, int index) {
        this(null, annotation, index);
    }

    public ExcelFieldVo(Field field, ExcelField annotation, int index) {
        this(field != null ? field.getName() : annotation.headerKey(), annotation.headerName());

        this.field = field;
        this.cellType = annotation.cellType();
        this.styleName = annotation.styleName();
        this.isSequence = annotation.isSequence();

        int _index = annotation.index();
        this.index = _index != -1 ? _index : index;
    }

    public ExcelFieldVo(ExcelFieldVo fieldVo, int index) {
        this(fieldVo.getHeaderKey(), fieldVo.getHeaderName(), index);

        this.cellType = fieldVo.getCellType();
        this.styleName = fieldVo.getStyleName();
        this.isSequence = fieldVo.getSequence();
    }

    public String getHeaderKey() {
        return headerKey;
    }

    public void setHeaderKey(String headerKey) {
        this.headerKey = headerKey;
    }

    public String getHeaderName() {
        return headerName;
    }

    public void setHeaderName(String headerName) {
        this.headerName = headerName;
    }

    public Integer getIndex() {
        return index;
    }

    public void setIndex(Integer index) {
        this.index = index;
    }

    public Class<?> getCellType() {
        return cellType;
    }

    public void setCellType(Class<?> cellType) {
        this.cellType = cellType;
    }

    public Field getField() {
        return field;
    }

    public void setField(Field field) {
        this.field = field;
    }

    public String getStyleName() {
        return styleName;
    }

    public void setStyleName(String styleName) {
        this.styleName = styleName;
    }

    public Boolean getSequence() {
        return isSequence;
    }

    public void setSequence(Boolean sequence) {
        isSequence = sequence;
    }
}