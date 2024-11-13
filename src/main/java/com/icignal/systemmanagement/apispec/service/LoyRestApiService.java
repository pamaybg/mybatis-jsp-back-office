package com.icignal.systemmanagement.apispec.service;
/**
 * 1. FileName	: null.java
 * 2. Package	: com.icignal.systemmanagement.apispec.service.service
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2021-12-13 오후 3:43
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2021-12-13		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명:
 * 2. 클래스명: LoyRestApiService
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2021-12-13
 */

import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.logging.dto.request.ApiLogReqDto;
import com.icignal.common.logging.dto.request.ApiSystemErrorAlertLogReqDto;
import com.icignal.common.util.ObjectUtil;
import com.icignal.loyalty.membership.mapper.LoyMbrMapper;
import com.icignal.systemmanagement.apispec.dto.vo.*;
import com.icignal.systemmanagement.apispec.mapper.LoyRestApiMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.loyalty.survey.mapper.LoySurveyMapper;

/**
 * PRE
 * 1. 설명
 *      API 받는 서비스
 *      (ICIGNAL-API 서버를 올리지 않고 ADMIN(BO)에 작업을 하다보니 생긴 클래스)
 * PRE
 *      API ERROR LOG MESSAGE : loggingHelper.addApiSystemErrAlt(apiNo)
 *      API 응답 LOG : this.loggingHelper.addApiLogPorcMsgLog(rtnValue,"RES");
 */
@Service
public class LoyRestApiService {

    @Autowired
    LoggingHelper loggingHelper;

    @Autowired
    LoyRestApiMapper loyRestApiMapper;


    /**
     * 1. FileName	: LoyRestApiService.java
     * 2. Package	: com.icignal.systemmanagement.apispec.service.service
     * 3. Comments	: SURV_1001
     * 4. Author	: hr.noh
     * 5. DateTime	: 2021-12-14 오전 17:43
     * 6. History	:
     * -----------------------------------------------------------------
     * Date		 |	Name			|	Comment
     * -------------  -----------------   ------------------------------
     * 2021-12-14		 | hr.noh			|	최초작성
     * -----------------------------------------------------------------
     * <p>
     * 1. 메소드명: getSurveyInfo
     * 2. 클래스명: LoyRestApiService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2021-12-14
     */
    /**
     * PRE
     * 1. 설명
     *      설문 조회
     * PRE
     *
     */
    public LoySurveyInfoApiVo getSurveyInfo(LoySurveyInfoApiVo reqDto) {
        loyRestApiMapper.execPkgLoyApiSurveySpGetSurvInfo(reqDto);
        LoySurveyInfoApiVo rtnValue = new LoySurveyInfoApiVo();

        if("S".equals(reqDto.getRst())){
            rtnValue.setSurvNm(reqDto.getSurvNm());
            rtnValue.setStartMsg(reqDto.getStartMsg());
            rtnValue.setEndMsg(reqDto.getEndMsg());
            rtnValue.setStartDt(reqDto.getStartDt());
            rtnValue.setEndDt(reqDto.getEndDt());
            rtnValue.setStartImg(reqDto.getStartImg());
            rtnValue.setEndImg(reqDto.getEndImg());
            rtnValue.setSurvSectList(loyRestApiMapper.survSectList(reqDto));
            rtnValue.setSurvItemList(loyRestApiMapper.survItemList(reqDto));
            rtnValue.setSurvItemAttrList(loyRestApiMapper.survItemAttrList(reqDto));
        }
        //else if("F".equals(reqDto.getRst())){
            // API 시스템 장애 알림 추가
        //    loggingHelper.addApiSystemErrAlt(reqDto.getApiNo(), reqDto.getRstMsg());
        //}
        
        rtnValue.setApiNo(reqDto.getApiNo());
        rtnValue.setTrNo(reqDto.getTrNo());
        rtnValue.setChnlNo(reqDto.getChnlNo());
        rtnValue.setPgmNo(reqDto.getPgmNo());
        rtnValue.setUsrTypeCd(reqDto.getUsrTypeCd());
        rtnValue.setMbrNo(reqDto.getMbrNo());
        rtnValue.setRidSurv(reqDto.getRidSurv());        
        rtnValue.setRst(reqDto.getRst());
        rtnValue.setRstCd(reqDto.getRstCd());
        rtnValue.setRstMsg(reqDto.getRstMsg());
        
        this.loggingHelper.addApiLogPorcMsgLog(rtnValue,"RES");
        return rtnValue;
    }

