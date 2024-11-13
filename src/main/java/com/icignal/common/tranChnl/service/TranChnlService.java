package com.icignal.common.tranChnl.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.icignal.common.tranChnl.dto.TranChnlPushDto;
import com.icignal.common.tranChnl.mapper.TranChnlEshopMapper;
import com.icignal.common.tranChnl.mapper.TranChnlMapper;
import com.icignal.common.tranChnl.mapper.TranChnlMartMapper;
import com.icignal.common.tranChnl.model.TranChnlDto;
import com.icignal.common.util.*;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.tranChnl.dto.request.TranChnlReqDto;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.external.aws.SesManager;
import com.icignal.external.aws.dto.request.AwsSesManagerReqDto;
import com.icignal.marketing.contents.dto.request.MktCondReqDto;
import com.icignal.marketing.contents.dto.response.MktCondResDto;
import com.icignal.qpid.rest.Content;
import com.icignal.qpid.rest.Device;
import com.icignal.qpid.rest.Payload;
import com.icignal.qpid.rest.RestManager;
import com.icignal.qpid.rest.RestManager.OS_TYPE;
import com.icignal.qpid.rest.RestManager.Push_TYPE;
import com.icignal.qpid.rest.RestManager.Send_TYPE;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.service.SystemCommCodeService;
import org.springframework.web.client.RestTemplate;


/**
 * @author : 류동균
 * @name : TranChnlService.java
 * @date : 2015. 9. 22.
 * @description : 채널 발송
 */
@Service
public class TranChnlService {

    @Autowired
    StandardPBEStringEncryptor encryptor;

    @Autowired
    MKTCallQueryDao MKTCallQueryDao;

    @Autowired
    SystemCommCodeService systemCommCodeService;

    @Autowired
    TranChnlMapper tranChnlMapper;

    @Autowired
    TranChnlEshopMapper tranChnlEshopMapper;

    @Autowired
    TranChnlMartMapper tranChnlMartMapper;

    /**
     * @return : StatusResDto
     * @name : tranSms
     * @date : 2018. 01. 02.
     * @author : dg.ryu
     * @description : SMS 전송
     */
    public StatusResDto tranSms(TranChnlReqDto reqDto) {
        LogUtil.param(TranChnlService.class, reqDto);
        StatusResDto resDto = new StatusResDto();

        TranChnlDto chnlDto = TranChnlDto.builder("01")
                .message(reqDto.getMsgSbst())
                .receiveMobileNo(reqDto.getRevcCallNo())
                .callbackNo(reqDto.getToCallbackNo())
                .sendReserveDate(LocalDateTime.now())
                .registerBy(reqDto.getMemId())
                .authInfoDes(reqDto.getAuthInfoDes())
                .build();

        if(this.tranChnlEshopMapper.insertSendSms(chnlDto) > 0){
            resDto.setSuccess(true);
        } else {
            resDto.setSuccess(false);
            resDto.setMessage("발송 실패하였습니다. 관리자에게 문의해주세요.");
        }

        return resDto;
    }

    public StatusResDto tranLms(TranChnlReqDto reqDto) {
        LogUtil.param(TranChnlService.class, reqDto);
        StatusResDto resDto = new StatusResDto();

        TranChnlDto chnlDto = TranChnlDto.builder("02")
                .subject(reqDto.getMsgSubject())
                .message(reqDto.getMsgSbst())
                .receiveMobileNo(reqDto.getRevcCallNo())
                .callbackNo(reqDto.getToCallbackNo())
                .sendReserveDate(LocalDateTime.now())
                .registerBy(reqDto.getMemId())
                .authInfoDes(reqDto.getAuthInfoDes())
                .build();

        if(this.tranChnlEshopMapper.insertSendLms(chnlDto) > 0){
            resDto.setSuccess(true);
        } else {
            resDto.setSuccess(false);
            resDto.setMessage("발송 실패하였습니다. 관리자에게 문의해주세요.");
        }

        return resDto;
    }

