package com.icignal.marketing.fatigue.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;


/**
 * @author : 안형욱
 * @name : infavor.marketing.personal.dto.response
 * @date : 2015. 11. 30.
 * @description : 피로도 목록조회 ResponseDTO
 */
@CommCode
public class MktFatigueResDto extends GridPagingItemResDto {

    private String id;                    //아이디
    private String createBy;            //생성일
    private String createDate;            //생성자
    private String modifyBy;            //수정일
    private String modifyDate;            //수정자

    private String fatiTitle;           //피로도 제목
    private String fatiRestrictionDay;  //피로도 기한(일)
    private String fatiRestrictionDayYn;//피로도 제한 일 사용 여부
    private String fatiMaxRestrictionDayCnt;//피로도 최대 제한 횟수(일)

    private String fatiState;             //피로도 상태 여부 A:적용,S:미적용
    private String markName;              //피로도 상태의 마크네임
    private String fatiDesc;              //설명
    private String chnlList;

    //MKT_FATIGUE_CHNL_TIEM
    private String ridFati;
    private String chnlTypeCd;
    @MarkName(groupCode = "MKT_FATI_STAT", codeField = "fatiItemState")
    private String fatiItemStateNm;
    private String fatiItemState;
    @MarkName(groupCode = "COM_STAT_TYPE_3_CD", codeField = "fatiItemRestrictionDayYn")
    private String fatiItemRestrictionDayYnNm;
    private String fatiItemRestrictionDayYn;
    private String fatiItemRestrictionDay;
    private String fatiItemMaxRestrictionDayCnt;
    @MarkName(groupCode = "COM_STAT_TYPE_3_CD", codeField = "fatiItemRestrictionWeekYn")
    private String fatiItemRestrictionWeekYnNm;
    private String fatiItemRestrictionWeekYn;
    private String fatiItemRestrictionWeek;
    private String fatiItemMaxRestrictionWeekCnt;
    @MarkName(groupCode = "COM_STAT_TYPE_3_CD", codeField = "fatiItemRestrictionMonYn")
    private String fatiItemRestrictionMonYnNm;
    private String fatiItemRestrictionMonYn;
    private String fatiItemRestrictionMon;
    private String fatiItemMaxRestrictionMonCnt;
    @MarkName(groupCode = "COM_STAT_TYPE_3_CD", codeField = "fatiItemRestrictionYearYn")
    private String fatiItemRestrictionYearYnNm;
    private String fatiItemRestrictionYearYn;
    private String fatiItemRestrictionYear;
    private String fatiItemMaxRestrictionYearCnt;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
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

    public String getFatiTitle() {
        return fatiTitle;
    }

    public void setFatiTitle(String fatiTitle) {
        this.fatiTitle = fatiTitle;
    }

    public String getFatiRestrictionDay() {
        return fatiRestrictionDay;
    }

    public void setFatiRestrictionDay(String fatiRestrictionDay) {
        this.fatiRestrictionDay = fatiRestrictionDay;
    }

    public String getFatiRestrictionDayYn() {
        return fatiRestrictionDayYn;
    }

    public void setFatiRestrictionDayYn(String fatiRestrictionDayYn) {
        this.fatiRestrictionDayYn = fatiRestrictionDayYn;
    }

    public String getFatiMaxRestrictionDayCnt() {
        return fatiMaxRestrictionDayCnt;
    }

    public void setFatiMaxRestrictionDayCnt(String fatiMaxRestrictionDayCnt) {
        this.fatiMaxRestrictionDayCnt = fatiMaxRestrictionDayCnt;
    }

    public String getFatiState() {
        return fatiState;
    }

    public void setFatiState(String fatiState) {
        this.fatiState = fatiState;
    }

    public String getMarkName() {
        return markName;
    }

    public void setMarkName(String markName) {
        this.markName = markName;
    }

    public String getFatiDesc() {
        return fatiDesc;
    }

    public void setFatiDesc(String fatiDesc) {
        this.fatiDesc = fatiDesc;
    }

    public String getRidFati() {
        return ridFati;
    }

    public void setRidFati(String ridFati) {
        this.ridFati = ridFati;
    }

    public String getChnlTypeCd() {
        return chnlTypeCd;
    }

    public void setChnlTypeCd(String chnlTypeCd) {
        this.chnlTypeCd = chnlTypeCd;
    }

    public String getFatiItemRestrictionDayYn() {
        return fatiItemRestrictionDayYn;
    }

    public void setFatiItemRestrictionDayYn(String fatiItemRestrictionDayYn) {
        this.fatiItemRestrictionDayYn = fatiItemRestrictionDayYn;
    }

    public String getFatiItemRestrictionDay() {
        return fatiItemRestrictionDay;
    }

    public void setFatiItemRestrictionDay(String fatiItemRestrictionDay) {
        this.fatiItemRestrictionDay = fatiItemRestrictionDay;
    }

