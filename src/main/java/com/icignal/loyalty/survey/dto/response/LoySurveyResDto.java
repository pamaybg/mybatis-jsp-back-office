package com.icignal.loyalty.survey.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoySurveyResDto extends StatusResDto {

    private String ridSurvey;

    public LoySurveyResDto(Boolean success, String ridSurvey) {
        this(success, null, ridSurvey);
    }

    public LoySurveyResDto(Boolean success, String message, String ridSurvey) {
        super.setSuccess(success);
        super.setMessage(message);

        this.ridSurvey = ridSurvey;
    }

    public String getRidSurvey() {
        return ridSurvey;
    }

    public void setRidSurvey(String ridSurvey) {
        this.ridSurvey = ridSurvey;
    }

}