    public StatusResDto tranApproLms(TranChnlReqDto reqDto) {
        LogUtil.param(TranChnlService.class, reqDto);
        StatusResDto resDto = new StatusResDto();

        TranChnlDto chnlDto = TranChnlDto.builder("02")
                .subject(reqDto.getMsgSubject())
                .message(reqDto.getMsgSbst())
                .receiveMobileNo(reqDto.getRevcCallNo())
                .callbackNo(reqDto.getToCallbackNo())
                .sendReserveDate(LocalDateTime.now())
                .registerBy(reqDto.getMemId())
                .build();

        if(this.tranChnlEshopMapper.insertApproSendLms(chnlDto) > 0){
            resDto.setSuccess(true);
        } else {
            resDto.setSuccess(false);
            resDto.setMessage("발송 실패하였습니다. 관리자에게 문의해주세요.");
        }

        return resDto;
    }

    /**
     * @return : StatusResDto
     * @name : tranMms
     * @date : 2018. 01. 02.
     * @author : dg.ryu
     * @description : MMS 발송
     */
    public StatusResDto tranMms(TranChnlReqDto reqDto) {
        LogUtil.param(TranChnlService.class, reqDto);
        StatusResDto resDto = new StatusResDto();

        TranChnlDto chnlDto = TranChnlDto.builder("02")
                .subject(reqDto.getMsgSubject())
                .message(reqDto.getMsgSbst())
                .receiveMobileNo(reqDto.getRevcCallNo())
                .callbackNo(reqDto.getToCallbackNo())
                .sendReserveDate(LocalDateTime.now())
                .registerBy(reqDto.getMemId())
                .imageCnt(reqDto.getFileCnt())
                .imageFilePath(reqDto.getFilePath1())
                .imageFileSize(reqDto.getFileSize1())
                .authInfoDes(reqDto.getAuthInfoDes())
                .build();

        if(this.tranChnlEshopMapper.insertSendMms(chnlDto) > 0){
            resDto.setSuccess(true);
        } else {
            resDto.setSuccess(false);
            resDto.setMessage("발송 실패하였습니다. 관리자에게 문의해주세요.");
        }

        return resDto;
    }

    /**
     * @return : StatusResDto
     * @name : sendEmail
     * @date : 2018. 01. 02.
     * @author : dg.ryu
     * @description : SMS 발송
     */
    public StatusResDto tranDescenteEmail(TranChnlReqDto param) {
        LogUtil.param(TranChnlService.class, param);

        StatusResDto rtnValue = new StatusResDto();

        if(param.getMsgSubject().contains("광고")){
            param.setContentSendType("NONE");
        } else {
            param.setContentSendType("INFO");
        }

        if(this.tranChnlEshopMapper.insertSendEmail(param) > 0){
            rtnValue.setSuccess(true);
        } else {
            rtnValue.setSuccess(false);
            rtnValue.setMessage("발송 실패하였습니다. 관리자에게 문의해주세요.");
        }
        return rtnValue;
    }

    /**
     * @return : StatusResDto
     * @name : sendEmail
     * @date : 2018. 01. 02.
     * @author : dg.ryu
     * @description : SMS 발송
     */
    public StatusResDto tranEmail(TranChnlReqDto param) {
        LogUtil.param(TranChnlService.class, param);

        StatusResDto rtnValue = new StatusResDto();

        AwsSesManagerReqDto reqDto = new AwsSesManagerReqDto();
        SesManager sesManager = new SesManager();

        //template 생성
        reqDto.setTempNm(CommonUtil.newRid()); //템플릿명
        reqDto.setText("");
        reqDto.setSubject(param.getMsgSubject()); //제목
        reqDto.setTextHtml(param.getMsgSbst());//html 내용

        sesManager.createEmailTemplate(reqDto);

        String lnlDname = "데상트코리아";
        reqDto.setSenderAddrName(lnlDname);
        reqDto.setSenderAddr("webmaster@descentekorea.co.kr");
        String lnlAddress = sesManager.encodeNameWithAddress(reqDto);

        reqDto.setSender(lnlAddress);
        reqDto.setTempNm(reqDto.getTempNm()); //템플릿이름
        reqDto.setReceiver(param.getRecvEmail());//수신자


        reqDto.setDefaultData("{\"etc1\":\"test\",\"etc2\":\"test\",\"etc3\":\"test\",\"etc4\":\"test\",\"etc5\":\"test\"}"); //개인화 실패시 default값

        //개인화
        List<String> etcList = param.getEtcList();

        int num = 1;

        //json 형식으로 바꾸기 위해 map 에 개인화 값 넣기
        Map<String, String> map = new HashMap<>();

        for (String i : etcList) {
            map.put("etc" + num, i);
            num++;
        }

        //json parsing
        try {
            ObjectMapper mapper = new ObjectMapper();
            String jsonString;
            jsonString = mapper.writeValueAsString(map);
            reqDto.setReplaceData(jsonString);

        } catch (JsonProcessingException e) {
            LogUtil.error(e.getMessage(), e);
        }


        //개인화 값 setting
        List<AwsSesManagerReqDto> personalData = new ArrayList<>();

        personalData.add(reqDto);

        reqDto.setPersonalData(personalData);

        //발송
        sesManager.personalSendEmail(reqDto);

        rtnValue.setSuccess(true);


        return rtnValue;
    }

