package com.icignal.systemmanagement.job.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
* @name : infavor.loyalty.system.job.dto.request.LOYJobStepCommandListRequestDTO
* @date : 2019. 1. 29.
* @author : hy.jun
* @description :
*/
public class SystemJobStepCommandListReqDto extends CommonDataAuthReqDto {
	private List<String> rids; //삭제대상 rid
	
	private String rid;
	private String ridStep;
	private String itemType;
	private String command;
	private String commandParamType;
	private String commandParam;
	private String workingDirectory;
	private String timeout;
	
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
}