    /**
     * 1. FileName	: LoyRestApiService.java
     * 2. Package	: com.icignal.systemmanagement.apispec.service.service
     * 3. Comments	: SURV_1002
     * 4. Author	: hr.noh
     * 5. DateTime	: 2021-12-14 오전 17:43
     * 6. History	:
     * -----------------------------------------------------------------
     * Date		 |	Name			|	Comment
     * -------------  -----------------   ------------------------------
     * 2021-12-14		 | hr.noh			|	최초작성
     * -----------------------------------------------------------------
     * <p>
     * 1. 메소드명: getSurveyEnter
     * 2. 클래스명: LoyRestApiService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2021-12-14
     */
    /**
     * PRE
     * 1. 설명
     *      설문 응답 정보 저장
     * PRE
     *
     */
    public LoySurveyEnterApiVo getSurveyEnter(LoySurveyEnterApiVo reqDto) {
        loyRestApiMapper.execPkgLoyApiSurvSpEnterSurvRst(reqDto);
        LoySurveyEnterApiVo rtnValue = new LoySurveyEnterApiVo();
        
        rtnValue.setApiNo(reqDto.getApiNo());
        rtnValue.setTrNo(reqDto.getTrNo());
        rtnValue.setChnlNo(reqDto.getChnlNo());
        rtnValue.setPgmNo(reqDto.getPgmNo());
        rtnValue.setUsrTypeCd(reqDto.getUsrTypeCd());
        rtnValue.setMbrNo(reqDto.getMbrNo());
        rtnValue.setRidSurv(reqDto.getRidSurv());         
        rtnValue.setRst(reqDto.getRst());
        rtnValue.setRstCd(reqDto.getRstCd());
        rtnValue.setRstMsg(reqDto.getRstMsg());

        //if("F".equals(reqDto.getRst())){
            // API 시스템 장애 알림 추가
        //    loggingHelper.addApiSystemErrAlt(reqDto.getApiNo(), reqDto.getRstMsg());
        //}
        
        this.loggingHelper.addApiLogPorcMsgLog(rtnValue,"RES");
        return rtnValue;
    }

    /**
     * 1. FileName	: LoyRestApiService.java
     * 2. Package	: com.icignal.systemmanagement.apispec.service.service
     * 3. Comments	: MBRS_1001
     * 4. Author	: hr.noh
     * 5. DateTime	: 2022-01-05 오전 17:43
     * 6. History	:
     * -----------------------------------------------------------------
     * Date		 |	Name			|	Comment
     * -------------  -----------------   ------------------------------
     * 2021-12-14		 | hr.noh			|	최초작성
     * -----------------------------------------------------------------
     * <p>
     * 1. 메소드명: getMbrDelete
     * 2. 클래스명: LoyRestApiService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2022-01-05
     */
    /**
     * PRE
     * 1. 설명
     *      회원 탈회 API HMAC 사용
     * PRE
     *        Authrization 생성
     *        Map<String , Object> T = new LinkedHashMap<>();
     *         T.put("apiNo","MBRS_1001");
     *         T.put("trNo","123123123123");
     *         T.put("trDt","20220105");
     *         T.put("pgmNo","P000001");
     *         T.put("chnlNo","CH0000001");
     *         T.put("usrId","M1000546730");
     *         T.put("reasonCd","C");
     *         T.put("reason","test");
     *         System.out.println(SecurityUtil.generateHMAC(new ObjectMapper().writeValueAsString(T), BeansUtil.getApplicationProperty("descente.api.hmac.key")));
     */
     //public LoyApiResultVo getMbrDelete(LoyMbrDeleteVo reqDto, String authorization)
     //        throws JsonProcessingException, UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException {
     //   LoyApiResultVo rtnValue = new LoyApiResultVo();

