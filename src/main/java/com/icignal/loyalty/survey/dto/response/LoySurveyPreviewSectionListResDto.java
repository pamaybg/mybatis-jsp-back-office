package com.icignal.loyalty.survey.dto.response;

public class LoySurveyPreviewSectionListResDto {

    private String ridSurveySection;
    private String sectionNo;
    private String nextSectionNo;
    private String sectionContents;
    private String lastFlag;

    public String getRidSurveySection() {
        return ridSurveySection;
    }

    public void setRidSurveySection(String ridSurveySection) {
        this.ridSurveySection = ridSurveySection;
    }

    public String getSectionNo() {
        return sectionNo;
    }

    public void setSectionNo(String sectionNo) {
        this.sectionNo = sectionNo;
    }

    public String getNextSectionNo() {
        return nextSectionNo;
    }

    public void setNextSectionNo(String nextSectionNo) {
        this.nextSectionNo = nextSectionNo;
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
}