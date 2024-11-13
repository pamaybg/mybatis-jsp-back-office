package com.icignal.common.tranChnl.dto;


public class TranChnlPushDto {

    //uracle
    private String deviceTypeCd;
    private String token;
    private String deviceUuid;
    private String deviceAgreYn;
    private String verNo;
    private String deviceArgeDate;

    //braze
    private String webServiceId;
    private String webServiceHost;
    private String webServicePort;
    private String webServiceAccessToken;
    private String webServiceRefreshToken;
    private String webServiceMallId;
    private String webServiceClientId;
    private String webServiceClientSecretId;
    private String webServiceSiteName;

    private String brazeRid;
    private String brazeCamNm;
    private String brazeCamApiKey;
    private String BrazeTgtChnlList;


    public String getDeviceTypeCd() {
        return deviceTypeCd;
    }

    public void setDeviceTypeCd(String deviceTypeCd) {
        this.deviceTypeCd = deviceTypeCd;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getDeviceUuid() {
        return deviceUuid;
    }

    public void setDeviceUuid(String deviceUuid) {
        this.deviceUuid = deviceUuid;
    }

    public String getDeviceAgreYn() {
        return deviceAgreYn;
    }

    public void setDeviceAgreYn(String deviceAgreYn) {
        this.deviceAgreYn = deviceAgreYn;
    }

    public String getVerNo() {
        return verNo;
    }

    public void setVerNo(String verNo) {
        this.verNo = verNo;
    }

    public String getDeviceArgeDate() {
        return deviceArgeDate;
    }

    public void setDeviceArgeDate(String deviceArgeDate) {
        this.deviceArgeDate = deviceArgeDate;
    }

    public String getWebServiceId() {
        return webServiceId;
    }

    public void setWebServiceId(String webServiceId) {
        this.webServiceId = webServiceId;
    }

    public String getWebServiceHost() {
        return webServiceHost;
    }

    public void setWebServiceHost(String webServiceHost) {
        this.webServiceHost = webServiceHost;
    }

    public String getWebServicePort() {
        return webServicePort;
    }

    public void setWebServicePort(String webServicePort) {
        this.webServicePort = webServicePort;
    }

    public String getWebServiceAccessToken() {
        return webServiceAccessToken;
    }

    public void setWebServiceAccessToken(String webServiceAccessToken) {
        this.webServiceAccessToken = webServiceAccessToken;
    }

    public String getWebServiceRefreshToken() {
        return webServiceRefreshToken;
    }

    public void setWebServiceRefreshToken(String webServiceRefreshToken) {
        this.webServiceRefreshToken = webServiceRefreshToken;
    }

    public String getWebServiceMallId() {
        return webServiceMallId;
    }

    public void setWebServiceMallId(String webServiceMallId) {
        this.webServiceMallId = webServiceMallId;
    }

    public String getWebServiceClientId() {
        return webServiceClientId;
    }

    public void setWebServiceClientId(String webServiceClientId) {
        this.webServiceClientId = webServiceClientId;
    }

    public String getWebServiceClientSecretId() {
        return webServiceClientSecretId;
    }

    public void setWebServiceClientSecretId(String webServiceClientSecretId) {
        this.webServiceClientSecretId = webServiceClientSecretId;
    }

    public String getWebServiceSiteName() {
        return webServiceSiteName;
    }

    public void setWebServiceSiteName(String webServiceSiteName) {
        this.webServiceSiteName = webServiceSiteName;
    }

    public String getBrazeRid() {
        return brazeRid;
    }

    public void setBrazeRid(String brazeRid) {
        this.brazeRid = brazeRid;
    }

    public String getBrazeCamNm() {
        return brazeCamNm;
    }

    public void setBrazeCamNm(String brazeCamNm) {
        this.brazeCamNm = brazeCamNm;
    }

    public String getBrazeCamApiKey() {
        return brazeCamApiKey;
    }

    public void setBrazeCamApiKey(String brazeCamApiKey) {
        this.brazeCamApiKey = brazeCamApiKey;
    }

    public String getBrazeTgtChnlList() {
        return BrazeTgtChnlList;
    }

    public void setBrazeTgtChnlList(String brazeTgtChnlList) {
        BrazeTgtChnlList = brazeTgtChnlList;
    }
}
