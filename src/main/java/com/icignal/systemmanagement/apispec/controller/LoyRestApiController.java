package com.icignal.systemmanagement.apispec.controller;
/**
 * 1. FileName	: null.java
 * 2. Package	: com.icignal.systemmanagement.apispec.controller
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2021-12-13 오후 3:41
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2021-12-13		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명:
 * 2. 클래스명:
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2021-12-13
 */

import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.systemmanagement.apispec.dto.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.systemmanagement.apispec.service.LoyRestApiService;


/**
 * PRE
 * 1. 설명
 *     API 받는 Controller
 *     (ICIGNAL-API 서버를 올리지 않고 ADMIN(BO)에 작업을 하다보니 생긴 클래스)
 * PRE
 *      API 요청 LOG : this.loggingHelper.addApiLogPorcMsgLog(reqDto,"REQ");
 */
@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class LoyRestApiController {

	@Autowired
    private LoyRestApiService loyRestApiService;
    @Autowired
    private LoggingHelper loggingHelper;

    public LoyRestApiController(LoyRestApiService loyRestApiService, LoggingHelper loggingHelper) {
        this.loyRestApiService = loyRestApiService;
        this.loggingHelper = loggingHelper;
    }

    //설문 조회 API
    @PostMapping("/survey/surveyInfo")
    public LoySurveyInfoApiVo getSurveyInfo(@RequestBody LoySurveyInfoApiVo reqDto)  {
        this.loggingHelper.addApiLogPorcMsgLog(reqDto,"REQ");
        return this.loyRestApiService.getSurveyInfo(reqDto);
    }

    //설문 응답 정보 저장 API
    @PostMapping("/survey/surveyEnter")
    public LoySurveyEnterApiVo getSurveyEnter(@RequestBody LoySurveyEnterApiVo reqDto ){
        this.loggingHelper.addApiLogPorcMsgLog(reqDto,"REQ");
        return this.loyRestApiService.getSurveyEnter(reqDto);
    }

    //설문 참여가능 여부 API
    @PostMapping("/survey/enterYn")
    public LoySurveyEnterYnApiVo getEnterYn(@RequestBody LoySurveyEnterYnApiVo reqDto ){
        this.loggingHelper.addApiLogPorcMsgLog(reqDto,"REQ");
        return this.loyRestApiService.getEnterYn(reqDto);
    }    

    //회원탈회 API HMAC 사용
    //@PostMapping("/member/mbr-delete")
    //public LoyApiResultVo getMbrDelete(@RequestBody LoyMbrDeleteVo reqDto, @RequestHeader String authorization )
    //        throws UnsupportedEncodingException, NoSuchAlgorithmException, InvalidKeyException, JsonProcessingException {
    //	LogUtil.param(this.getClass(), reqDto);
    //    return this.loyRestApiService.getMbrDelete(reqDto, authorization);
    //}

    //회원탈회 API 기본
    @PostMapping("/member/mbr-delete")
    public LoyMbrDeleteVo getMbrDelete(@RequestBody LoyMbrDeleteVo reqDto ) {
        this.loggingHelper.addApiLogPorcMsgLog(reqDto,"REQ");
        return this.loyRestApiService.getMbrDelete(reqDto);
    }

    //사용자에 해당하는 최근 30일간의 APP PUSH발송 성공 이력 조회 API
    @PostMapping("/member/mbr-push-hist")
    public LoyMbrPushHistVo getMbrPushHist(@RequestBody LoyMbrPushHistVo reqDto){
        this.loggingHelper.addApiLogPorcMsgLog(reqDto,"REQ");
        return this.loyRestApiService.getMbrPushHist(reqDto);
    }

}
