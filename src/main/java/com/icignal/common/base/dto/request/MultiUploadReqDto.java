package com.icignal.common.base.dto.request;


/**
@file MultiUploadRequestDTO.java
@date 2013. 03. 22.
@author 김정석
*/
public class MultiUploadReqDto extends UploadReqDto {

	private String type;
	private String parentId;
	private String schemas;
	private String empId;
	private String imageLang;


	public String getType() {return type;}

	public void setType(String type) {this.type = type;}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getSchemas() {
		if(schemas == null)
			schemas = "beacon";
		return schemas;
	}

	public void setSchemas(String schemas) {
		this.schemas = schemas;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getImageLang() {
		return imageLang;
	}

	public void setImageLang(String imageLang) {
		this.imageLang = imageLang;
	}
}