    /**
     * @return : StatusResDto
     * @throws ParseException
     * @name : tranPush
     * @date : 2018. 01. 02.
     * @author : dg.ryu
     * @description : PUSH 발송
     */
    public StatusResDto tranPush(TranChnlReqDto reqDto) {
        LogUtil.param(TranChnlService.class, reqDto);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue = this.sendPushBraze(reqDto);

//        rtnValue = this.sendPushUracle(reqDto);

        return rtnValue;
    }

    /**
     * @return :
     * @programId :
     * @name : tranPushAsync
     * @date : 2019. 4. 18.
     * @author : hy.jun
     * @table :
     * @description : PUSH 발송 비동기
     */
    @Async
    public StatusResDto tranPushAsync(TranChnlReqDto reqDto) throws JsonParseException, JsonMappingException, IOException, ParseException {
        LogUtil.param(TranChnlService.class, reqDto);

        StatusResDto rtnValue = new StatusResDto();

        rtnValue = this.sendPushUracle(reqDto);

        return rtnValue;
    }

    /**
     * @return :
     * @name : sendPushUracle
     * @date : 2017. 3. 20.
     * @author : dg.ryu
     * @description : push 발송 Uracle
     */
    private StatusResDto sendPushUracle(TranChnlReqDto reqDto) {
        StatusResDto resDto = new StatusResDto(false, "");

        String apiUrl = BeansUtil.getApplicationProperty("uracle.push.api-url");
        String apiKey = BeansUtil.getApplicationProperty("uracle.push.api-key");
        String cloudProjectId = BeansUtil.getApplicationProperty("uracle.push.cloud-project-id");

        HttpClient client = HttpClientBuilder.create().build();
        HttpPost postMethod = new HttpPost(apiUrl);

        try {
            // 헤더 셋팅
            postMethod.setHeader("Content-Type", "application/x-www-form-urlencoded");

            // 푸시 발송 파라미터 셋팅
            List<NameValuePair> urlParameters = new ArrayList<NameValuePair>();

            // 설명 : API 인증키. 프로젝트 생성 후 API키를 생성하신 정보를 입력해 주세요.
            urlParameters.add(new BasicNameValuePair("APIKEY", apiKey));

            // 설명 : 클라우드 프로젝트아이디.
            urlParameters.add(new BasicNameValuePair("CLOUD_PROJECT_ID", cloudProjectId));

            //설명 : 푸시 메세지 정보 아래 예제 중 택 1
            String pushMsg = String.format("{\"title\":\"%s\", \"body\":\"%s\"}", reqDto.getMsgSubject(), reqDto.getMsgSbst());
            urlParameters.add(new BasicNameValuePair("PUSH_MSG", pushMsg));  // 일반 스트링
            //urlParameters.add(new BasicNameValuePair("PUSH_MSG", "{\"title\":\"안녕하세요.유라클 공지사항입니다.\",\"body\":\"오늘 새벽에 정기점검 있습니다.\n 감사합니다.\"}"));

            //설명 : 발송대상자 타켓팅
            urlParameters.add(new BasicNameValuePair("TYPE", "MP"));  //MU :UMS회원아이디로 타겟팅, MP : 푸시서비스가입 아이디로 타겟팅
            urlParameters.add(new BasicNameValuePair("CUIDS", reqDto.getRevcDeviceId()));   // 한명 보낼 경우
            //urlParameters.add(new BasicNameValuePair("CUIDS", "[\"testuser1\",\"testuser2\",\"testuser3\"]"));  //여러명 보낼 경우

            //설명 : 서비스코드 정보
            urlParameters.add(new BasicNameValuePair("SERVICECODE", "ALL"));

            //설명 : 발송자 정보
            urlParameters.add(new BasicNameValuePair("SENDERID", "TEST_SYSTEM"));

            //설명 : 메세지 타입 (I: 정보성 메시지, A: 광고성 메시지 중  택일 ex) I)
            urlParameters.add(new BasicNameValuePair("MSG_TYPE", "I"));

            JSONParser parserLinkUrl = new JSONParser();
            Object objLinkUrl = parserLinkUrl.parse(reqDto.getAttrib1());
            JSONObject jsonObj = (JSONObject) objLinkUrl;

            String linkUrl = (String) jsonObj.get("SHOW_DETAILS");

            JSONObject extObj = new JSONObject();
            String sendMsgSeqNo = this.tranChnlMapper.selectComPushSeq();

            extObj.put("type", reqDto.getPushTypeCode());
            extObj.put("linkUrl", linkUrl);
            extObj.put("imgUrl", reqDto.getAttrib2());
            extObj.put("crmmsgid", sendMsgSeqNo);

            String ext = extObj.toJSONString();
            ext = ext.replace("\\", "");
            urlParameters.add(new BasicNameValuePair("EXT_KIND", "D")); // 아래의 값의 빈값이 아닐 경우 D로 세팅
            urlParameters.add(new BasicNameValuePair("EXT", ext)); // 기본

            //알림톡 대체발송을 할경우 아래값 셋팅
            urlParameters.add(new BasicNameValuePair("PLUS_ID", "")); //카카오톡 플러스친구 아이디
            urlParameters.add(new BasicNameValuePair("KKOALT_SVCID", ""));  //카카오알림톡 서비스아이디 ex)1910028xxxx
            urlParameters.add(new BasicNameValuePair("ALLIMTOLK_TEMPLCODE", "")); //카카오알림톡 등록 승인 처리된 메세지 템플릿코드
            /*
            카카오알림톡 템플릿 대체발송시 사용.
            - 알림톡 템플릿에 내용에 #{변수명}과 같은 치환변수가 템플릿 내용에 있을 경우 필수값.
            - 메시지 형태 JSON Object
            - ex)
            메시지 내용 : 안녕하세요. 결제일은 #{날짜} 입니다. #{금액}이 청구됩니다.
            넘겨야 될 파라미터값 : {“#{날짜}”:”2019-07-07”, “#{금액}”:”1,000”}
             */
            urlParameters.add(new BasicNameValuePair("REPLACE_VARS", ""));


            //SMS 대체발송을 할 경우 아래값 셋팅
            urlParameters.add(new BasicNameValuePair("SMS_TITLE", "")); //MMS문자일 경우 타이틀
            urlParameters.add(new BasicNameValuePair("SMS_MSG", "")); //보낼 문자내용. 90byte이상은 MMS로 발송됩니다
            urlParameters.add(new BasicNameValuePair("CALLBACK_NUM", "")); //회신번호. SMS대체발송일 경우 필수
            urlParameters.add(new BasicNameValuePair("MMS_IMGURL", ""));  //MMS일 경우 이미지 URL: http://xxxx.com/sample.jpg


            postMethod.setEntity(new UrlEncodedFormEntity(urlParameters, "UTF-8"));

            HttpResponse upmcResponse = client.execute(postMethod);
            if (upmcResponse.getStatusLine().getStatusCode() == 200) {
                // 성공 비즈니스 로직 처리
                BufferedReader rd = new BufferedReader(new InputStreamReader(upmcResponse.getEntity().getContent()));
                StringBuffer result = new StringBuffer();
                String line = "";
                while ((line = rd.readLine()) != null) {
                    result.append(line);
                }
                LogUtil.info(" 응답 스트링 : " + result.toString());

                // PUSH 발송 성공여부 확인
                JSONParser parser = new JSONParser();
                Object obj = parser.parse(result.toString());
                JSONObject rtnObj = (JSONObject) obj;

                HashMap<String, String> header = (HashMap<String, String>) rtnObj.get("HEADER");
                String resultCode = header.get("RESULTCODE");
                String resultBody = header.get("RESULT_BODY");

                LogUtil.info("push result code : " + resultCode);
                LogUtil.info("push result body : " + resultBody);

                //전송 성공여부 확인
                if (resultCode.equals("0000")) {
                    resDto.setSuccess(true);
                } else {
                    resDto.setSuccess(false);
                    resDto.setMessage("Push Api 오류. 관리자에게 문의하세요.");
                    LogUtil.error(resultBody);
                }
            } else {
                // 실패 비즈니스 로직 처리
            }

        } catch (Exception e) {
            LogUtil.error(e.toString());
        }

        return resDto;
    }

