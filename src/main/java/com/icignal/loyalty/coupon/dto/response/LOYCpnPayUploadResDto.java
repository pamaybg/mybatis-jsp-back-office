package com.icignal.loyalty.coupon.dto.response;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

import java.util.List;

public class LOYCpnPayUploadResDto extends MKTBaseReqDto {
    private boolean valid;
    private String uploadValidCheck;
    private boolean message;
    private Integer qty;
    private String mbrNo;
    private String rid;
    private String filePath;
    private List<LOYCpnPayUploadResDto> Array;
    private String fileName;
    private String headerRid;
    private String offerNo;

    public Integer getQty() {
        return qty;
    }

    public void setQty(Integer qty) {
        this.qty = qty;
    }

    public void setOfferNo(String offerNo) {
        this.offerNo = offerNo;
    }

    public String getOfferNo() {
        return offerNo;
    }

    public String getHeaderRid() {
        return headerRid;
    }

    public void setHeaderRid(String headerRid) {
        this.headerRid = headerRid;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public List<LOYCpnPayUploadResDto> getArray() {
        return Array;
    }

    public void setArray(List<LOYCpnPayUploadResDto> array) {
        Array = array;
    }

    public String getMbrNo() {
        return mbrNo;
    }

    public void setMbrNo(String mbrNo) {
        this.mbrNo = mbrNo;
    }

    public boolean isMessage() {
        return message;
    }

    public void setMessage(boolean message) {
        this.message = message;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }

    public String getUploadValidCheck() {
        return uploadValidCheck;
    }

    public void setUploadValidCheck(String uploadValidCheck) {
        this.uploadValidCheck = uploadValidCheck;
    }
}
