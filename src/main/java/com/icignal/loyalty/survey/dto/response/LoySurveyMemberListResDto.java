package com.icignal.loyalty.survey.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class LoySurveyMemberListResDto extends GridPagingItemResDto {

    private String ridSurveyMember;
    private String memberNo;

    @Decrypted(masked = "custNm")
    private String customerName;
    @Decrypted(masked = "tel")
    private String mobilePhoneNumber;

    private String selectedDate;

    private String joinedFlag;
    private String joinedDate;

    private String unmaskingCustomerName;
    private String unmaskingMobilePhoneNumber;

    public String getRidSurveyMember() {
        return ridSurveyMember;
    }

    public void setRidSurveyMember(String ridSurveyMember) {
        this.ridSurveyMember = ridSurveyMember;
    }

    public String getMemberNo() {
        return memberNo;
    }

    public void setMemberNo(String memberNo) {
        this.memberNo = memberNo;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getMobilePhoneNumber() {
        return mobilePhoneNumber;
    }

    public void setMobilePhoneNumber(String mobilePhoneNumber) {
        this.mobilePhoneNumber = mobilePhoneNumber;
    }

    public String getSelectedDate() {
        return selectedDate;
    }

    public void setSelectedDate(String selectedDate) {
        this.selectedDate = selectedDate;
    }

    public String getJoinedFlag() {
        return joinedFlag;
    }

    public void setJoinedFlag(String joinedFlag) {
        this.joinedFlag = joinedFlag;
    }

    public String getJoinedDate() {
        return joinedDate;
    }

    public void setJoinedDate(String joinedDate) {
        this.joinedDate = joinedDate;
    }

    public String getUnmaskingCustomerName() {
        return unmaskingCustomerName;
    }

    public void setUnmaskingCustomerName(String unmaskingCustomerName) {
        this.unmaskingCustomerName = unmaskingCustomerName;
    }

    public String getUnmaskingMobilePhoneNumber() {
        return unmaskingMobilePhoneNumber;
    }

    public void setUnmaskingMobilePhoneNumber(String unmaskingMobilePhoneNumber) {
        this.unmaskingMobilePhoneNumber = unmaskingMobilePhoneNumber;
    }

}
