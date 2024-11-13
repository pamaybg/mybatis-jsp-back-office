package com.icignal.systemmanagement.job.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemJobStepItemResDto extends GridPagingItemResDto {

	private String rid;
	private String stepNm;
	private String stepDesc;
	private String modifyBy;
	private String modifyDate;
	private String ridJob;

	private String stepType;
	@MarkName(groupCode = "BATCH_STEP_TYPE", codeField = "stepType")
	private String stepTypeNm;

	private String itemReaderNm;
	private String itemWriterNm;
	private String itemProcessNm;

	private String stepSeq;

	private String taskletNm;

	private List<String> rids;

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getStepNm() {
		return stepNm;
	}

	public void setStepNm(String stepNm) {
		this.stepNm = stepNm;
	}

	public String getStepDesc() {
		return stepDesc;
	}

	public void setStepDesc(String stepDesc) {
		this.stepDesc = stepDesc;
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

	public String getRidJob() {
		return ridJob;
	}

	public void setRidJob(String ridJob) {
		this.ridJob = ridJob;
	}

	public List<String> getRids() {
		return rids;
	}

	public void setRids(List<String> rids) {
		this.rids = rids;
	}

	public String getStepType() {
		return stepType;
	}

	public void setStepType(String stepType) {
		this.stepType = stepType;
	}

	public String getItemReaderNm() {
		return itemReaderNm;
	}

	public void setItemReaderNm(String itemReaderNm) {
		this.itemReaderNm = itemReaderNm;
	}

	public String getItemWriterNm() {
		return itemWriterNm;
	}

	public void setItemWriterNm(String itemWriterNm) {
		this.itemWriterNm = itemWriterNm;
	}

	public String getItemProcessNm() {
		return itemProcessNm;
	}

	public void setItemProcessNm(String itemProcessNm) {
		this.itemProcessNm = itemProcessNm;
	}

	public String getStepSeq() {
		return stepSeq;
	}

	public void setStepSeq(String stepSeq) {
		this.stepSeq = stepSeq;
	}

	public String getTaskletNm() {
		return taskletNm;
	}

	public void setTaskletNm(String taskletNm) {
		this.taskletNm = taskletNm;
	}

	public String getStepTypeNm() {
		return stepTypeNm;
	}

	public void setStepTypeNm(String stepTypeNm) {
		this.stepTypeNm = stepTypeNm;
	}

}
