package com.icignal.core.database.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.BaseReqDto;

/**
 * @name : infavor.base.DB.dto.MKTDBInfoDTO.java
 * @date : 2015. 11. 12.
 * @author : 류동균
 * @description : DB정보
 */
public class MKTDBInfoDTO extends BaseReqDto {
    
    private String dbCode;
    private String dbType;
    private String driverClassName;
    private String url;
    private String userName;
    private String password;
    private String dbFlag = "";	// Y : 새로운 컨넥션 
    private String dbNm;
    private String conIp;
    private String conPort;
    private String conId;
    private String conPw;
    private String conPath;
    private int ftpPort;
    private String ftpPortType;
    private String conDbType;
    private String fileType;
    private String secretNm;
    private String dbId;
    private String serviceId;
    private String poolName;
    private String lcId;
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
    public String getDbCode() {
        return dbCode;
    }
    public void setDbCode(String dbCode) {
        this.dbCode = dbCode;
    }
    public String getDriverClassName() {
        return driverClassName;
    }
    public void setDriverClassName(String driverClassName) {
        this.driverClassName = driverClassName;
    }
    public String getUrl() {
        return url;
    }
    public void setUrl(String url) {
        this.url = url;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

	public String getDbNm() {
		return dbNm;
	}

	public void setDbNm(String dbNm) {
		this.dbNm = dbNm;
	}

	public String getConIp() {
		return conIp;
	}

	public void setConIp(String conIp) {
		this.conIp = conIp;
	}

	public String getConPort() {
		return conPort;
	}

	public void setConPort(String conPort) {
		this.conPort = conPort;
	}

	public String getConId() {
		return conId;
	}

	public void setConId(String conId) {
		this.conId = conId;
	}

	public String getConPw() {
		return conPw;
	}

	public void setConPw(String conPw) {
		this.conPw = conPw;
	}

	public String getDbFlag() {
		return dbFlag;
	}

	public void setDbFlag(String dbFlag) {
		this.dbFlag = dbFlag;
	}

	public String getConPath() {
		return conPath;
	}

	public void setConPath(String conPath) {
		this.conPath = conPath;
	}

	public int getFtpPort() {
		return ftpPort;
	}

	public void setFtpPort(int ftpPort) {
		this.ftpPort = ftpPort;
	}

    public String getConDbType() {
        return conDbType;
    }

    public void setConDbType(String conDbType) {
        this.conDbType = conDbType;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public String getFtpPortType() {
        return ftpPortType;
    }

    public void setFtpPortType(String ftpPortType) {
        this.ftpPortType = ftpPortType;
    }

	public String getDbType() {
		return dbType;
	}

	public void setDbType(String dbType) {
		this.dbType = dbType;
	}

	public String getSecretNm() {
		return secretNm;
	}

	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}

	public String getDbId() {
		return dbId;
	}

	public void setDbId(String dbId) {
		this.dbId = dbId;
	}

	public String getServiceId() {
		return serviceId;
	}

	public void setServiceId(String serviceId) {
		this.serviceId = serviceId;
	}

	public String getPoolName() {
		return poolName;
	}

	public void setPoolName(String poolName) {
		this.poolName = poolName;
	}

	public String getLcId() {
		return lcId;
	}

	public void setLcId(String lcId) {
		this.lcId = lcId;
	}
    
}
