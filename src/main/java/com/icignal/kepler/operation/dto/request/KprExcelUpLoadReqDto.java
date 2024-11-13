package com.icignal.kepler.operation.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 18.
 * @author : 이원준
 * @description : 주제영역 목록 RequestDTO
 */
public class KprExcelUpLoadReqDto extends CommonDataAuthReqDto {
	
    private String accountId;   	//어카운트 아이디
    private String createBy;     	//생성자
    private String modifyBy;     	//수정자

    private String tableId;     	//테이블아이디
    private String importType;     //임포트유형
    private String fileNm;     		//파일명
    private Integer totCnt;     	//총건수
    private Integer successCnt;    //성공건수
    private Integer failCnt;     	//실패건수
    private List<String> errorMessages;     //메세지
    private String id;     			//아이디
    private String startDate;     	//시작시간
    private String endDate;     	//종료시간
    

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public List<String> getErrorMessages() {
		return errorMessages;
	}

	public void setErrorMessages(List<String> errorMessages) {
		this.errorMessages = errorMessages;
	}

	public String getFileNm() {
		return fileNm;
	}

	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}

	public Integer getTotCnt() {
		return totCnt;
	}

	public void setTotCnt(Integer totCnt) {
		this.totCnt = totCnt;
	}

	public Integer getSuccessCnt() {
		return successCnt;
	}

	public void setSuccessCnt(Integer successCnt) {
		this.successCnt = successCnt;
	}

	public Integer getFailCnt() {
		return failCnt;
	}

	public void setFailCnt(Integer failCnt) {
		this.failCnt = failCnt;
	}

	public String getImportType() {
		return importType;
	}

	public void setImportType(String importType) {
		this.importType = importType;
	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
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

	public String getTableId() {
		return tableId;
	}

	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
    
}
