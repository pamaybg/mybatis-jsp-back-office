package com.icignal.marketing.contents.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class MktPersnalFileUploadResDto {
    
    private String contsId;

    private String id;              //아이디
    private String fileName;        //파일명
    private String oriFileName;     //원본파일명
    private String filePath;        //파일경로
    private long fileSize;          //파일크기
    private String fileType;        //파일유형
    
    private StatusResDto fileUpload;
    private StatusResDto dataInsert;

    public MktPersnalFileUploadResDto() {
        super();
    }
            
    public MktPersnalFileUploadResDto(String id, String fileName, String oriFileName, String filePath, long fileSize, String fileType) {
        super();
        this.id = id;
        this.fileName = fileName;
        this.oriFileName = oriFileName;
        this.filePath = filePath;
        this.fileSize = fileSize;
        this.fileType = fileType;
    }

    public String getContsId() {
        return contsId;
    }

    public void setContsId(String contsId) {
        this.contsId = contsId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getOriFileName() {
        return oriFileName;
    }

    public void setOriFileName(String oriFileName) {
        this.oriFileName = oriFileName;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public long getFileSize() {
        return fileSize;
    }

    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public StatusResDto getFileUpload() {
        return fileUpload;
    }

    public void setFileUpload(StatusResDto fileUpload) {
        this.fileUpload = fileUpload;
    }

    public StatusResDto getDataInsert() {
        return dataInsert;
    }

    public void setDataInsert(StatusResDto dataInsert) {
        this.dataInsert = dataInsert;
    }

}