    public String getFatiItemMaxRestrictionDayCnt() {
        return fatiItemMaxRestrictionDayCnt;
    }

    public void setFatiItemMaxRestrictionDayCnt(String fatiItemMaxRestrictionDayCnt) {
        this.fatiItemMaxRestrictionDayCnt = fatiItemMaxRestrictionDayCnt;
    }

    public String getFatiItemRestrictionWeekYn() {
        return fatiItemRestrictionWeekYn;
    }

    public void setFatiItemRestrictionWeekYn(String fatiItemRestrictionWeekYn) {
        this.fatiItemRestrictionWeekYn = fatiItemRestrictionWeekYn;
    }

    public String getFatiItemRestrictionWeek() {
        return fatiItemRestrictionWeek;
    }

    public void setFatiItemRestrictionWeek(String fatiItemRestrictionWeek) {
        this.fatiItemRestrictionWeek = fatiItemRestrictionWeek;
    }

    public String getFatiItemMaxRestrictionWeekCnt() {
        return fatiItemMaxRestrictionWeekCnt;
    }

    public void setFatiItemMaxRestrictionWeekCnt(String fatiItemMaxRestrictionWeekCnt) {
        this.fatiItemMaxRestrictionWeekCnt = fatiItemMaxRestrictionWeekCnt;
    }

    public String getFatiItemRestrictionMonYn() {
        return fatiItemRestrictionMonYn;
    }

    public void setFatiItemRestrictionMonYn(String fatiItemRestrictionMonYn) {
        this.fatiItemRestrictionMonYn = fatiItemRestrictionMonYn;
    }

    public String getFatiItemRestrictionMon() {
        return fatiItemRestrictionMon;
    }

    public void setFatiItemRestrictionMon(String fatiItemRestrictionMon) {
        this.fatiItemRestrictionMon = fatiItemRestrictionMon;
    }

    public String getFatiItemMaxRestrictionMonCnt() {
        return fatiItemMaxRestrictionMonCnt;
    }

    public void setFatiItemMaxRestrictionMonCnt(String fatiItemMaxRestrictionMonCnt) {
        this.fatiItemMaxRestrictionMonCnt = fatiItemMaxRestrictionMonCnt;
    }

    public String getFatiItemRestrictionYearYn() {
        return fatiItemRestrictionYearYn;
    }

    public void setFatiItemRestrictionYearYn(String fatiItemRestrictionYearYn) {
        this.fatiItemRestrictionYearYn = fatiItemRestrictionYearYn;
    }

    public String getFatiItemRestrictionYear() {
        return fatiItemRestrictionYear;
    }

    public void setFatiItemRestrictionYear(String fatiItemRestrictionYear) {
        this.fatiItemRestrictionYear = fatiItemRestrictionYear;
    }

    public String getFatiItemMaxRestrictionYearCnt() {
        return fatiItemMaxRestrictionYearCnt;
    }

    public void setFatiItemMaxRestrictionYearCnt(String fatiItemMaxRestrictionYearCnt) {
        this.fatiItemMaxRestrictionYearCnt = fatiItemMaxRestrictionYearCnt;
    }

    public String getFatiItemStateNm() {
        return fatiItemStateNm;
    }

    public void setFatiItemStateNm(String fatiItemStateNm) {
        this.fatiItemStateNm = fatiItemStateNm;
    }

    public String getFatiItemState() {
        return fatiItemState;
    }

    public void setFatiItemState(String fatiItemState) {
        this.fatiItemState = fatiItemState;
    }

    public String getFatiItemRestrictionDayYnNm() {
        return fatiItemRestrictionDayYnNm;
    }

    public void setFatiItemRestrictionDayYnNm(String fatiItemRestrictionDayYnNm) {
        this.fatiItemRestrictionDayYnNm = fatiItemRestrictionDayYnNm;
    }

    public String getFatiItemRestrictionWeekYnNm() {
        return fatiItemRestrictionWeekYnNm;
    }

    public void setFatiItemRestrictionWeekYnNm(String fatiItemRestrictionWeekYnNm) {
        this.fatiItemRestrictionWeekYnNm = fatiItemRestrictionWeekYnNm;
    }

    public String getFatiItemRestrictionMonYnNm() {
        return fatiItemRestrictionMonYnNm;
    }

    public void setFatiItemRestrictionMonYnNm(String fatiItemRestrictionMonYnNm) {
        this.fatiItemRestrictionMonYnNm = fatiItemRestrictionMonYnNm;
    }

    public String getFatiItemRestrictionYearYnNm() {
        return fatiItemRestrictionYearYnNm;
    }

    public void setFatiItemRestrictionYearYnNm(String fatiItemRestrictionYearYnNm) {
        this.fatiItemRestrictionYearYnNm = fatiItemRestrictionYearYnNm;
    }

    public String getChnlList() {
        return chnlList;
    }

    public void setChnlList(String chnlList) {
        this.chnlList = chnlList;
    }
}
