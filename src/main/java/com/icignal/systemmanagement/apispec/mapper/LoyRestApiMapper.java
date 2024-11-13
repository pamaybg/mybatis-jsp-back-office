package com.icignal.systemmanagement.apispec.mapper;/**
 * 1. FileName	: descent-loyalty-marketing-bo
 * 2. Package	: com.icignal.systemmanagement.apispec.mapper
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-04-21 오후 3:18
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-04-21		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoyRestApiMapper
 * 2. 클래스명: LoyRestApiMapper
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-04-21
 */

import com.icignal.common.logging.dto.request.ApiLogReqDto;
import com.icignal.common.logging.dto.request.ApiSystemErrorAlertLogReqDto;
import com.icignal.core.annotation.handler.ApiMapper;
import com.icignal.loyalty.survey.dto.response.LoySurveyItemAttrListResDto;
import com.icignal.loyalty.survey.dto.response.LoySurveyItemListResDto;
import com.icignal.loyalty.survey.dto.response.LoySurveySectionListResDto;
import com.icignal.systemmanagement.apispec.dto.vo.*;

import java.util.List;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   REST API MAPPER	
 */
@ApiMapper
public interface LoyRestApiMapper {

    /*
     * 1. 메소드명: execPkgLoyApiSurveySpGetSurvInfo, survSectList, survItemList, survItemAttrList
     * 2. 클래스명: LoyRestApiMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2021. 12. 14.
     */
    LoySurveyInfoApiVo execPkgLoyApiSurveySpGetSurvInfo(LoySurveyInfoApiVo reqDto);
    List<LoySurveySectionListResDto> survSectList(LoySurveyInfoApiVo reqDto);
    List<LoySurveyItemListResDto> survItemList(LoySurveyInfoApiVo reqDto);
    List<LoySurveyItemAttrListResDto> survItemAttrList(LoySurveyInfoApiVo reqDto);

    /*
     * 1. 메소드명: execPkgLoyApiSurvSpEnterSurvRst
     * 2. 클래스명: LoyRestApiMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2021. 12. 15.
     */
    LoySurveyEnterApiVo execPkgLoyApiSurvSpEnterSurvRst(LoySurveyEnterApiVo reqDto);

    void execPkgLoyApiSurvSpEnterYnSurvRst(LoySurveyEnterYnApiVo reqDto);

    /*
     * 1. 메소드명: execPkgLoyMbrSpMbrSecsn
     * 2. 클래스명: LoyRestApiMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2022. 02. 09.
     */
    /**
     * <PRE>
     * 1. 설명
     * 	회원탈퇴 API
     * 2. 사용법
     *
     * </PRE>
     *   @param reqDto
     *   @return execPkgLoyMbrSpMbrSecsn
     */
    void execPkgLoyMbrSpMbrSecsn(LoyMbrDeleteVo reqDto);

    void deleteOdsTbMemberIntgr(LoyMbrDeleteVo reqDto);

    void execProcLoyApiMbrPushHist(LoyMbrPushHistVo reqDto);

    List<LoyHistArrayVo> selectMbrPushHist(LoyMbrPushHistVo reqDto);

    /*
     * 1. 메소드명: selectCurrentTodayLogCount
     * 2. 클래스명: LoyRestApiMapper
     * 3. 작성자명: bg.yoon
     * 4. 작성일자: 2022. 03. 10.
     */
    /**
     * <PRE>
     * 1. 설명
     *		오늘 추가한 알림 개수 조회
     * 2. 사용법
     *
     * </PRE>
     *   @param apiAlt
     */
    String selectCurrentTodayLogCount(ApiSystemErrorAlertLogReqDto apiAlt);

    /*
     * 1. 메소드명: selectOprPlcyDtlSysErrAltVal
     * 2. 클래스명: LoyRestApiMapper
     * 3. 작성자명: bg.yoon
     * 4. 작성일자: 2022. 03. 10.
     */
    /**
     * <PRE>
     * 1. 설명
     *		하루에 추가 가능한 알림 개수 조회 (운영정책)
     * 2. 사용법
     *
     * </PRE>
     *   @param apiAlt
     */
    String selectOprPlcyDtlSysErrAltVal(ApiSystemErrorAlertLogReqDto apiAlt);

    /*
     * 1. 메소드명: selectOprPlcyDtlSysErrAltVal
     * 2. 클래스명: LoyRestApiMapper
     * 3. 작성자명: bg.yoon
     * 4. 작성일자: 2022. 03. 10.
     */
    /**
     * <PRE>
     * 1. 설명
     *		에러 알림을 수신받을 이메일 조회 (운영정책)
     * 2. 사용법
     *
     * </PRE>
     *   @param apiAlt
     */
    String selectOprPlcyDtlSysErrAltEmail(ApiSystemErrorAlertLogReqDto apiAlt);

    /*
     * 1. 메소드명: insertApiSysErrAlt
     * 2. 클래스명: LoyRestApiMapper
     * 3. 작성자명: bg.yoon
     * 4. 작성일자: 2022. 03. 10.
     */
    /**
     * <PRE>
     * 1. 설명
     *		API 시스템 에러 알림 추가
     * 2. 사용법
     *
     * </PRE>
     *   @param apiAlt
     */
    void insertApiSysErrAlt(ApiSystemErrorAlertLogReqDto apiAlt);

    /*
     * 1. 메소드명: insertApiLogPorcMsgLog
     * 2. 클래스명: LoyRestApiMapper
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2022. 02. 10.
     */
    /**
     * <PRE>
     * 1. 설명
     *		API MSG LOG
     * 2. 사용법
     *
     * </PRE>
     *   @param apiLog
     */
    void insertApiLogPorcMsgLog(ApiLogReqDto apiLog);
}
