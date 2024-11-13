package com.icignal.loyalty.survey.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoySurveySectionListResDto extends GridPagingItemResDto {

    private String ridSurveySection;
    private Integer sectionNo;
    private String sectionContents;
    private String lastFlag;

    private String modifyBy;
    private String modifyDate;

    private String ridSurvSect;
    private int sectNo;
    private String sectCtnt;
    private int nextSectNo;
    private String lastYn;

    public String getRidSurveySection() {
        return ridSurveySection;
    }

    public void setRidSurveySection(String ridSurveySection) {
        this.ridSurveySection = ridSurveySection;
    }

    public Integer getSectionNo() {
        return sectionNo;
    }

    public void setSectionNo(Integer sectionNo) {
        this.sectionNo = sectionNo;
    }

    public String getSectionContents() {
        return sectionContents;
    }

    public void setSectionContents(String sectionContents) {
        this.sectionContents = sectionContents;
    }

    public String getLastFlag() {
        return lastFlag;
    }

    public void setLastFlag(String lastFlag) {
        this.lastFlag = lastFlag;
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

    public String getRidSurvSect() {
        return ridSurvSect;
    }

    public void setRidSurvSect(String ridSurvSect) {
        this.ridSurvSect = ridSurvSect;
    }

    public int getSectNo() {
        return sectNo;
    }

    public void setSectNo(int sectNo) {
        this.sectNo = sectNo;
    }

    public String getSectCtnt() {
        return sectCtnt;
    }

    public void setSectCtnt(String sectCtnt) {
        this.sectCtnt = sectCtnt;
    }

    public int getNextSectNo() {
        return nextSectNo;
    }

    public void setNextSectNo(int nextSectNo) {
        this.nextSectNo = nextSectNo;
    }

    public String getLastYn() {
        return lastYn;
    }

    public void setLastYn(String lastYn) {
        this.lastYn = lastYn;
    }
}