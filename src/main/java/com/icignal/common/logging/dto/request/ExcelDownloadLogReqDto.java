package com.icignal.common.logging.dto.request;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.common.util.CommonUtil.EXCEL_DOWNLOAD_TYPE;



/**
 * @name : infavor.common.log.dto.request.ICNExcelDownloadLogRequestDTO
 * @date : 2017. 6. 7.
 * @author : "dg.ryu"
 * @description : 엑셀 다운로드 로그 Request
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class ExcelDownloadLogReqDto extends CommonDataAuthReqDto {
	private String id;               //아이디
	private String reqDt;            //요청일시
	private String reqTypeCd;        //요청유형코드
	private String reqUrl;           //요청URL
	private String reqIp;            //요청IP
	private String reqSessnId;       //요청세션아이디
	private String reqLoginId;       //요청로그인아이디
	private String targetId;         //대상아이디    
	private String downFilePath;
	private EXCEL_DOWNLOAD_TYPE excelDownlType;
	private String condWhere; 		//조회조건
	

	public String getCondWhere() {
		return condWhere;
	}

	public void setCondWhere(String condWhere) {
		this.condWhere = condWhere;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getReqDt() {
		return reqDt;
	}

	public void setReqDt(String reqDt) {
		this.reqDt = reqDt;
	}

	public String getReqTypeCd() {
		return reqTypeCd;
	}

	public void setReqTypeCd(String reqTypeCd) {
		this.reqTypeCd = reqTypeCd;
	}

	public String getReqUrl() {
		return reqUrl;
	}

	public void setReqUrl(String reqUrl) {
		this.reqUrl = reqUrl;
	}

	public String getReqIp() {
		return reqIp;
	}

	public void setReqIp(String reqIp) {
		this.reqIp = reqIp;
	}

	public String getReqSessnId() {
		return reqSessnId;
	}

	public void setReqSessnId(String reqSessnId) {
		this.reqSessnId = reqSessnId;
	}

	public String getReqLoginId() {
		return reqLoginId;
	}

	public void setReqLoginId(String reqLoginId) {
		this.reqLoginId = reqLoginId;
	}

	public String getTargetId() {
		return targetId;
	}

	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}

	public String getDownFilePath() {
		return downFilePath;
	}

	public void setDownFilePath(String downFilePath) {
		this.downFilePath = downFilePath;
	}

	public EXCEL_DOWNLOAD_TYPE getExcelDownlType() {
		return excelDownlType;
	}

	public void setExcelDownlType(EXCEL_DOWNLOAD_TYPE excelDownlType) {
		this.excelDownlType = excelDownlType;
	}


}