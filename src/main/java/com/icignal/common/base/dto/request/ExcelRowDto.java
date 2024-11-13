package com.icignal.common.base.dto.request;

/*
 * 1. 클래스명	: ExcelRowDto
 * 2. 파일명	: ExcelRowDto.java
 * 3. 패키지명	: com.icignal.common.base.dto.request
 * 4. 작성자명	: Quintet
 * 5. 작성일자	: 2020. 4. 21.
 */
/**
 * <PRE>
 * 1. 설명
 *		jsp Grid를 이용한 엑셀 다운로드 dto
 * </PRE>
 */ 
public class ExcelRowDto {
    private String field;
    private String text;
    private int width;
    private String align;
    private int colspan;
    private int rowspan;

    public String getExcelFormat() {
        return excelFormat;
    }

    public void setExcelFormat(String excelFormat) {
        this.excelFormat = excelFormat;
    }

    private String excelFormat;

    public String getField() {
        return field;
    }

    public void setField(String field) {
        this.field = field;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public String getAlign() {
        return align;
    }

    public void setAlign(String align) {
        this.align = align;
    }

    public int getColspan() {
        return colspan;
    }

    public void setColspan(int colspan) {
        this.colspan = colspan;
    }

    public int getRowspan() {
        return rowspan;
    }

    public void setRowspan(int rowspan) {
        this.rowspan = rowspan;
    }

    @Override
    public String toString() {
        return "ExcelRowDto{" +
                "field='" + field + '\'' +
                ", text='" + text + '\'' +
                ", width=" + width +
                ", align='" + align + '\'' +
                ", colspan=" + colspan +
                ", rowspan=" + rowspan +
                ", excelFormat='" + excelFormat + '\'' +
                '}';
    }
}
