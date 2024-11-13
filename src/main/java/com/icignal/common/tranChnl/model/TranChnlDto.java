package com.icignal.common.tranChnl.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TranChnlDto {

    final private String sendType;
    private String subject;
    private String message;
    private String receiveMobileNo;
    private String callbackNo;
    private String sendReserveDate;
    private String registerBy;
    private String templateCode;
    private String backupType = "X";
    private String jobType;

    private Integer imageCnt = 0;
    private String imageFilePath;
    private Long imageFileSize;

    private String returnCode;
    private String returnData;
    private Integer returnSeq;
    private String authInfoDes;

    private TranChnlDto(String sendType) {
        this.sendType = sendType;
    }

    public String getSendType() {
        return sendType;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getReceiveMobileNo() {
        return receiveMobileNo;
    }

    public void setReceiveMobileNo(String receiveMobileNo) {
        this.receiveMobileNo = receiveMobileNo;
    }

    public String getCallbackNo() {
        return callbackNo;
    }

    public void setCallbackNo(String callbackNo) {
        this.callbackNo = callbackNo;
    }

    public String getSendReserveDate() {
        return sendReserveDate;
    }

    public void setSendReserveDate(String sendReserveDate) {
        this.sendReserveDate = sendReserveDate;
    }

    public void setSendReserveDate(LocalDateTime sendReserveDate) {
        this.sendReserveDate = sendReserveDate.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
    }

    public String getRegisterBy() {
        return registerBy;
    }

    public void setRegisterBy(String registerBy) {
        this.registerBy = registerBy;
    }

    public String getTemplateCode() {
        return templateCode;
    }

    public void setTemplateCode(String templateCode) {
        this.templateCode = templateCode;
    }

    public String getBackupType() {
        return backupType;
    }

    public void setBackupType(String backupType) {
        this.backupType = backupType;
    }

    public String getJobType() {
        return jobType;
    }

    public void setJobType(String jobType) {
        this.jobType = jobType;
    }

    public Integer getImageCnt() {
        return imageCnt;
    }

    public void setImageCnt(Integer imageCnt) {
        this.imageCnt = imageCnt;
    }

    public String getImageFilePath() {
        return imageFilePath;
    }

    public void setImageFilePath(String imageFilePath) {
        this.imageFilePath = imageFilePath;
    }

    public Long getImageFileSize() {
        return imageFileSize;
    }

    public void setImageFileSize(Long imageFileSize) {
        this.imageFileSize = imageFileSize;
    }

    public String getReturnCode() {
        return returnCode;
    }

    public void setReturnCode(String returnCode) {
        this.returnCode = returnCode;
    }

    public String getReturnData() {
        return returnData;
    }

    public void setReturnData(String returnData) {
        this.returnData = returnData;
    }

    public Integer getReturnSeq() {
        return returnSeq;
    }

    public void setReturnSeq(Integer returnSeq) {
        this.returnSeq = returnSeq;
    }

    public String getAuthInfoDes() {
        return authInfoDes;
    }

    public void setAuthInfoDes(String authInfoDes) {
        this.authInfoDes = authInfoDes;
    }

    static public Builder builder(String sendType) {
        return new Builder(sendType);
    }

    static public class Builder {
        final private String sendType;
        private String subject;
        private String message;
        private String receiveMobileNo;
        private String callbackNo;
        private String sendReserveDate;
        private String registerBy;
        private String templateCode;
        private String backupType = "X";
        private String jobType;
        private Integer imageCnt = 0;
        private String imageFilePath;
        private Long imageFileSize;
        private String authInfoDes;

        public Builder(String sendType) {
            this.sendType = sendType;
        }

        public Builder subject(String subject) {
            this.subject = subject;
            return this;
        }

        public Builder message(String message) {
            this.message = message;
            return this;
        }

        public Builder receiveMobileNo(String receiveMobileNo) {
            this.receiveMobileNo = receiveMobileNo;
            return this;
        }

        public Builder callbackNo(String callbackNo) {
            this.callbackNo = callbackNo;
            return this;
        }

        public Builder sendReserveDate(String sendReserveDate) {
            this.sendReserveDate = sendReserveDate;
            return this;
        }

        public Builder sendReserveDate(LocalDateTime sendReserveDate) {
            this.sendReserveDate = sendReserveDate.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
            return this;
        }

        public Builder registerBy(String registerBy) {
            this.registerBy = registerBy;
            return this;
        }

        public Builder templateCode(String templateCode) {
            this.templateCode = templateCode;
            return this;
        }

        public Builder backupType(String backupType) {
            this.backupType = backupType;
            return this;
        }

        public Builder jobType(String jobType) {
            this.jobType = jobType;
            return this;
        }

        public Builder imageCnt(Integer imageCnt) {
            this.imageCnt = imageCnt;
            return this;
        }

        public Builder imageFilePath(String imageFilePath) {
            this.imageFilePath = imageFilePath;
            return this;
        }

        public Builder imageFileSize(Long imageFileSize) {
            this.imageFileSize = imageFileSize;
            return this;
        }

        public Builder authInfoDes(String authInfoDes) {
            this.authInfoDes = authInfoDes;
            return this;
        }

        public TranChnlDto build() {
            TranChnlDto resDto = new TranChnlDto(this.sendType);
            resDto.subject = subject;
            resDto.message = message;
            resDto.receiveMobileNo = receiveMobileNo;
            resDto.callbackNo = callbackNo;
            resDto.sendReserveDate = sendReserveDate;
            resDto.registerBy = registerBy;
            resDto.templateCode = templateCode;
            resDto.backupType = backupType;
            resDto.jobType = jobType;
            resDto.imageCnt = imageCnt;
            resDto.imageFilePath = imageFilePath;
            resDto.imageFileSize = imageFileSize;
            resDto.authInfoDes = authInfoDes;

            return resDto;
        }
    }
}