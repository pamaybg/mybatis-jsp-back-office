package com.icignal.systemmanagement.program.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemExcelDownloadListResDto extends GridPagingItemResDto{
	
	private String rid;
	private String pgmId; //프로그램id
	private String templeteFile; //엑셀 템플릿 파일 경로
	private String title; // 엑셀 다운로드 제목
	private int excelSeq;//엑셀다운로드 순번
	private String objCode;
	
	public int getExcelSeq() {
		return excelSeq;
	}
	public void setExcelSeq(int excelSeq) {
		this.excelSeq = excelSeq;
	}
	@MarkName(groupCode = "EXCEL_CREATE_TYPE_CD", codeField = "excelCreateTypeCd")
	private String excelCreateType; //액셀 생성 유형
	
	private String excelCreateTypeCd;

	private String createDate;
	
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getPgmId() {
		return pgmId;
	}
	public void setPgmId(String pgmId) {
		this.pgmId = pgmId;
	}
	public String getTemplateFile() {
		return templeteFile;
	}
	public void setTemplateFile(String templateFile) {
		this.templeteFile = templateFile;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getExcelCreateType() {
		return excelCreateType;
	}
	public void setExcelCreateType(String excelCreateType) {
		this.excelCreateType = excelCreateType;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTempleteFile() {
		return templeteFile;
	}
	public void setTempleteFile(String templeteFile) {
		this.templeteFile = templeteFile;
	}
	public String getExcelCreateTypeCd() {
		return excelCreateTypeCd;
	}
	public void setExcelCreateTypeCd(String excelCreateTypeCd) {
		this.excelCreateTypeCd = excelCreateTypeCd;
	}
	public String getObjCode() {
		return objCode;
	}
	public void setObjCode(String objCode) {
		this.objCode = objCode;
	}
	
}
