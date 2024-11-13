package com.icignal.loyalty.survey.dto.response;

import java.util.ArrayList;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoySurveyAnalysisResDto extends GridPagingItemResDto {

	private String rid;
	private Integer sectionNo;
    private String sectionContents;
    private Integer itemNo;
    private String itemTitle;
    private String fieldTypeCode;
    @MarkName(groupCode = "LOY_SURV_FIELD_CD", codeField = "fieldTypeCode")
    private String fieldTypeCodeName;
    private Integer rNum;
    
    private ArrayList<LoySurveyAnalysisSubResDto> survSubList;
    
    public Integer getSectionNo() {
        return sectionNo;
    }

    public void setSectionNo(Integer sectionNo) {
        this.sectionNo = sectionNo;
    }

    public Integer getItemNo() {
        return itemNo;
    }

    public void setItemNo(Integer itemNo) {
        this.itemNo = itemNo;
    }

    public String getItemTitle() {
        return itemTitle;
    }

    public void setItemTitle(String itemTitle) {
        this.itemTitle = itemTitle;
    }

    public String getFieldTypeCode() {
        return fieldTypeCode;
    }

    public void setFieldTypeCode(String fieldTypeCode) {
        this.fieldTypeCode = fieldTypeCode;
    }

    public String getFieldTypeCodeName() {
        return fieldTypeCodeName;
    }

    public void setFieldTypeCodeName(String fieldTypeCodeName) {
        this.fieldTypeCodeName = fieldTypeCodeName;
    }

	public ArrayList<LoySurveyAnalysisSubResDto> getSurvSubList() {
		return survSubList;
	}

	public void setSurvSubList(ArrayList<LoySurveyAnalysisSubResDto> survSubList) {
		this.survSubList = survSubList;
	}

	public String getSectionContents() {
		return sectionContents;
	}

	public void setSectionContents(String sectionContents) {
		this.sectionContents = sectionContents;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public Integer getrNum() {
		return rNum;
	}

	public void setrNum(Integer rNum) {
		this.rNum = rNum;
	}
}