     //   if(SecurityUtil.checkHMac(new ObjectMapper().writeValueAsString(reqDto), authorization)) {

     //       rtnValue.setRst("S");
     //       rtnValue.setRstCd("0");
     //       rtnValue.setRstMsg("성공");
     //   }else{
     //       rtnValue.setRst("F");
     //       rtnValue.setRstCd("1");
     //       rtnValue.setRstMsg("실패");
     //   }

     //   return rtnValue;

    //}


    /**
     * 1. FileName	: LoyRestApiService.java
     * 2. Package	: com.icignal.systemmanagement.apispec.service.service
     * 3. Comments	: SURV_1003
     * 4. Author	: hr.noh
     * 5. DateTime	: 2022-02-07 오전 10:43
     * 6. History	:
     * -----------------------------------------------------------------
     * Date		 |	Name			|	Comment
     * -------------  -----------------   ------------------------------
     * 2022-02-07		 | hr.noh			|	최초작성
     * -----------------------------------------------------------------
     * <p>
     * 1. 메소드명: getEnterYn
     * 2. 클래스명: LoyRestApiService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2022-02-07
     */
    /**
     * PRE
     * 1. 설명
     *      설문 참여가능 여부
     * PRE
     *
     */
	public LoySurveyEnterYnApiVo getEnterYn(LoySurveyEnterYnApiVo reqDto) {

        loyRestApiMapper.execPkgLoyApiSurvSpEnterYnSurvRst(reqDto);
        LoySurveyEnterYnApiVo rtnValue = new LoySurveyEnterYnApiVo();

        rtnValue.setApiNo(reqDto.getApiNo());
        rtnValue.setTrNo(reqDto.getTrNo());
        rtnValue.setChnlNo(reqDto.getChnlNo());
        rtnValue.setPgmNo(reqDto.getPgmNo());
        rtnValue.setUsrTypeCd(reqDto.getUsrTypeCd());
        rtnValue.setMbrNo(reqDto.getMbrNo());
        rtnValue.setRidSurv(reqDto.getRidSurv());
        rtnValue.setRst(reqDto.getRst());
        rtnValue.setRstCd(reqDto.getRstCd());
        rtnValue.setRstMsg(reqDto.getRstMsg());
        rtnValue.setUsrEnterYn(reqDto.getUsrEnterYn());

        //if("F".equals(reqDto.getRstCd())){
            // API 시스템 장애 알림 추가
        //    loggingHelper.addApiSystemErrAlt(reqDto.getApiNo(), reqDto.getRstMsg());
        //}

        this.loggingHelper.addApiLogPorcMsgLog(rtnValue,"RES");
        return rtnValue;
	}

