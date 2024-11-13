package com.icignal.systemmanagement.outtable.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemGetWebServiceListResDto extends GridPagingItemResDto {
    private String id;
    private String createBy;
    private String host;
    private String port;
    private String accessToken;
    private String refreshToken;
    private String mallId;
    private String clientId;
    private String clientSecretId;
    private String siteName;
    private String title;


    public String getSiteName() {
        return siteName;
    }

    public void setSiteName(String siteName) {
        this.siteName = siteName;
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

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getPort() {
        return port;
    }

    public void setPort(String port) {
        this.port = port;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getRefreshToken() {
        return refreshToken;
    }

    public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }

    public String getMallId() {
        return mallId;
    }

    public void setMallId(String mallId) {
        this.mallId = mallId;
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getClientSecretId() {
        return clientSecretId;
    }

    public void setClientSecretId(String clientSecretId) {
        this.clientSecretId = clientSecretId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
