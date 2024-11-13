package com.icignal.common.excel.vo;

import com.icignal.common.excel.annotations.ExcelMergeCell;
import org.apache.poi.ss.util.CellRangeAddress;

import static org.apache.poi.ss.util.CellReference.convertColStringToIndex;
import static org.apache.poi.ss.util.CellReference.convertNumToColString;

public class ExcelCellMergeVo {

    private String startReference;
    private String endReference;
    private Integer mergeRows = 0;

    private String title;

    private Integer rowNum;

    public ExcelCellMergeVo() {
    }

    public ExcelCellMergeVo(ExcelMergeCell mergeCell) {
        this.startReference = mergeCell.startReference();
        this.endReference = mergeCell.endReference();
        this.mergeRows = mergeCell.mergeRows();

        this.title = mergeCell.title();
    }

    public String getStartReference() {
        return startReference;
    }

    public void setStartReference(String startReference) {
        this.startReference = startReference;
    }

    public String getEndReference() {
        return endReference;
    }

    public void setEndReference(String endReference) {
        this.endReference = endReference;
    }

    public Integer getMergeRows() {
        return mergeRows;
    }

    public void setMergeRows(Integer mergeRows) {
        this.mergeRows = mergeRows;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getRowNum() {
        return rowNum;
    }

    public void setRowNum(Integer rowNum) {
        this.rowNum = rowNum;
    }

    public Integer convertStartReference() {
        return convertColStringToIndex(this.startReference);
    }

    public Integer convertEndReference() {
        return convertColStringToIndex(this.endReference);
    }

    public Boolean checkMergeRegion() {
        return this.mergeRows > 0 || !this.startReference.equals(this.endReference);
    }

    public CellRangeAddress convertCellRangeAddress() {
        return this.convertCellRangeAddress(this.rowNum);
    }

    public CellRangeAddress convertCellRangeAddress(int rowNumber) {
        int startReference = this.convertStartReference();
        int endReference = this.convertEndReference();

        return new CellRangeAddress(rowNumber, rowNumber + this.mergeRows, startReference, endReference);
    }

    public static Builder builder() {
        return new Builder();
    }

    public static final class Builder {
        private String startReference;
        private String endReference;
        private Integer mergeRows = 0;
        private String title;
        private Integer rowNum;

        private Builder() {
        }

        public Builder startReference(String startReference) {
            this.startReference = startReference;
            return this;
        }

        public Builder startReference(Integer startReference) {
            this.startReference = convertNumToColString(startReference);
            return this;
        }

        public Builder endReference(String endReference) {
            this.endReference = endReference;
            return this;
        }

        public Builder endReference(Integer endReference) {
            this.endReference = convertNumToColString(endReference);
            return this;
        }

        public Builder mergeRows(Integer mergeRows) {
            this.mergeRows = mergeRows;
            return this;
        }

        public Builder title(String title) {
            this.title = title;
            return this;
        }

        public Builder rowNum(Integer rowNum) {
            this.rowNum = rowNum;
            return this;
        }

        public ExcelCellMergeVo build() {
            ExcelCellMergeVo excelCellMergeVo = new ExcelCellMergeVo();
            excelCellMergeVo.setStartReference(startReference);
            excelCellMergeVo.setEndReference(endReference);
            excelCellMergeVo.setMergeRows(mergeRows);
            excelCellMergeVo.setTitle(title);
            excelCellMergeVo.setRowNum(rowNum);
            return excelCellMergeVo;
        }
    }
}