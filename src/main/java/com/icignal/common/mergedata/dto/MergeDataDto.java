package com.icignal.common.mergedata.dto;

public class MergeDataDto {
    private String key;
    private String value;
    private Integer startRow;
    private Integer startCol;

    private Integer endRow = 0;
    private Integer endCol = 0;

    public MergeDataDto(String key, String value, Integer startRow, Integer startCol) {
        this.key = key;
        this.value = value;
        this.startRow = startRow;
        this.startCol = startCol;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Integer getStartRow() {
        return startRow;
    }

    public void setStartRow(Integer startRow) {
        this.startRow = startRow;
    }

    public Integer getEndRow() {
        return endRow;
    }

    public void setEndRow(Integer endRow) {
        this.endRow = endRow;
    }

    public Integer getStartCol() {
        return startCol;
    }

    public void setStartCol(Integer startCol) {
        this.startCol = startCol;
    }

    public Integer getEndCol() {
        return endCol;
    }

    public void setEndCol(Integer endCol) {
        this.endCol = endCol;
    }

    public void addEndCol() {
        this.endCol++;
    }

    public void addEndRow() {
        this.endRow++;
    }
}