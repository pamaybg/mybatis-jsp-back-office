package com.icignal.marketing.contents.dto.response;

public class MktPersnalFileResDto {
    
    private String id;               //아이디
    private String createBy;         //생성자
    private String modifyBy;         //수정자
    private String createDate;       //생성일시
    private String modifyDate;       //수정일시
    private String flag;             //삭제여부
    private String country;          //국가
    private String lang;             //언어
    private String currency;         //통화
    private String appServiceType;   //APP 서비스 ID
    private String type;             //유형
    private String filePath;         //파일경로
    private String fileName;         //파일명
    private String fileType;         //파일유형
    private String fileSize;         //파일크기
    private String oriFileName;      //원본파일명
    private String seq;              //순서
    private String parentId;         //상위아이디
    private String description;      //비고
    
    private Integer dataCnt;          //건수
    
    public Integer getDataCnt() {
        return dataCnt;
    }
    public void setDataCnt(Integer dataCnt) {
        this.dataCnt = dataCnt;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getCreateBy() {
        return createBy;
    }
    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }
    public String getModifyBy() {
        return modifyBy;
    }
    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }
    public String getCreateDate() {
        return createDate;
    }
    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }
    public String getModifyDate() {
        return modifyDate;
    }
    public void setModifyDate(String modifyDate) {
        this.modifyDate = modifyDate;
    }
    public String getFlag() {
        return flag;
    }
    public void setFlag(String flag) {
        this.flag = flag;
    }
    public String getCountry() {
        return country;
    }
    public void setCountry(String country) {
        this.country = country;
    }
    public String getLang() {
        return lang;
    }
    public void setLang(String lang) {
        this.lang = lang;
    }
    public String getCurrency() {
        return currency;
    }
    public void setCurrency(String currency) {
        this.currency = currency;
    }
    public String getAppServiceType() {
        return appServiceType;
    }
    public void setAppServiceType(String appServiceType) {
        this.appServiceType = appServiceType;
    }
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
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
    public String getFileType() {
        return fileType;
    }
    public void setFileType(String fileType) {
        this.fileType = fileType;
    }
    public String getFileSize() {
        return fileSize;
    }
    public void setFileSize(String fileSize) {
        this.fileSize = fileSize;
    }
    public String getOriFileName() {
        return oriFileName;
    }
    public void setOriFileName(String oriFileName) {
        this.oriFileName = oriFileName;
    }
    public String getSeq() {
        return seq;
    }
    public void setSeq(String seq) {
        this.seq = seq;
    }
    public String getParentId() {
        return parentId;
    }
    public void setParentId(String parentId) {
        this.parentId = parentId;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    
}