    /**
     * 1. FileName	: LoyRestApiService.java
     * 2. Package	: com.icignal.systemmanagement.apispec.service.service
     * 3. Comments	: MBRS_1001
     * 4. Author	: hr.noh
     * 5. DateTime	: 2022-02-09 오전 17:43
     * 6. History	:
     * -----------------------------------------------------------------
     * Date		 |	Name			|	Comment
     * -------------  -----------------   ------------------------------
     * 2022-02-09		 | hr.noh			|	최초작성
     * -----------------------------------------------------------------
     * <p>
     * 1. 메소드명: getMbrDelete
     * 2. 클래스명: LoyRestApiService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2022-02-09
     */
    /**
     * PRE
     * 1. 설명
     *      회원 탈회 API
     * PRE
     *  EMPLOYEE_ID : (확인후 다르면 변경 필요)
     *  3342004AD086435EBFFC563E5F878877 시스템(실시간)
     *  797A3B5005D34C5EBD1626AAFF394FE0 시스템(Migration)
     *  AD3C2524B5BB4BA985D54B6013CB923F 시스템(초기화)
     *  CE17AF7734E7425083FD5810AEDA0E52 시스템(배치)
     *
     */
    public LoyMbrDeleteVo getMbrDelete(LoyMbrDeleteVo reqDto) {
        //reqDto.setModifyBy("3342004AD086435EBFFC563E5F878877");
        loyRestApiMapper.execPkgLoyMbrSpMbrSecsn(reqDto);
        LoyMbrDeleteVo rtnValue = new LoyMbrDeleteVo();
        rtnValue.setApiNo(reqDto.getApiNo());
        rtnValue.setTrNo(reqDto.getTrNo());
        rtnValue.setTrDt(reqDto.getTrDt());
        rtnValue.setChnlNo(reqDto.getChnlNo());
        rtnValue.setPgmNo(reqDto.getPgmNo());
        rtnValue.setUsrId(reqDto.getUsrId());
        rtnValue.setReasonCd(reqDto.getReasonCd());
        rtnValue.setReason(reqDto.getReason());
        rtnValue.setRst(reqDto.getRst());
        rtnValue.setRstCd(reqDto.getRstCd());
        rtnValue.setRstMsg(reqDto.getRstMsg());
        if("S".equals(reqDto.getRst())){
            //ODS.TB_MEMBER_INTGR 통합회원 데이터 삭제 처리
            loyRestApiMapper.deleteOdsTbMemberIntgr(reqDto);
        }
        else if("F".equals(reqDto.getRstCd())){
            // API 시스템 장애 알림 추가
            loggingHelper.addApiSystemErrAlt(reqDto.getApiNo(), reqDto.getRstMsg());
        }
        this.loggingHelper.addApiLogPorcMsgLog(rtnValue,"RES");
        return rtnValue;
    }

    /**
     * 1. FileName	: LoyRestApiService.java
     * 2. Package	: com.icignal.systemmanagement.apispec.service
     * 3. Comments	: MBRS_1002
     * 4. Author	: hr.noh
     * 5. DateTime	: 2022-04-06 오전 17:43
     * 6. History	:
     * -----------------------------------------------------------------
     * Date		 |	Name			|	Comment
     * -------------  -----------------   ------------------------------
     * 2022-04-06		 | hr.noh			|	최초작성
     * -----------------------------------------------------------------
     * <p>
     * 1. 메소드명: getMbrPushHist
     * 2. 클래스명: LoyRestApiService
     * 3. 작성자명: hr.noh
     * 4. 작성일자: 2022-04-06
     */
    /**
     * PRE
     * 1. 설명
     *      사용자에 해당하는 최근 30일간의 APP PUSH발송 성공 이력 조회 API
     * PRE
     *
     */
    public LoyMbrPushHistVo getMbrPushHist(LoyMbrPushHistVo reqDto) {
        LoyMbrPushHistVo rtnValue = new LoyMbrPushHistVo();
        try {
            loyRestApiMapper.execProcLoyApiMbrPushHist(reqDto);
            if("S".equals(reqDto.getRst())){
                rtnValue.setHistArray(loyRestApiMapper.selectMbrPushHist(reqDto));
            }
        }catch(Exception e) {
            // API 시스템 장애 알림 추가
            loggingHelper.addApiSystemErrAlt(reqDto.getApiNo(), e.getMessage());
        }finally {
            rtnValue.setApiNo(reqDto.getApiNo());
            rtnValue.setTrNo(reqDto.getTrNo());
            rtnValue.setTrDt(reqDto.getTrDt());
            rtnValue.setChnlNo(reqDto.getChnlNo());
            rtnValue.setPgmNo(reqDto.getPgmNo());
            rtnValue.setUsrId(reqDto.getUsrId());
            rtnValue.setRst(reqDto.getRst());
            rtnValue.setRstCd(reqDto.getRstCd());
            rtnValue.setRstMsg(reqDto.getRstMsg());
        }

        this.loggingHelper.addApiLogPorcMsgLog(rtnValue,"RES");
        return rtnValue;
    }
}
