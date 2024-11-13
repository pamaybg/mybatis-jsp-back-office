package com.icignal.kepler.targetGroup.targetGroup.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : infavor.kepler.targetGroup.dto.request
 * @date : 2019. 11. 11.
 * @author : dg.ryu
 * @description : 타겟그룹 ResponseDTO
 */
public class KprTargetGroupItemReqDto extends MKTBaseReqDto {
	
    private String targetGroupId;       //타겟그룹 아이디
    private String memId;
    private String attrib01;
    private String attrib02;
    private String attrib03;
    private String attrib04;
    private String attrib05;
    
    private String fileName;
    private String uploadValidCheck;
    
    private List<KprTargetGroupItemReqDto> itemList; 

	public String getTargetGroupId() {
		return targetGroupId;
	}

	public void setTargetGroupId(String targetGroupId) {
		this.targetGroupId = targetGroupId;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getAttrib01() {
		return attrib01;
	}

	public void setAttrib01(String attrib01) {
		this.attrib01 = attrib01;
	}

	public String getAttrib02() {
		return attrib02;
	}

	public void setAttrib02(String attrib02) {
		this.attrib02 = attrib02;
	}

	public String getAttrib03() {
		return attrib03;
	}

	public void setAttrib03(String attrib03) {
		this.attrib03 = attrib03;
	}

	public String getAttrib04() {
		return attrib04;
	}

	public void setAttrib04(String attrib04) {
		this.attrib04 = attrib04;
	}

	public String getAttrib05() {
		return attrib05;
	}

	public void setAttrib05(String attrib05) {
		this.attrib05 = attrib05;
	}

	public List<KprTargetGroupItemReqDto> getItemList() {
		return itemList;
	}

	public void setItemList(List<KprTargetGroupItemReqDto> itemList) {
		this.itemList = itemList;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getUploadValidCheck() {
		return uploadValidCheck;
	}

	public void setUploadValidCheck(String uploadValidCheck) {
		this.uploadValidCheck = uploadValidCheck;
	}


}
