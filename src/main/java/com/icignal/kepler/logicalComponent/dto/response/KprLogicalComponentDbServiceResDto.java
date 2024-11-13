package com.icignal.kepler.logicalComponent.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentDbServiceResponseDTO
 * 2. 파일명	: KPRLogicalComponentDbServiceResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 8. 11.
 */
/**
 * <PRE>
 * 1. 설명
 *		DB 서비스 상세 조회 반응 DTO
 * </PRE>
 */ 
public class KprLogicalComponentDbServiceResDto extends StatusResDto {
	/**    아이디    */    private String  dbServiceId= "";
	/**    생성자    */    private String  createBy= "";
	/**    수정자    */    private String  modifyBy= "";
	/**    생성일시    */    private String  createDate= "";
	/**    수정일시    */    private String  modifyDate= "";
	/**    삭제여부    */    private String  flag= "";
	/**    국가코드 KR : 한국, US : 미국    */    private String  country= "";
	/**    화폐단위 KRW : 원화, USD : 달러    */    private String  currency= "";
	/**    APP 서비스 ID    */    private String  appServiceType= "";
	/**    유형    */    private String  type= "";
	/**    어카운트ID    */    private String  accountId= "";
	/**    스토어ID    */    private String  storeId= "";
	/**    서비스명    */    private String  serviceNm= "";
	/**    접속IP    */    private String  conIp= "";
	/**    접속포트    */    private String  conPort= "";
	/**    접속ID    */    private String  conId= "";
	/**    접속URL    */    private String  conUrl= "";
	/**    접속암호    */    private String  conPw= "";
	/**    접속DB유형    */    private String  conDbType= "";
	/**        */    private String  dbDesc= "";
	
	
    private String dbCode;
    private String dbType;
    private String driverClassName;
    private String url;
    private String userName;
    private String password;
    private String dbFlag = "";	// Y : 새로운 컨넥션 
    private String dbNm;
    private String conPath;
    private int ftpPort;
    private String ftpPortType;
    private String fileType;
    private String secretNm;
	private String  conDbClass="";
	
	public String getDbCode() {
		return dbCode;
	}
	public void setDbCode(String dbCode) {
		this.dbCode = dbCode;
	}
	public String getDbType() {
		return dbType;
	}
	public void setDbType(String dbType) {
		this.dbType = dbType;
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
	public String getDbFlag() {
		return dbFlag;
	}
	public void setDbFlag(String dbFlag) {
		this.dbFlag = dbFlag;
	}
	public String getDbNm() {
		return dbNm;
	}
	public void setDbNm(String dbNm) {
		this.dbNm = dbNm;
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
	public String getFtpPortType() {
		return ftpPortType;
	}
	public void setFtpPortType(String ftpPortType) {
		this.ftpPortType = ftpPortType;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getConDbClass() {
		return conDbClass;
	}
	public void setConDbClass(String conDbClass) {
		this.conDbClass = conDbClass;
	}
	public String getDbServiceId() {
		return dbServiceId;
	}
	public void setDbServiceId(String dbServiceId) {
		this.dbServiceId = dbServiceId;
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
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getServiceNm() {
		return serviceNm;
	}
	public void setServiceNm(String serviceNm) {
		this.serviceNm = serviceNm;
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
	public String getConUrl() {
		return conUrl;
	}
	public void setConUrl(String conUrl) {
		this.conUrl = conUrl;
	}
	public String getConPw() {
		return conPw;
	}
	public void setConPw(String conPw) {
		this.conPw = conPw;
	}
	public String getConDbType() {
		return conDbType;
	}
	public void setConDbType(String conDbType) {
		this.conDbType = conDbType;
	}
	public String getDbDesc() {
		return dbDesc;
	}
	public void setDbDesc(String dbDesc) {
		this.dbDesc = dbDesc;
	}
	public String getSecretNm() {
		return secretNm;
	}
	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
	
}