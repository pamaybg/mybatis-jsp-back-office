package com.icignal.marketing.fatigue.dto.response;/**
 * 1. FileName	: iCIGNAL_LOYALTY_T10_Descente
 * 2. Package	: com.icignal.marketing.fatigue.dto.response
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-01-24 오후 6:04
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-01-24		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: MktFatigueChnlItemResDto
 * 2. 클래스명: MktFatigueChnlItemResDto
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-01-24
 */

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   피로도 채널 아이템 Response Dto	
 */
public class MktFatigueChnlItemResDto extends StatusResDto {

    private String id;
    private String ridFati;
    private String chnlTypeCd;
    //@MarkName(groupCode = "MKT_FATI_STAT", codeField = "fatiItemState")
    private String fatiItemState;
    //@MarkName(groupCode = "COM_STAT_TYPE_3_CD", codeField = "fatiItemRestrictionDayYn")
    private String fatiItemRestrictionDayYn;
    private String fatiItemRestrictionDay;
    private String fatiItemMaxRestrictionDayCnt;
    //@MarkName(groupCode = "COM_STAT_TYPE_3_CD", codeField = "fatiItemRestrictionWeekYn")
    private String fatiItemRestrictionWeekYn;
    private String fatiItemRestrictionWeek;
    private String fatiItemMaxRestrictionWeekCnt;
    //@MarkName(groupCode = "COM_STAT_TYPE_3_CD", codeField = "fatiItemRestrictionMonYn")
    private String fatiItemRestrictionMonYn;
    private String fatiItemRestrictionMon;
    private String fatiItemMaxRestrictionMonCnt;
    //@MarkName(groupCode = "COM_STAT_TYPE_3_CD", codeField = "fatiItemRestrictionYearYn")
    private String fatiItemRestrictionYearYn;
    private String fatiItemRestrictionYear;
    private String fatiItemMaxRestrictionYearCnt;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public String getFatiItemState() {
        return fatiItemState;
    }

    public void setFatiItemState(String fatiItemState) {
        this.fatiItemState = fatiItemState;
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
}