    /**
     * @return : StatusResDto
     * @throws ParseException
     * @name : tranPushQpid
     * @date : 2018. 01. 02.
     * @author : dg.ryu
     * @description : PUSH 발송 QPID
     */
    public StatusResDto tranPushQpid(TranChnlReqDto param) {
        LogUtil.param(TranChnlService.class, param);

        StatusResDto rtnValue = new StatusResDto();
        // MBR_NO로 토큰 조회

        String token = null;
        String phoneType = null;
        Map<String, Object> mbrPushToken = new HashMap<>();

        try {
            // 토큰 조회할 외부 테이블 정보 조회
            MktCondReqDto pushTokenSearchInfoReq = new MktCondReqDto();
            pushTokenSearchInfoReq.setSystemColumn(param.getSystemColumn());

            //List<MKTCondResponseDTO> pushTokenSearchInfoList = mktContentService.getPushTokenInfo(pushTokenSearchInfoReq);
            List<MktCondResDto> pushTokenSearchInfoList = new ArrayList<MktCondResDto>();

            if (StringUtil.isNotEmpty(pushTokenSearchInfoList)) {

                MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();

                // 쿼리 생성
                StringBuilder query = new StringBuilder();
                query.append("SELECT ");

                String tblName = "";
                String schName = "";
                String schMemId = "";

                for (int idx = 0; idx < pushTokenSearchInfoList.size(); idx++) {
                    MktCondResDto pushTokenSearchInfo = pushTokenSearchInfoList.get(idx);

                    if (idx == 0) {
                        dbInfo.setDriverClassName(pushTokenSearchInfo.getClassNm());
                        dbInfo.setConIp(pushTokenSearchInfo.getConIp());
                        dbInfo.setConPort(pushTokenSearchInfo.getConPort());
                        dbInfo.setUserName(pushTokenSearchInfo.getConId());
                        dbInfo.setPassword(encryptor.decrypt(pushTokenSearchInfo.getConPw()));
                        dbInfo.setUrl(pushTokenSearchInfo.getConUrl());
                        dbInfo.setConDbType(pushTokenSearchInfo.getConDbType());
                    }

                    if (idx != 0) {
                        query.append(", ");
                    }
                    // 컬럼
                    String colName = pushTokenSearchInfo.getColName();

                    // 컬럼산출식 확인
                    if (!StringUtil.isEmpty(pushTokenSearchInfo.getCondCalmt())) {
                        colName = pushTokenSearchInfo.getCondCalmt();
                    }
                    query.append(colName).append(" as ").append(pushTokenSearchInfo.getColName());

                    tblName = pushTokenSearchInfo.getTblName();
                    schName = pushTokenSearchInfo.getSchName();
                    schMemId = pushTokenSearchInfo.getSchMemId();
                }

                query.append(' ').append("FROM ")
                        .append(' ').append(schName).append('.').append(tblName)
                        .append(' ').append("WHERE")
                        .append(' ').append(schMemId).append(" = ").append(param.getRevcMbrNo());

                // 쿼리 실행
                mbrPushToken = (Map<String, Object>) MKTCallQueryDao.callSelectForMap("getPersonalValue", query.toString(), new ArrayList<String>(), dbInfo);

                // 앱 토큰 정보가 존재하지 않음.
                if (StringUtil.isEmpty(mbrPushToken)) {
                    rtnValue.setMessage("앱 토큰 정보가 존재하지 않음.");
                } else {
                    rtnValue.setSuccess(true);
                    token = (String) mbrPushToken.get("Token");
                    phoneType = (String) mbrPushToken.get("PhoneType");
                }
            }
        } catch (Exception e) {
            LogUtil.error(e);
        }

        // 토큰으로 푸시 발송
        if (rtnValue.getSuccess()) {

            // RestManager 인스턴스 생성
            RestManager pm = new RestManager();

            MKTCommonCodeRequestDTO bccr = new MKTCommonCodeRequestDTO();
            bccr.setGroupCode("APP_KIND");
            GridPagingResDto gridinfo = systemCommCodeService.getCommCodeList(bccr);

            // 인증 정보 셋팅
            String applicationId = null;
            String reqApplicationId = null;
            String reqApplicationToken = null;
            String pushHost = null;

            if (StringUtil.isNotEmpty(gridinfo)) {
                List<Object> pushAppInfo = gridinfo.getRows();

                if (StringUtil.isNotEmpty(pushAppInfo)) {
                    for (Object obj : pushAppInfo) {
                        MKTCommonCodeResponseDTO info = (MKTCommonCodeResponseDTO) obj;
                        applicationId = info.getAttrib01();
                        reqApplicationId = info.getAttrib02();
                        reqApplicationToken = info.getAttrib03();
                        pushHost = info.getAttrib04();
                    }
                }
            }

            if (applicationId != null) {
                Push_TYPE getPushType = Push_TYPE.valueOf(String.valueOf(param.getPushTypeCode()));

                // 전송할 푸쉬 마스터 정보 셋팅
                Payload payload = new Payload();
                payload.setSendType(Send_TYPE.Personal);
                payload.setTitle(param.getMsgSubject()); // 제목
                payload.setPushType(getPushType); // 메세지유형
                payload.setPublicPushMessage(String.valueOf(param.getMsgSbst()));

                // 디바이스 정보 셋팅
                List<Device> devices = new ArrayList<Device>();

                Device device1 = new Device();
                device1.setDeviceToken(token);
                device1.setOutsideId("");
                device1.setOs("A".equals(phoneType) ? OS_TYPE.And : OS_TYPE.iOS);

                Content content1 = new Content();
                content1.setType(getPushType);
                content1.setTitle(param.getMsgSubject());    // 제목
                content1.setDesc(param.getMsgSbst());        // 내용
                ObjectMapper mapper = new ObjectMapper();
                Map<String, Object> map = new HashMap<String, Object>();
                try {
                    map = mapper.readValue(param.getAttrib2(), new TypeReference<Map<String, Object>>() {
                    });
                } catch (JsonMappingException e) {
                    LogUtil.error(e);
                } catch (JsonProcessingException e) {
                    LogUtil.error(e);
                }
                content1.setParam(map);     // 사용자정의 파라메터

                //일반
                if (getPushType == Push_TYPE.Notification) {
                    content1.setLogoUrl(param.getFilePath1());
                    content1.setContents(param.getFilePath1());
                }

                //URL
                else if (getPushType == Push_TYPE.Direct_URL) {
                    content1.setContents(String.valueOf(param.getPushTypeVal()));
                }

                //HTML
                else if (getPushType == Push_TYPE.HTML) {
                    content1.setDesc("");
                    content1.setContents(param.getMsgSbst());
                }

                device1.setContent(content1);
                devices.add(device1);

                // 푸쉬 인스턴스 연결
                pm.initializeConnection(applicationId, reqApplicationToken, reqApplicationId, pushHost);

                // 푸쉬 전송
                rtnValue = pm.sendNotifications(payload, devices);

                if (rtnValue.getSuccess()) {
                    rtnValue.setErrorType(0);
                }
            } else {
                rtnValue.setSuccess(false);
                rtnValue.setMessage("푸시 연결 정보가 없습니다.");
            }
        }

        return rtnValue;
    }

