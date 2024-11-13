package com.icignal.systemmanagement.job.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

 /*
  * 1. 메소드명: setModifyDate
  * 2. 클래스명: SystemJobStepCommandItemResDto
  * 3. 작성자명: hy.jun 
  * 4. 작성일자: 2019. 1. 29.
  */
/**
 * <PRE>
 * 1. 설명
 *		
 * 2. 사용법
 *		
 * </PRE>
 *   @param modifyDate	
 */
@CommCode
public class SystemJobStepCommandItemResDto extends GridPagingItemResDto {
	private List<String> rids;
	
	private String rid;
	private String ridStep;
	private String itemType;
	
	@MarkName(groupCode = "BATCH_ITEM_TYPE", codeField = "itemTypeCdNm")
	private String itemTypeNm;
	private String itemTypeCdNm;
	private String command;
	private String commandParamType;
	
	@MarkName(groupCode = "BATCH_COMMAND_PARAM_TYPE", codeField = "commandParamTypeCdNm")
	private String commandParamTypeNm;
	private String commandParamTypeCdNm;
	private String commandParam;
	private String workingDirectory;
	private String timeout;
	private String modifyBy;
	private String modifyDate;
	
	public List<String> getRids() {
		return rids;
	}
	public void setRids(List<String> rids) {
		this.rids = rids;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidStep() {
		return ridStep;
	}
	public void setRidStep(String ridStep) {
		this.ridStep = ridStep;
	}
	public String getItemType() {
		return itemType;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	public String getItemTypeNm() {
		return itemTypeNm;
	}
	public void setItemTypeNm(String itemTypeNm) {
		this.itemTypeNm = itemTypeNm;
	}
	public String getCommand() {
		return command;
	}
	public void setCommand(String command) {
		this.command = command;
	}
	public String getCommandParamType() {
		return commandParamType;
	}
	public void setCommandParamType(String commandParamType) {
		this.commandParamType = commandParamType;
	}
	public String getCommandParamTypeNm() {
		return commandParamTypeNm;
	}
	public void setCommandParamTypeNm(String commandParamTypeNm) {
		this.commandParamTypeNm = commandParamTypeNm;
	}
	public String getCommandParam() {
		return commandParam;
	}
	public void setCommandParam(String commandParam) {
		this.commandParam = commandParam;
	}
	public String getWorkingDirectory() {
		return workingDirectory;
	}
	public void setWorkingDirectory(String workingDirectory) {
		this.workingDirectory = workingDirectory;
	}
	public String getTimeout() {
		return timeout;
	}
	public void setTimeout(String timeout) {
		this.timeout = timeout;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getItemTypeCdNm() {
		return itemTypeCdNm;
	}
	public void setItemTypeCdNm(String itemTypeCdNm) {
		this.itemTypeCdNm = itemTypeCdNm;
	}
	public String getCommandParamTypeCdNm() {
		return commandParamTypeCdNm;
	}
	public void setCommandParamTypeCdNm(String commandParamTypeCdNm) {
		this.commandParamTypeCdNm = commandParamTypeCdNm;
	}
	
}
