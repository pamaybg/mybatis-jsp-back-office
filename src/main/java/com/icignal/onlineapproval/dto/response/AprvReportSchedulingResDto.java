package com.icignal.onlineapproval.dto.response;

import java.util.List;

/**
 * 승인레포트 : 캠페인 실행일정 정보 Response DTO
 * 
 * @name : infavor.marketing.elapproval.dto.response.MKTAprvReportSchedulingResponseDTO
 * @date : 2018. 3. 1.
 * @author : jh.kim
 * @description : 
 */
public class AprvReportSchedulingResDto {

    private String exeStartDd;      // 실행 시작일자
    private String exeEndDd;        // 실행 종료일자
    private String exeCyclTypeCd;   // 반복주기유형코드
    private String exeMonthTypeCd;  // 매월선택
    private String exeSunYn;        // 일요일 실행여부
    private String exeMonYn;        // 월요일 실행여부
    private String exeTueYn;        // 화요일 실행여부
    private String exeWedYn;        // 수요일 실행여부
    private String exeThuYn;        // 목요일 실행여부
    private String exeFriYn;        // 금요일 실행여부
    private String exeSatYn;        // 토요일 실행여부
    private String exeDd;           // 실행일자
    private String exeDay;          // 실행일
    private String exeHour;         // 실행시간
    private String exeMnut;         // 실행분
    private String divSendTtime;    // 분할전송시 기준시간
    private String divSendCnt;      // 분할전송시 1회 발송 건수
    private String maxSendCnt;      // 분할전송시 최대건수

    private List<AprvReportSchedulingDtlResDto> dtlList;    //스케줄 실행목록

    public String getExeStartDd() {
        return exeStartDd;
    }

    public void setExeStartDd(String exeStartDd) {
        this.exeStartDd = exeStartDd;
    }

    public String getExeEndDd() {
        return exeEndDd;
    }

    public void setExeEndDd(String exeEndDd) {
        this.exeEndDd = exeEndDd;
    }

    public String getExeCyclTypeCd() {
        return exeCyclTypeCd;
    }

    public void setExeCyclTypeCd(String exeCyclTypeCd) {
        this.exeCyclTypeCd = exeCyclTypeCd;
    }

    public String getExeMonthTypeCd() {
        return exeMonthTypeCd;
    }

    public void setExeMonthTypeCd(String exeMonthTypeCd) {
        this.exeMonthTypeCd = exeMonthTypeCd;
    }

    public String getExeSunYn() {
        return exeSunYn;
    }

    public void setExeSunYn(String exeSunYn) {
        this.exeSunYn = exeSunYn;
    }

    public String getExeMonYn() {
        return exeMonYn;
    }

    public void setExeMonYn(String exeMonYn) {
        this.exeMonYn = exeMonYn;
    }

    public String getExeTueYn() {
        return exeTueYn;
    }

    public void setExeTueYn(String exeTueYn) {
        this.exeTueYn = exeTueYn;
    }

    public String getExeWedYn() {
        return exeWedYn;
    }

    public void setExeWedYn(String exeWedYn) {
        this.exeWedYn = exeWedYn;
    }

    public String getExeThuYn() {
        return exeThuYn;
    }

    public void setExeThuYn(String exeThuYn) {
        this.exeThuYn = exeThuYn;
    }

    public String getExeFriYn() {
        return exeFriYn;
    }

    public void setExeFriYn(String exeFriYn) {
        this.exeFriYn = exeFriYn;
    }

    public String getExeSatYn() {
        return exeSatYn;
    }

    public void setExeSatYn(String exeSatYn) {
        this.exeSatYn = exeSatYn;
    }

    public String getExeDd() {
        return exeDd;
    }

    public void setExeDd(String exeDd) {
        this.exeDd = exeDd;
    }

    public String getExeDay() {
        return exeDay;
    }

    public void setExeDay(String exeDay) {
        this.exeDay = exeDay;
    }

    public String getExeHour() {
        return exeHour;
    }

    public void setExeHour(String exeHour) {
        this.exeHour = exeHour;
    }

    public String getExeMnut() {
        return exeMnut;
    }

    public void setExeMnut(String exeMnut) {
        this.exeMnut = exeMnut;
    }

    public String getDivSendTtime() {
        return divSendTtime;
    }

    public void setDivSendTtime(String divSendTtime) {
        this.divSendTtime = divSendTtime;
    }

    public String getDivSendCnt() {
        return divSendCnt;
    }

    public void setDivSendCnt(String divSendCnt) {
        this.divSendCnt = divSendCnt;
    }

    public String getMaxSendCnt() {
        return maxSendCnt;
    }

    public void setMaxSendCnt(String maxSendCnt) {
        this.maxSendCnt = maxSendCnt;
    }

    public List<AprvReportSchedulingDtlResDto> getDtlList() {
        return dtlList;
    }

    public void setDtlList(List<AprvReportSchedulingDtlResDto> dtlList) {
        this.dtlList = dtlList;
    }

}