    /**
     * @return : StatusResDto
     * @name : sendPushBraze
     * @date : 2022. 02. 14.
     * @author : gy.lee
     * @description : braze push api 전송
     */
    private StatusResDto sendPushBraze(TranChnlReqDto reqDto) {
        LogUtil.param(TranChnlService.class, reqDto);
        StatusResDto rtnValue = new StatusResDto(false, "");

        TranChnlPushDto externalApi = this.tranChnlMapper.selectExternalWebService();

        if (StringUtil.isNotEmpty(externalApi.getWebServiceAccessToken())) {
            String accessToken = externalApi.getWebServiceAccessToken();
            String instance_url = externalApi.getWebServiceHost();

            String authorization = "Bearer " + accessToken;
            String endpointUrl = "https://" + instance_url;

            String endpointUrlOption = externalApi.getWebServiceSiteName();
            try {
                TranChnlPushDto brazeTgtChnlData = this.tranChnlMapper.selectBrazeCam(reqDto.getBrazeCamApiKey());
                String[] splitChnlData = brazeTgtChnlData.getBrazeTgtChnlList().split(",");

                String iosChnl = null;
                String androidChnl = null;
                for (String chnlData : splitChnlData) {
                    if (chnlData.indexOf("iosPush") > -1) {
                        iosChnl = chnlData;
                    } else if (chnlData.indexOf("androidPush") > -1) {
                        androidChnl = chnlData;
                    }
                }

                if (!StringUtil.isNotEmpty(androidChnl) && !StringUtil.isNotEmpty(iosChnl)) {
                    rtnValue.setSuccess(false);
                    rtnValue.setMessage("Braze API의 발송채널이 등록되지 않았습니다.");
                    return rtnValue;
                }
			    String imgUrl = reqDto.getFilePath1();

                JSONParser jsonParser = new JSONParser();
                HttpHeaders headers = new HttpHeaders();
                headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
                headers.set("Authorization", authorization);

                List<String> userList = new ArrayList<>();
                userList.add(reqDto.getRevcMemId());
                HashMap<Object, Object> messageDataIph = new HashMap<>();
                HashMap<Object, Object> kvpMessageIph = new HashMap<>();

                if (StringUtil.isNotEmpty(iosChnl)) {
                    HashMap<Object, Object> alertMessageIph = new HashMap<>();
                    alertMessageIph.put("title", reqDto.getMsgSubject());
                    alertMessageIph.put("body", reqDto.getMsgSbst());
                    kvpMessageIph.put("title", reqDto.getMsgSubject());

                    messageDataIph.put("alert", alertMessageIph);
                    messageDataIph.put("message_variation_id", iosChnl);

                    if (StringUtil.isNotEmpty(reqDto.getContsPushSubTypeVal())) {
                        messageDataIph.put("custom_uri", reqDto.getContsPushSubTypeVal());
                        kvpMessageIph.put("link", reqDto.getContsPushSubTypeVal());
                    }
                    if (StringUtil.isNotEmpty(imgUrl)) {
                        messageDataIph.put("asset_url", imgUrl);
                        messageDataIph.put("asset_file_type", "png");
                        kvpMessageIph.put("image", imgUrl);
                    }

                    messageDataIph.put("extra",kvpMessageIph);

                }

                HashMap<Object, Object> messageDataAnd = new HashMap<>();
                HashMap<Object, Object> kvpMessageAnd = new HashMap<>();

                if (StringUtil.isNotEmpty(androidChnl)) {
                    messageDataAnd.put("message_variation_id", androidChnl);
                    messageDataAnd.put("title", reqDto.getMsgSubject());
                    messageDataAnd.put("alert", reqDto.getMsgSbst());
                    kvpMessageAnd.put("title", reqDto.getMsgSubject());


                    if (StringUtil.isNotEmpty(reqDto.getContsPushSubTypeVal())) {
                        messageDataAnd.put("custom_uri", reqDto.getContsPushSubTypeVal());
                        kvpMessageAnd.put("link", reqDto.getContsPushSubTypeVal());
                    }
                    if (StringUtil.isNotEmpty(imgUrl)) {
                        kvpMessageAnd.put("appboy_image_url", imgUrl);
                        kvpMessageAnd.put("image", imgUrl);
                    }
                    messageDataAnd.put("extra", kvpMessageAnd);

                }

                HashMap<Object, Object> messageMain = new HashMap<>();
                if (StringUtil.isNotEmpty(iosChnl)) {
                    messageMain.put("apple_push", messageDataIph);
                }
                if (StringUtil.isNotEmpty(androidChnl)) {
                    messageMain.put("android_push", messageDataAnd);
                }

                HashMap<Object, Object> mapData = new HashMap<>();
                mapData.put("broadcast", false);
                mapData.put("external_user_ids", userList);
                mapData.put("messages", messageMain);
                mapData.put("campaign_id", reqDto.getBrazeCamApiKey());
                JSONObject json =  new JSONObject(mapData);
                System.out.printf( "JSON TEST SEND: %s", json);
                HttpEntity<HashMap<Object, Object>> request = new HttpEntity<>(mapData, headers);
                ResponseEntity<String> response = new RestTemplate().postForEntity(endpointUrl + endpointUrlOption, request, String.class);

                JSONParser jsonParse = new JSONParser();
                JSONObject responseObject = (JSONObject) jsonParse.parse(response.getBody());

                String responsecheckFlag = responseObject.get("message").toString();

                if (responsecheckFlag.equals("success")) {
                    rtnValue.setSuccess(true);
                } else {
                    rtnValue.setSuccess(false);
                    rtnValue.setMessage("관리자에게 문의해주세요.");
                }
            } catch (Exception e) {
                rtnValue.setSuccess(false);
                rtnValue.setMessage("관리자에게 문의해주세요.");
            }
        }


        return rtnValue;
    }


}
