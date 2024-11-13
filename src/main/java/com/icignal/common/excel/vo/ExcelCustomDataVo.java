package com.icignal.common.excel.vo;

public class ExcelCustomDataVo {

    private String header;
    private Object value;

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    public Object getValue() {
        return value;
    }

    public void setValue(Object value) {
        this.value = value;
    }

    public static ExcelCustomDataVoBuilder builder() {
        return new ExcelCustomDataVoBuilder();
    }

    public static final class ExcelCustomDataVoBuilder {
        private String header;
        private Object value;

        private ExcelCustomDataVoBuilder() {
        }

        public ExcelCustomDataVoBuilder header(String header) {
            this.header = header;
            return this;
        }

        public ExcelCustomDataVoBuilder value(Object value) {
            this.value = value;
            return this;
        }


        public ExcelCustomDataVo build() {
            ExcelCustomDataVo excelCustomDataVo = new ExcelCustomDataVo();
            excelCustomDataVo.setHeader(header);
            excelCustomDataVo.setValue(value);
            return excelCustomDataVo;
        }
    }
}