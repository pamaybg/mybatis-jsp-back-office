package com.icignal.common.excel.vo;

import com.icignal.common.base.dto.response.StatusResDto;
import org.apache.commons.lang3.tuple.Pair;

public class ExcelDownloadDto extends StatusResDto {

    private String filePath;
    private String fileName;

    public ExcelDownloadDto() {
    }

    public ExcelDownloadDto(boolean success, String message) {
        super(success, message);
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public void setupFileDetail(Pair<String, String> filePair) {
        this.filePath = filePair.getLeft();
        this.fileName = filePair.getRight();
    }

}