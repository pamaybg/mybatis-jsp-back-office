package com.icignal.marketing.contents.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @name : MKTContentResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 개인화 속성 조회
 */
public class MktCondResDto {
	private String id;                 //아이디
	private String name;               //이름
	private String schName;            //스키마 명
	private String tblName;            //테이블 명
	private String colName;            //컬럼 명
    private String markName;           //마크네임
    private String conWhere;           //where절
    private String maxVol;             //최대 용량
    private String schEmail; 
    private String valMaxSize; 
    private String schPhone; 
    private String schMemId;
    private String conIp;  
    private String conPort; 
    private String conId; 
    private String conPw; 
    private String conType;
    private String conDbType;
    private String classNm;	
    private String conUrl;
    private String condCalmt;   //컬럼 산출식
    
    private String imgResolH;	//제한height
    private String imgResolW;	//제한width
    private String chnlTypeCd;	//채널유형코드
    private String secretNm;	//비밀명
    private String dbNm;		//디비명
    
    private String encColYn;
    
    public String getValMaxSize() {
        return valMaxSize;
    }
    public void setValMaxSize(String valMaxSize) {
        this.valMaxSize = valMaxSize;
    }
    public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTblName() {
		return tblName;
	}
	public void setTblName(String tblName) {
		this.tblName = tblName;
	}
	public String getColName() {
		return colName;
	}
	public void setColName(String colName) {
		this.colName = colName;
	}
	public String getMarkName() {
		return markName;
	}
	public void setMarkName(String markName) {
		this.markName = markName;
	}
	public String getSchName() {
		return schName;
	}
	public void setSchName(String schName) {
		this.schName = schName;
	}
	public String getConWhere() {
		return conWhere;
	}
	public void setConWhere(String conWhere) {
		this.conWhere = conWhere;
	}
	public String getMaxVol() {
		return maxVol;
	}
	public void setMaxVol(String maxVol) {
		this.maxVol = maxVol;
	}
	public String getSchEmail() {
		return schEmail;
	}
	public void setSchEmail(String schEmail) {
		this.schEmail = schEmail;
	}
	public String getSchPhone() {
		return schPhone;
	}
	public void setSchPhone(String schPhone) {
		this.schPhone = schPhone;
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
	public String getConType() {
		return conType;
	}
	public void setConType(String conType) {
		this.conType = conType;
	}
	public String getClassNm() {
		return classNm;
	}
	public void setClassNm(String classNm) {
		this.classNm = classNm;
	}
	public String getConUrl() {
		return conUrl;
	}
	public void setConUrl(String conUrl) {
		this.conUrl = conUrl;
	}
    public String getCondCalmt() {
        return condCalmt;
    }
    public void setCondCalmt(String condCalmt) {
        this.condCalmt = condCalmt;
    }
    public String getSchMemId() {
        return schMemId;
    }
    public void setSchMemId(String schMemId) {
        this.schMemId = schMemId;
    }
    public String getConDbType() {
        return conDbType;
    }
    public void setConDbType(String conDbType) {
        this.conDbType = conDbType;
    }

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
	public String getImgResolH() {
		return imgResolH;
	}
	public void setImgResolH(String imgResolH) {
		this.imgResolH = imgResolH;
	}
	public String getImgResolW() {
		return imgResolW;
	}
	public void setImgResolW(String imgResolW) {
		this.imgResolW = imgResolW;
	}
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}
	public String getSecretNm() {
		return secretNm;
	}
	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
	public String getDbNm() {
		return dbNm;
	}
	public void setDbNm(String dbNm) {
		this.dbNm = dbNm;
	}
	public String getEncColYn() {
		return encColYn;
	}
	public void setEncColYn(String encColYn) {
		this.encColYn = encColYn;
	}

}
