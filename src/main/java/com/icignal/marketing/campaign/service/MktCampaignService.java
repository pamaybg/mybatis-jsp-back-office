package com.icignal.marketing.campaign.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import com.icignal.common.base.service.AddBatchService;
import com.icignal.common.helper.ErrorHelper;
import com.icignal.common.util.*;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.core.database.dto.request.MKTDBQueryDTO;
import com.icignal.core.exception.DataFailException;
import com.icignal.core.exception.DataSQLException;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupDBInfoReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupTargetListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupDBInfoResDto;
import com.icignal.marketing.campaign.dto.request.*;
import com.icignal.marketing.campaign.dto.response.*;
import com.icignal.marketing.campaign.mapper.MktCampaignEshopMapper;
import com.icignal.marketing.realtime.dto.request.MktCampaignChnlReqDto;
import com.icignal.offer.dto.request.OfferReqDto;
import com.icignal.offer.dto.response.OfferResDto;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil.APPROVAL_STATUS;
import com.icignal.common.util.CommonUtil.CAMPAIGN_STATUS_TYPE;
import com.icignal.common.util.CommonUtil.CAMPAIGN_WORKFLOW_NODE_DATA_TYPE;
import com.icignal.common.util.CommonUtil.DB_TYPE;
import com.icignal.common.util.CommonUtil.ET_NODE_TYPE;
import com.icignal.common.util.CommonUtil.MKT_CAM_TYPE_CD;
import com.icignal.common.util.CommonUtil.TASK_DATA_STATUS;
import com.icignal.common.util.CommonUtil.WORKFLOW_SAVE_TYPE;
import com.icignal.common.workflow.dto.request.WorkflowTaskReqDto;
import com.icignal.common.workflow.service.WorkflowService;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.exception.DataBadRequestException;
import com.icignal.marketing.campaign.mapper.MktCampaignMapper;
import com.icignal.marketing.realtime.api.dto.RealSndCampaignApiDTO;
import com.icignal.marketing.realtime.dto.request.MktRealTimeCampaignReqDto;
import org.springframework.web.client.RestTemplate;


/**
 * @author : dg.ryu
 * @name : MktCampaignService.java
 * @date : 2015. 9. 23.
 * @description : 캠페인 Service
 */
@Service("MktCampaignService")
public class MktCampaignService {

    @Autowired
    private CommonService commonService;

    @Autowired
    private MktCampaignMapper mktCampaignMapper;

    @Autowired
    private WorkflowService workflowService;

    @Autowired
    private MktCampaignEshopMapper mktCampaignEshopMapper;

    @Autowired
    StandardPBEStringEncryptor encrypor;

    @Autowired
    private MKTCallQueryDao mktCallQueryDao;

    @Autowired
    private AddBatchService addBatchService;

    final static int splitSize = Integer.parseInt(BeansUtil.getApplicationProperty("icignal.jdbc-batch.splitSize"));


    /**
     * @programId : Mkt_MNG_001
     * @name : getCampaignList
     * @date : 2015. 9. 23.
     * @author : dg.ryu
     * @description : 캠페인 목록
     */
    public GridPagingResDto<MktCampaignListResDto> getCampaignList(MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setSVCAlias("c");
        param.setAuthAlias("c");

        return new GridPagingResHelper<MktCampaignListResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktCampaignMapper.selectCampaignList(param), AnnotationType.CommCode);
    }


    /**
     * @programId :
     * @name : selectCampaignAuth
     * @date : 2022. 1. 19.
     * @author : sj.jung
     * @description : 캠페인 권한
     */
    public GridPagingResDto<MktCampaignListResDto> selectCampaignAuth(MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setSVCAlias("c");
        param.setAuthAlias("c");

        return new GridPagingResHelper<MktCampaignListResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktCampaignMapper.selectCampaignAuth(param), AnnotationType.CommCode);
    }

    /**
     * @programId : Mkt_MNG_001
     * @name : getCampaignApprList
     * @date : 2021. 01. 05.
     * @author : dg.ryu
     * @description : 캠페인 결재 목록
     */
    public GridPagingResDto<MktCampaignListResDto> getCampaignApprList(MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setSVCAlias("c");
        param.setAuthAlias("c");

        return new GridPagingResHelper<MktCampaignListResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktCampaignMapper.selectCampaignApprList(param), AnnotationType.CommCode);
    }

    /**
     * @return :
     * @programId : Mkt_MNG_001
     * @name : editCampaignStatus
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst
     * @description : 캠페인 상태 수정
     */
    public StatusResDto editCampaignStatus(MktCampaignDefaultInfoReqDto mcdir) {

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        mktCampaignMapper.updateCampaignStatus(mcdir);

        //실행정보아이템 상태 수정 : 활성
        if (CAMPAIGN_STATUS_TYPE.A.toString().equals(mcdir.getCampaignStatusCode())) {
            mktCampaignMapper.updateCampaignExeInfoStatusActive(mcdir);
        }
        //실행정보아이템 상태 수정 : 중지
        else if (CAMPAIGN_STATUS_TYPE.S.toString().equals(mcdir.getCampaignStatusCode()) || CAMPAIGN_STATUS_TYPE.C.toString().equals(mcdir.getCampaignStatusCode())) {
            mktCampaignMapper.updateCampaignExeInfoStatusStop(mcdir);
            mktCampaignMapper.updateCampaignExeInfoChnlStatusStop(mcdir);
        }

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_001
     * @name : setCampaignCancel
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst
     * @description : 캠페인 상태 - 취소
     */
    public StatusResDto setCampaignCancel(MktCampaignDefaultInfoReqDto mcdir) {
        LogUtil.param(this.getClass(), mcdir);

        StatusResDto rtnValue = new StatusResDto();

        //캠페인 상태 취소
        mcdir.setCampaignStatusCode(CAMPAIGN_STATUS_TYPE.C.name());

        rtnValue = editCampaignStatus(mcdir);

        //각 채널별 발송 중지
        if (rtnValue.getSuccess()) {

            //메세지 발송 중지
            mktCampaignMapper.updateStopSendingMessagesByCampaignId(mcdir);

            //PUSH 발송 중지
            mktCampaignMapper.updateStopSendingPushByCampaignId(mcdir);

            //이메일 발송 중지
            mktCampaignMapper.updateStopSendingEmailByCampaignId(mcdir);

            //카카오 친구톡 발송 중지
            mktCampaignMapper.updateStopSendingKakaoByCampaignId(mcdir);
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_001
     * @name : setCampaignStop
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst
     * @description : 캠페인 상태 - 중지
     */
    public StatusResDto setCampaignStop(MktCampaignDefaultInfoReqDto mcdir) {
        LogUtil.param(this.getClass(), mcdir);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        MktCampaignReqDto req = new MktCampaignReqDto();
        req.setId(mcdir.getId());

        //캠페인 기본정보 조회
        MktCampaignDefaultInfoResDto camInfo = mktCampaignMapper.selectCampaignDefaultInfo(req);

        //캠페인 상태가 활성일 경우만 중지 가능
        if (CAMPAIGN_STATUS_TYPE.A.name().equals(camInfo.getCampaignStatusCode())) {

            //캠페인 상태 중지
            mcdir.setCampaignStatusCode(CAMPAIGN_STATUS_TYPE.S.name());
            rtnValue = editCampaignStatus(mcdir);

            //각 채널별 발송 중지
            if (rtnValue.getSuccess()) {

                //메세지 발송 중지
                mktCampaignMapper.updateStopSendingMessagesByCampaignId(mcdir);

                //PUSH 발송 중지
                mktCampaignMapper.updateStopSendingPushByCampaignId(mcdir);

                //이메일 발송 중지
                mktCampaignMapper.updateStopSendingEmailByCampaignId(mcdir);

                //카카오 친구톡 발송 중지
                mktCampaignMapper.updateStopSendingKakaoByCampaignId(mcdir);
            }
        }

        return rtnValue;
    }

    /**
     * 실행 권한 여부 조회
     * <p>
     * (아래의 세 조건중 하나이상 충족할 경우 캠페인을 실행할 수 있다.)
     * 조건 1. 승인그룹에 속해있다.
     * 조건 2. 작성자
     * 조건 3. 요청자
     *
     * @return : boolean
     * @programId :
     * @name : isExecutableUser
     * @date : 2018. 1. 22.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public boolean isExecutableUser(MktCampaignExecutableUserReqDto mceur) {

        boolean rtnFlag = false;
        MktCampaignExecutableUserResDto isExecutableUserInfo = mktCampaignMapper.isExecutableUser(mceur);

        if ("Y".equals(isExecutableUserInfo.getAuthGroupUserYN())
                || "Y".equals(isExecutableUserInfo.getCreateUserYN())
                || "Y".equals(isExecutableUserInfo.getRqtrUserYN())) {
            rtnFlag = true;
        }

        return rtnFlag;
    }

    /**
     * @return : StatusResponseDTO
     * @name : checkCampaignStatus
     * @date : 2016. 03. 28.
     * @author : 장용
     * @table : mkt_cam_mst
     * @description : 캠페인 상태 조회
     */
    public StatusResDto campaignStatusCheck(MktCampaignStatusCheckReqDto cscr) {
        LogUtil.param(this.getClass(), cscr);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(true);
        rtnValue.setMessage("true");

        boolean successFlag = true;

        //캠페인 정보조회
        MktCampaignReqDto camInfoReq = new MktCampaignReqDto();
        camInfoReq.setSystemColumn(cscr.getSystemColumn());
        camInfoReq.setId(cscr.getCamId());

        MktCampaignDefaultInfoResDto camInfo = mktCampaignMapper.selectCampaignDefaultInfo(camInfoReq);

//		if(ObjectUtil.isEmpty(camInfo.getCampaignApprovalStatusCode())){
//			cscr.setUseApproval(false);
//		}else {
//			cscr.setUseApproval(true);
//		}
        //채널 정보 조회
        if (successFlag) {

            // 해당 캠페인이 가지고 있는 일정노드가 필요한 채널의 개수
            int chkChnl = mktCampaignMapper.checkChnlInfo(cscr);
            int checkExeInfoItemId = mktCampaignMapper.checkExeInfoItemId(cscr);

            if (MKT_CAM_TYPE_CD.TARGET.name().equalsIgnoreCase(camInfo.getCampaignTypeCode()) ||
                    MKT_CAM_TYPE_CD.QUICK.name().equalsIgnoreCase(camInfo.getCampaignTypeCode()) ||
                    MKT_CAM_TYPE_CD.MULTISTAGE.name().equalsIgnoreCase(camInfo.getCampaignTypeCode())
            ) {

                if (chkChnl > 0 && checkExeInfoItemId > 0) {
                    successFlag = true;
                } else if (chkChnl <= 0 && checkExeInfoItemId > 0) {
                    //실패: 채널 등록
                    successFlag = false;
                    rtnValue.setMessage("4");
                } else if (chkChnl > 0 && checkExeInfoItemId <= 0) {
                    //실패: 일정 등록
                    successFlag = false;
                    rtnValue.setMessage("5");
                } else {
                    successFlag = false;
                    rtnValue.setMessage("5");
                }
            } else if (MKT_CAM_TYPE_CD.REGULAR.name().equalsIgnoreCase(camInfo.getCampaignTypeCode())) {
                if (chkChnl > 0) {
                    successFlag = true;
                } else {
                    successFlag = false;
                    rtnValue.setMessage("4");
                }
            }
        }

        //채널 발송시간 채크
        if (successFlag) {

            MktCampaignScheduleCheckReqDto reqCamId = new MktCampaignScheduleCheckReqDto();
            reqCamId.setCamId(cscr.getCamId());

            //캠페인에 등록된 채널 타입 반환
            List<MktCampaignScheduleCheckResDto> chnlType = mktCampaignMapper.chnlTypeCheck(reqCamId);

            if (ObjectUtil.isNotEmpty(chnlType)) {
                //채널타입으로 전송시간 체크
                for (MktCampaignScheduleCheckResDto scr : chnlType) {
                    reqCamId.setCamId(cscr.getCamId());
                    reqCamId.setChnlType(scr.getChnlType());

                    //채널 전송시간 체크
                    int scheduleCheck = mktCampaignMapper.chnlTimeValidCheck(reqCamId);

                    if (scheduleCheck > 0) {
                        successFlag = false;
                        rtnValue.setMessage("17");
                        return rtnValue;
                    } else {
                        LogUtil.debug("validation check :: 채널 발송시간  체크");
                    }
                }
            }
        }

        // 대상자 조건
        // - 타겟 캠페인          : 대상자 필수
        // - MASS 캠페인          : 대상자 없어야 함.
        // - 멀티 스테이지 캠페인 : 대상자 없어야 함
        if (successFlag) {

            int checkCamTgtDtl = mktCampaignMapper.checkCamTgtDtl(cscr);

            //타겟 캠페인: 대상자 필수
            if (MKT_CAM_TYPE_CD.TARGET.name().equalsIgnoreCase(camInfo.getCampaignTypeCode())) {

                if (checkCamTgtDtl > 0) {
                    //성공
                    LogUtil.debug("validation check :: 타겟 캠페인 -> 대상자 존재.");
                } else {
                    successFlag = false;
                    rtnValue.setMessage("11");
                }
            }
            //MASS or 멀티 스테이지 캠페인 : 대상자 없어야 함.
            else if (MKT_CAM_TYPE_CD.MASS.name().equalsIgnoreCase(camInfo.getCampaignTypeCode())) {

                if (checkCamTgtDtl > 0) {
                    successFlag = false;
                    rtnValue.setMessage("12");
                } else {
                    //성공
                    LogUtil.debug("validation check :: MASS or 멀티스테이지 캠페인 -> 대상자 없음.");
                }
            }
        }

        //캠페인 워크플로우 노드 데이터 유무 확인
        if (successFlag) {

            //캠페인 워크플로우 테스크 및 데이터 조회
            MktCampaignWorkflowReqDto mcwr = new MktCampaignWorkflowReqDto();
            mcwr.setCampaignId(cscr.getCamId());
            mcwr.setLang(cscr.getLang());

            List<MktCampaignWorkflowStatusListResDto> campaignList = getCampaignWorkflowStatusList(mcwr);

            //캠페인 워크플로우 노드 데이터 유무 확인
            for (MktCampaignWorkflowStatusListResDto data : campaignList) {

                LogUtil.debug("validation check :: Node check = " + data.getTaskTypeCode() + ", " + data.getEnterTime());

                if (data.getEnterTime() == null) {
                    successFlag = false;
                    rtnValue.setMessage("3");
                    break;
                }
            }
        }

        //결제상신에 사용될 경우 승인여부를 체크하지 않는다
        if (successFlag) {

            //승인 여부에 따른 승인 완료 여부
            String checkVal2 = mktCampaignMapper.checkElecAprov(cscr);

            // 승인 완료됨
            if (checkVal2.equals("true")) {
                successFlag = true;
            } else {
                successFlag = false;
                rtnValue.setMessage("2");
            }
        }

        //실행시 실행 일정 확인 후 그에 따른 실행 여부
        if (successFlag) {

            //실행여부
            int checkVal2 = mktCampaignMapper.checkExecItem(cscr);

            // 실행 가능
            if (checkVal2 > 0) {
                successFlag = true;
            } else {
                successFlag = false;
                rtnValue.setMessage("19");
            }
        }

        //타겟팅 활성 여부
        if (successFlag) {

            //실행여부
            int checkVal2 = mktCampaignMapper.checkTgtExecItem(cscr);

            // 실행 가능
            if (checkVal2 > 0) {
                successFlag = true;
            } else {
                successFlag = false;
                rtnValue.setMessage("20");
            }
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_001
     * @name : setCampaignComplete
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst
     * @description : 캠페인 상태 - 활성(완료)
     */
    public StatusResDto setCampaignComplete(MktCampaignDefaultInfoReqDto mcdir) {
        LogUtil.param(this.getClass(), mcdir);

        boolean firstFlag = true;

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        MktCampaignReqDto req = new MktCampaignReqDto();
        req.setSystemColumn(mcdir.getSystemColumn());
        req.setId(mcdir.getId());

        //캠페인 기본정보 조회
        MktCampaignDefaultInfoResDto camInfo = mktCampaignMapper.selectCampaignDefaultInfo(req);

        //활성 권한 조회
        MktCampaignExecutableUserReqDto mceur = new MktCampaignExecutableUserReqDto();
        mceur.setSystemColumn(mcdir.getSystemColumn());
        mceur.setCamId(mcdir.getId());

//		if (isExecutableUser(mceur)) {

        //캠페인 상태가 작성중일 경우만 활성 가능
        if (CAMPAIGN_STATUS_TYPE.W.name().equals(camInfo.getCampaignStatusCode())) {

            //캠페인 상태 확인
            MktCampaignStatusCheckReqDto cscr = new MktCampaignStatusCheckReqDto();
            cscr.setCamId(mcdir.getId());
            //cscr.setUseApproval(false);
            cscr.setType(mcdir.getType());
            rtnValue = campaignStatusCheck(cscr);
            String message = rtnValue.getMessage();

            //캠페인 상태 변경
            if ("true".equals(message)) {

                //프로모션이 아닌 정기캠페인 일 경우 실행정보 설정
                /*
                 * if (MKT_CAM_TYPE_CD.REGULAR.toString().equals(camInfo.getCampaignTypeCode())
                 * && !rtnValue.getSuccess()) { //rtnValue = setRegularExeInfo(req);
                 * rtnValue.setMessage("97"); //일정 등록 실패 }
                 */

                if (rtnValue.getSuccess()) {
                    mcdir.setCampaignStatusCode(CAMPAIGN_STATUS_TYPE.A.name());
                    rtnValue = editCampaignStatus(mcdir);
                }

                if (rtnValue.getSuccess() && MKT_CAM_TYPE_CD.TRIGGER.toString().equals(camInfo.getCampaignTypeCode())) {
                    //API 메시지 전송

                    String apiUrl = BeansUtil.getApplicationProperty("icignal.marketing.realtime-api-url");
                    apiUrl = apiUrl + "/api/v1/handleCampaign";
                    MktRealTimeCampaignReqDto rtc = new MktRealTimeCampaignReqDto();

                    TimeZone time;
                    time = TimeZone.getTimeZone("Asia/Seoul");
                    SimpleDateFormat formYYYYMMDD = new SimpleDateFormat("yyyyMMdd", Locale.KOREAN);
                    SimpleDateFormat formHHMMSS = new SimpleDateFormat("HHmmss", Locale.KOREAN);
                    formYYYYMMDD.setTimeZone(time);
                    formHHMMSS.setTimeZone(time);
                    String day = formYYYYMMDD.format(new Date()); //현재 날짜
                    String timeS = formHHMMSS.format(new Date()); //현재 시각

                    // 이벤트 트리거 이고, 위의 내용이 정상적으로 처리 됐을 경우에만 Executor 로 메시지 전송.
                    RealSndCampaignApiDTO.Request RealCampaignApi = new RealSndCampaignApiDTO.Request();
                    RealCampaignApi.setTrkNo(UUID.randomUUID().toString());
                    RealCampaignApi.setTgNo("RDRC0002");
                    RealCampaignApi.setTrsDate(day);
                    RealCampaignApi.setTrsTime(timeS);
                    RealCampaignApi.setSvcCd(rtc.getProcessCd());//null
                    RealCampaignApi.setExecCd("RUN");
                    RealCampaignApi.setCampNo(camInfo.getDispNo());
                    RealSndCampaignApiDTO.Response res =
                            (RealSndCampaignApiDTO.Response) RestAPIUtil.jsonPost(apiUrl, RealCampaignApi, RealSndCampaignApiDTO.Response.class);
                }
            }
        } else {
            rtnValue.setSuccess(true);
            rtnValue.setMessage("99"); //캠페인 상태가 작성중인 경우에만 활성이 가능합니다.
        }
//		}
//		else {
//			rtnValue.setSuccess(true);
//			rtnValue.setMessage("98");  //실행권환이 없습니다.
//		}

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_001
     * @name : setRegularExeInfo
     * @date : 2018. 02. 28.
     * @author : dg.ryu
     * @table :
     * @description : 실행 정보 등록
     */
    public StatusResDto setRegularExeInfo(MktCampaignExecutionInfoReqDto req) {
        LogUtil.param(this.getClass(), req);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(true);

        MktCampaignExecutionInfoReqDto exeInfoReq = new MktCampaignExecutionInfoReqDto();
        List<MktCampaignExecutionInfoItemReqDto> exeInfoItemList = new ArrayList<>();

        //실해정보 조회
        MktCampaignExecutionInfoResDto exeInfo = mktCampaignMapper.selectExecutionInfoById(req);

        if (ObjectUtil.isNotEmpty(exeInfo) && "REPEAT".equals(exeInfo.getType())) {
            try {
                String exeInfoStartDt = exeInfo.getExeStartDate().substring(0, 10);        //시작일
                String exeInfoEndDt = exeInfo.getExeEndDate().substring(0, 10);            //종료일
                String exeCyclTypeCd = exeInfo.getExeCycleTypeCode();                    //주기유형코드
                String exeMonthTypeCd = exeInfo.getExeMonthTypeCode();                    //실행월유형코드
                String exeDay = exeInfo.getExeDay();                                    //실행일
                String exeHour = exeInfo.getExeHour();                                    //실행시간
                String exeMinute = exeInfo.getExeMinute();                                //실행분
                String exeHHMM = " " + exeHour + ":" + exeMinute + ":00";                //실행시분
                String chnlExeDt = exeInfoStartDt + exeHHMM;                            //실행일시

                boolean fstFlag = true;
                int exeSeq = 1;

                while (true) {

                    //실행정보 아이템 등록
                    MktCampaignExecutionInfoItemReqDto mceiir = new MktCampaignExecutionInfoItemReqDto();

                    //월별
                    if ("M".equals(exeCyclTypeCd)) {

                        if (fstFlag) {
                            //첫 실행일시 설정
                            //말일
                            if ("ML".equals(exeMonthTypeCd)) {
                                chnlExeDt = DateUtil.getLastDayOfMonthDate(chnlExeDt, "yyyy-MM-dd HH:mm:ss");
                            } else {
                                chnlExeDt = exeInfoStartDt.substring(0, 8) + exeDay + exeHHMM;
                            }

                            fstFlag = false;
                        } else {

                            //말일
                            if ("ML".equals(exeMonthTypeCd)) {
                                chnlExeDt = DateUtil.getAddMonthDate(chnlExeDt, 1, "yyyy-MM-dd HH:mm:ss");
                                chnlExeDt = DateUtil.getLastDayOfMonthDate(chnlExeDt, "yyyy-MM-dd HH:mm:ss");
                            } else {
                                //월 더하기
                                chnlExeDt = DateUtil.getAddMonthDate(chnlExeDt.substring(0, 7), 1, "yyyy-MM");
                                chnlExeDt = chnlExeDt + "-" + exeDay + exeHHMM;
                            }
                        }

                        if (DateUtil.formatChk2(chnlExeDt, "yyyy-MM-dd HH:mm:ss") && DateUtil.getCompareToNowDate(chnlExeDt, "yyyy-MM-dd")) {
                            //현재일자 보다 크거나 같은 경우만
                            mceiir.setSystemColumn(req.getSystemColumn());
                            mceiir.setCampaignId(req.getCampaignId());
                            mceiir.setExeInfoId(exeInfo.getId());
                            mceiir.setExeDate(chnlExeDt);
                            mceiir.setExeSeq(String.valueOf(exeSeq));
                            mceiir.setExeInfoStatusCode("W");

                            if (exeInfoEndDt.substring(0, 10).compareTo(chnlExeDt.substring(0, 10)) >= 0) {
                                exeInfoItemList.add(mceiir);

                                exeSeq++;
                            }
                        }
                    }

                    //매일
                    else if ("D".equals(exeCyclTypeCd)) {

                        if (fstFlag) {
                            //첫 실행일시 설정
                            chnlExeDt = exeInfoStartDt.substring(0, 10) + exeHHMM;

                            fstFlag = false;
                        } else {
                            //1일 더하기
                            chnlExeDt = DateUtil.getAddDayDate(chnlExeDt, 1, "yyyy-MM-dd HH:mm:ss");
                        }

                        //현재일자 보다 크거나 같은 경우만
                        if (DateUtil.getCompareToNowDate(chnlExeDt, "yyyy-MM-dd")) {

                            String exeSunYn = exeInfo.getExeSunYn();    //일요일 실해여부
                            String exeMonYn = exeInfo.getExeMonYn();    //월요일 실행여부
                            String exeTueYn = exeInfo.getExeTueYn();    //화요일 실행여부
                            String exeWedYn = exeInfo.getExeWedYn();    //수요일 실행여부
                            String exeThuYn = exeInfo.getExeThuYn();    //목요일 실행여부
                            String exeFriYn = exeInfo.getExeFriYn();    //금요일 실행여부
                            String exeSatYn = exeInfo.getExeSatYn();    //토요일 실행여부

                            //요일 구하기
                            int week = DateUtil.getDayOfWeek(chnlExeDt);

                            boolean exeFlag = false;
                            //일
                            if (week == 1 && "1".equals(exeSunYn)) {
                                exeFlag = true;
                            }
                            //월
                            else if (week == 2 && "1".equals(exeMonYn)) {
                                exeFlag = true;
                            }
                            //화
                            else if (week == 3 && "1".equals(exeTueYn)) {
                                exeFlag = true;
                            }
                            //수
                            else if (week == 4 && "1".equals(exeWedYn)) {
                                exeFlag = true;
                            }
                            //목
                            else if (week == 5 && "1".equals(exeThuYn)) {
                                exeFlag = true;
                            }
                            //금
                            else if (week == 6 && "1".equals(exeFriYn)) {
                                exeFlag = true;
                            }
                            //토
                            else if (week == 7 && "1".equals(exeSatYn)) {
                                exeFlag = true;
                            }

                            if (exeFlag) {

                                //실행정보 아이템 등록
                                mceiir.setSystemColumn(req.getSystemColumn());
                                mceiir.setCampaignId(req.getCampaignId());
                                mceiir.setExeInfoId(exeInfo.getId());
                                mceiir.setExeDate(chnlExeDt);
                                mceiir.setExeSeq(String.valueOf(exeSeq));
                                mceiir.setExeInfoStatusCode("W");

                                if (exeInfoEndDt.substring(0, 10).compareTo(chnlExeDt.substring(0, 10)) >= 0) {
                                    exeInfoItemList.add(mceiir);

                                    exeSeq++;
                                }
                            }
                        }
                    }
                    // 실행정보 종료일자와 실행일자가 같다면 중지
                    if (exeInfoEndDt.substring(0, 10).equals(chnlExeDt.substring(0, 10))) {
                        break;
                    } else if (exeInfoEndDt.substring(0, 10).compareTo(chnlExeDt.substring(0, 10)) < 0) {
                        break;
                    }
                }

                //실행정보 Req 설정
                if (ObjectUtil.isNotEmpty(exeInfo)) {
                    exeInfoReq.setId(exeInfo.getId());
                    exeInfoReq.setExeCycleTypeCode(exeInfo.getExeCycleTypeCode());
                    exeInfoReq.setExecutionInfoItemList(exeInfoItemList);
                }

                MktCampaignExecutionInfoItemReqDto rmvReq = new MktCampaignExecutionInfoItemReqDto();
                rmvReq.setSystemColumn(req.getSystemColumn());
                rmvReq.setCampaignId(req.getCampaignId());

                //기존 실행정보 아이템 삭제
                mktCampaignMapper.deleteExecutionInfoItemByCampaignId(rmvReq);

                //실행정보 등록
                //실행정보아이템 등록
                String exeTargetAmt = mktCampaignMapper.selectTargetCntByCamId(exeInfo.getCampaignId());
                for (MktCampaignExecutionInfoItemReqDto exeInfoItem : exeInfoReq.getExecutionInfoItemList()) {
                    exeInfoItem.setId(commonService.getRowID());
                    exeInfoItem.setExeTargetAmt(exeTargetAmt);

                    mktCampaignMapper.insertExecutionInfoItem(exeInfoItem);
                }

            } catch (Exception e) {
                rtnValue.setSuccess(false);
            }
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P01
     * @name : getTempNodeList
     * @date : 2015. 11. 24.
     * @author : 안형욱
     * @table :mkt.mkt_wf_template_mst,com.wf_task_had,mkt.wf_task_node,com.wf_node_mst,com.comm_Cde
     * @description : 템플릿에 등록된 작업 노드 조회
     */
    public GridPagingResDto<MktCampaignGetTempNodeListResDto> getTempNodeList(MktCampaignGetTempNodeListReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktCampaignGetTempNodeListResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktCampaignMapper.selectTempNodeList(param), AnnotationType.CommCode);
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P01
     * @name : getTemp
     * @date : 2015. 11. 24.
     * @author : 안형욱
     * @table :mkt.mkt_templet_mst, com.comm_code
     * @description : 템플릿 조회
     */
    public GridPagingResDto<MktCampaignGetTempNodeListResDto> getTemp(MktCampaignGetTempNodeListReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktCampaignGetTempNodeListResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktCampaignMapper.selectTemp(param), AnnotationType.CommCode);
    }

    /**
     * @programId : Mkt_MNG_002
     * @name : addCampaignWorkflowStatus
     * @date : 2015. 9. 23.
     * @author : dg.ryu
     * @description : 캠페인 워크플로우 진행현황 등록
     */
    public StatusResDto addCampaignWorkflowStatus(MktCampaignWorkflowStatusReqDto param) {
        LogUtil.param(MktCampaignService.class, param);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        mktCampaignMapper.insertCampaignWorkflowStatus(param);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_002
     * @name : saveCampaignWorkflow
     * @date : 2015. 10. 16.
     * @author : dg.ryu
     * @table :
     * @description : 캠페인 워크플로우 진행현황 및 데이터 저장
     */
    public StatusResDto saveCampaignWorkflow(MktCampaignWorkflowReqDto mcwr) {
        LogUtil.param(this.getClass(), mcwr);

        String lang = mcwr.getLang();

        boolean saveFlag = true;
        //캠페인 상태 저장여부 확인
        if (WORKFLOW_SAVE_TYPE.WF.name().equals(mcwr.getSaveType())) {
            //확인 후 예외 Exception
            checkCampaignStatusSaveFlag(mcwr.getCampaignId(), CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INFO.name());
        } else if (WORKFLOW_SAVE_TYPE.NODE.name().equals(mcwr.getSaveType())) {
            //확인 후 예외 false 반환
            MktCampaignReqDto mcr = new MktCampaignReqDto();
            mcr.setId(mcwr.getCampaignId());
            mcr.setNodeType(CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INFO.name());

            saveFlag = checkCampaignStatusSaveFlag(mcr);
        } else {
            saveFlag = false;
        }

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(true);

        String workflowId = "";

        //저장여부 확인
        if (saveFlag) {
            if (ObjectUtil.isNotEmpty(mcwr.getWorkflowTask())) {
                //워크플로우 전체 테스크 저장(헤더/노드/커넥터)
                WorkflowTaskReqDto mwtr = mcwr.getWorkflowTask();
                mwtr.setLang(lang);
                mwtr.setCreateBy(mcwr.getCreateBy());
                mwtr.setModifyBy(mcwr.getModifyBy());

                rtnValue = workflowService.saveWorkflowTask(mwtr);
                saveFlag = rtnValue.getSuccess();
                workflowId = rtnValue.getMessage();
                mcwr.setWorkflowId(workflowId);
            } else {
                saveFlag = false;
            }
        }

        //저장여부 확인
        if (saveFlag) {
            //this.startTransaction();

            //캠페인 워크플로우 진핸현황 전체 삭제 처리 후 업데이트한다.
            MktCampaignWorkflowStatusReqDto mcwsr = new MktCampaignWorkflowStatusReqDto();
            mcwsr.setLang(lang);
            mcwsr.setCreateBy(mcwr.getCreateBy());
            mcwsr.setModifyBy(mcwr.getModifyBy());
            mcwsr.setCampaignId(mcwr.getCampaignId());    //캠페인 ID
            mcwsr.setWorkflowId(mcwr.getWorkflowId());    //워크플로우 ID
            mktCampaignMapper.deleteAllCampaignWorkflowStatusByWorkflowId(mcwsr);

            for (MktCampaignWorkflowNodeDataReqDto mcwndr : mcwr.getNodeList()) {


                LogUtil.debug(" --------------------->> NODE : " + mcwndr.getTaskType());

                //캠페인 데이터 유형 확인 후 각각 등록/수정한다.
				/*if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INFO.name().equals(mcwndr.getTaskType())
                            && ObjectUtil.isNotEmpty(mcwndr.getData().getCampaignDefaultInfo())) {

				 * 캠페인 기본정보 저장
				 * INFO

                        MktCampaignDefaultInfoReqDto mcdir = mcwndr.getData().getCampaignDefaultInfo();
                        mcdir.setCreateBy(mcwr.getCreateBy());
                        mcdir.setModifyBy(mcwr.getModifyBy());
                        mcdir.setAccountId(mcwr.getAccountId());
                        mcdir.setId(mcwr.getCampaignId());
                        //캠페인 아이디 확인
                        if (mktCampaignMapper.selectCampaignIdCheck(mcdir) > 0) {
                            rtnValue = mktCampaignMapper.updateCampaignMaster(mcdir);
                        } else {
                            rtnValue = mktCampaignMapper.insertCampaignMaster(mcdir);
                            mcwsr.setCampaignId(rtnValue.getMessage());
                            mcwr.setCampaignId(rtnValue.getMessage());
                        }

                    }*/
                if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.SCHEDULE.name().equals(mcwndr.getTaskType())
                        && ObjectUtil.isNotEmpty(mcwndr.getData().getCampaignExecutionInfo())) {
                    /*
                     * 캠페일 실행정보 저장
                     * SCHEDULE
                     */
                    MktCampaignExecutionInfoReqDto mceir = mcwndr.getData().getCampaignExecutionInfo();
                    mceir.setLang(lang);
                    mceir.setCreateBy(mcwr.getCreateBy());
                    mceir.setModifyBy(mcwr.getModifyBy());
                    mceir.setCampaignId(mcwndr.getActualTaskId());
                    mceir.setDataStatus(mcwndr.getTaskDataStatus());

                    //노드의 캠페인ID 없거나 데이터 상태가 'D'이면 해당 업무 데이터 삭제
                    if (ObjectUtil.isEmpty(mcwndr.getCampaignId()) || TASK_DATA_STATUS.D.name().equals(mcwndr.getTaskDataStatus())) {
                        //캠페인 실행정보 삭제
                        rtnValue = removeExecutionInfoByCampaignId(mceir);

                        //캠페인 실행정보/아이템 삭제
                        rtnValue = removeExecutionInfo(mceir);

                        //실행정보 아이템과 대상자 상세 관계 초기화 - 실행정보 아이템 상태가 발송완료(D)가 아닌것
                        //rtnValue = mktCampaignMapper.deleteTargetDtlExecutionInfoItemRel(mceir);
                        mcwndr.setActualTaskId(null);
                    }

                    //노드의 이전 캠페인 ID와 현재 캠페인 ID가 틀리다면 이전 캠페인 업무 데이터 삭제
                    if (ObjectUtil.isNotEmpty(mcwndr.getOldCampaignId()) && !mcwndr.getOldCampaignId().equals(mcwndr.getCampaignId())) {
                        //캠페인 실행정보 삭제
                        rtnValue = removeExecutionInfoByCampaignId(mceir);

                        //캠페인 실행정보/아이템 삭제
                        rtnValue = removeExecutionInfo(mceir);

                        //실행정보 아이템과 대상자 상세 관계 초기화 - 실행정보 아이템 상태가 발송완료(D)가 아닌것
                        //rtnValue = mktCampaignMapper.deleteTargetDtlExecutionInfoItemRel(mceir);
                    }
                }
                if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.TARGET.name().equals(mcwndr.getNodeType())) {
                    /*
                     * 캠페인 대상자
                     * TARGET
                     */
                    MktCampaignTargetReqDto mctr = new MktCampaignTargetReqDto();
                    mctr.setLang(lang);
                    mctr.setCreateBy(mcwr.getCreateBy());
                    mctr.setModifyBy(mcwr.getModifyBy());
                    mctr.setCampaignId(mcwndr.getCampaignId());

                    //노드의 캠페인ID 없거나 데이터 상태가 'D'이면 해당 업무 데이터 삭제
                    if (ObjectUtil.isEmpty(mcwndr.getCampaignId()) || TASK_DATA_STATUS.D.name().equals(mcwndr.getTaskDataStatus())) {
                        rtnValue = removeCampaignTargetByCampaignId(mctr);
                        mcwndr.setActualTaskId(null);
                    }

                    //노드의 이전 캠페인 ID와 현재 캠페인 ID가 틀리다면 이전 캠페인 업무 데이터 삭제
                    if (ObjectUtil.isNotEmpty(mcwndr.getOldCampaignId()) && !mcwndr.getOldCampaignId().equals(mcwndr.getCampaignId())) {
                        rtnValue = removeCampaignTargetByCampaignId(mctr);
                    }
                }

                if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.SMS.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.LMS.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.MMS.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.PUSH.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.EMAIL.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.CALL.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INSTAGRAM.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.FACEBOOK.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.TERMINAL.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.WEB.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.KAKAO.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.KAKAONOTICE.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.RECEIPT.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.APPNOTICE.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.TM.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.KAKAONOTI.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.KAKAOFR.name().equals(mcwndr.getTaskType())
                ) {
                    /*
                     * 캠페인 채널 관계 저장
                     * SMS, LMS, MMS, PUSH, EMAIL, CALL
                     */
                    MktCampaignContentsChnnelRelReqDto mcccrr = new MktCampaignContentsChnnelRelReqDto();
                    mcccrr.setLang(lang);
                    mcccrr.setCreateBy(mcwr.getCreateBy());
                    mcccrr.setModifyBy(mcwr.getModifyBy());
                    mcccrr.setCampaignId(mcwndr.getCampaignId());
                    mcccrr.setChnnelTypeCode(mcwndr.getTaskType());
                    mcccrr.setId(mcwndr.getActualTaskId());

                    //노드의 캠페인ID 없거나 데이터 상태가 'D'이면 해당 업무 데이터 삭제
                    if (ObjectUtil.isEmpty(mcwndr.getCampaignId())
                            || TASK_DATA_STATUS.D.name().equals(mcwndr.getTaskDataStatus())) {

                        //캠페인 콘텐츠 채널 관계 삭제
                        rtnValue = removeCampaignContentsChnnelRel(mcccrr);
                        mcwndr.setActualTaskId(null);
                    } else {
                        //노드의 이전 캠페인 ID와 현재 캠페인 ID가 틀리다면 이전 캠페인 업무 데이터 삭제
                        if (ObjectUtil.isNotEmpty(mcwndr.getOldCampaignId())
                                && !mcwndr.getOldCampaignId().equals(mcwndr.getCampaignId())) {

                            //캠페인 콘텐츠 채널 관계 삭제
                            rtnValue = removeCampaignContentsChnnelRel(mcccrr);
                        }
                    }
                }

                if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.ETCOND.name().equals(mcwndr.getTaskType())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.MSCOND.name().equals(mcwndr.getTaskType())) {
                    /*
                     * et 조건
                     * ETCOND
                     */
                    MktETCampaignNodeReqDto ecnr = new MktETCampaignNodeReqDto();
                    ecnr.setRid(mcwndr.getActualTaskId());
                    ecnr.setSystemColumn(mcwr.getSystemColumn());

                    //노드의 캠페인ID 없거나 데이터 상태가 'D'이면 해당 업무 데이터 삭제
                    if (ObjectUtil.isEmpty(mcwndr.getCampaignId()) || TASK_DATA_STATUS.D.name().equals(mcwndr.getTaskDataStatus())) {
                        rtnValue = saveETCampaignCond(ecnr);
                        mcwndr.setActualTaskId(null);
                    }
                }

                if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.ETACT.name().equals(mcwndr.getTaskType())) {
                    /*
                     * et 활동
                     * ETACT
                     */
                    MktETCampaignNodeReqDto ecnr = new MktETCampaignNodeReqDto();
                    ecnr.setRid(mcwndr.getActualTaskId());
                    ecnr.setSystemColumn(mcwr.getSystemColumn());

                    //노드의 캠페인ID 없거나 데이터 상태가 'D'이면 해당 업무 데이터 삭제
                    if (ObjectUtil.isEmpty(mcwndr.getCampaignId())
                            || TASK_DATA_STATUS.D.name().equals(mcwndr.getTaskDataStatus())) {
                        rtnValue = saveETCampaignAct(ecnr);
                        mcwndr.setActualTaskId(null);
                    }
                }

                if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.WAIT.name().equals(mcwndr.getTaskType())) {
                    /*
                     * Wait
                     * WAIT
                     */
                    MktETCampaignNodeReqDto ecnr = new MktETCampaignNodeReqDto();
                    ecnr.setRid(mcwndr.getActualTaskId());
                    ecnr.setSystemColumn(mcwr.getSystemColumn());

                    //노드의 캠페인ID 없거나 데이터 상태가 'D'이면 해당 업무 데이터 삭제
                    if (ObjectUtil.isEmpty(mcwndr.getCampaignId())
                            || TASK_DATA_STATUS.D.name().equals(mcwndr.getTaskDataStatus())) {
                        MktCampaignWaitReqDto cwr = new MktCampaignWaitReqDto();
                        cwr.setId(mcwndr.getActualTaskId());

                        rtnValue = removeCampaignWait(cwr);
                        mcwndr.setActualTaskId(null);
                    }
                }

                /*
                 * 캠페인 워크플로우 진행현황 등록
                 */
                if (!TASK_DATA_STATUS.D.name().equals(mcwndr.getTaskDataStatus())) {
                    mcwsr.setLang(lang);
                    mcwsr.setCampaignId(mcwndr.getCampaignId());
                    mcwsr.setTaskId(mcwndr.getTaskId());    //테스크아이디
                    mcwsr.setTaskName(mcwndr.getNodeName());    //테스크명
                    mcwsr.setStatusCode(mcwr.getStatusCode());    //상태
                    mcwsr.setTaskTypeCode(mcwndr.getTaskType());    //테스크유형
                    mcwsr.setActualTaskId(mcwndr.getActualTaskId());    //실제업무 ID
                    mcwsr.setId(mcwndr.getCampaignWfRelId());
                    mcwsr.setParTaskId(mcwndr.getParTaskId());
                    mcwsr.setCnctrTypeCd(mcwndr.getCnctrTypeCd());

                    if (ObjectUtil.isEmpty(mcwsr.getId())) {
                        String id = commonService.getRowID();
                        mcwsr.setId(id);
                        mktCampaignMapper.insertCampaignWorkflowStatus(mcwsr);
                    } else {
                        mktCampaignMapper.updateCampaignWorkflowStatus(mcwsr);
                    }
                }
            }

            //캠페인 워크플로우 관계 설정
            mktCampaignMapper.updateCampaignWorkflowRel(mcwr);

            //템플릿 설정일경우 워크플로우 관계 설정
            MktCampaignWorkflowTemplateReqDto mcwtr = new MktCampaignWorkflowTemplateReqDto();
            mcwtr.setLang(lang);
            mcwtr.setCampaignId(mcwr.getCampaignId());
            mcwtr.setModifyBy(mcwr.getModifyBy());
            mcwtr.setWorkflowId(mcwr.getWorkflowId());
            mktCampaignMapper.updateCampaignWorkflowTemplate(mcwtr);

            //this.commitTransaction();

        }

        //캠페인 및 워크플로우 아이디 반환(JSON Text)
        String rtnText = "{'campaignId' : '" + mcwr.getCampaignId() + "', 'workflowId' : '" + workflowId + "'}";
        rtnValue.setMessage(rtnText);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : MKT_MNG_P05
     * @name : removeCampaignContentsChnnelRel
     * @date : 2015. 11. 27.
     * @author : "류동균"
     * @table : mkt.mkt_conts_chnl_rel
     * @description : 캠페인 콘텐츠 채널 관계 삭제
     */
    public StatusResDto removeCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr) {
        LogUtil.param(this.getClass(), mcccrr);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        //콘텐츠 채널 관계 삭제
        mktCampaignMapper.deleteCampaignContentsChnnelRel(mcccrr);

        //콘텐츠 삭제
        //mktCampaignMapper.deleteCampaignContents(mcccrr);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : MKT_MNG_P08
     * @name : removeExecutionInfoByCampaignId
     * @date : 2015. 11. 2.
     * @author : 류동균
     * @table : mkt.mkt_exe_info
     * @description : 실행정보 삭제 By CampaignId
     */
    public StatusResDto removeExecutionInfoByCampaignId(MktCampaignExecutionInfoReqDto mceir) {
        LogUtil.param(this.getClass(), mceir);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        //실행정보 삭제
        mktCampaignMapper.deleteExecutionInfoByCampaignId(mceir);

        //실행정보 아이템 삭제
        MktCampaignExecutionInfoItemReqDto mceiir = new MktCampaignExecutionInfoItemReqDto();
        mceiir.setSystemColumn(mceir.getSystemColumn());
        mceiir.setCampaignId(mceir.getCampaignId());
        mktCampaignMapper.deleteExecutionInfoItemByCampaignId(mceiir);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : MKT_MNG_P08
     * @name : removeExecutionInfo
     * @date : 2015. 11. 2.
     * @author : 류동균
     * @table : mkt.mkt_exe_info
     * @description : 실행정보 삭제
     */
    public StatusResDto removeExecutionInfo(MktCampaignExecutionInfoReqDto mceir) {
        LogUtil.param(this.getClass(), mceir);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        //실행정보 삭제
        mktCampaignMapper.deleteExecutionInfo(mceir);

        //실행정보 아이템 삭제
        MktCampaignExecutionInfoItemReqDto mceiir = new MktCampaignExecutionInfoItemReqDto();
        mceiir.setSystemColumn(mceir.getSystemColumn());
        mceiir.setExeInfoId(mceir.getId());
        mktCampaignMapper.deleteExecutionInfoItemByExeInfoId(mceiir);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_002
     * @name : getCampaignWorkflowStatusList
     * @date : 2015. 10. 19.
     * @author : dg.ryu
     * @table :
     * @description : 캠페인 워크플로우 진행현황 및 데이터 조회
     */
    public List<MktCampaignWorkflowStatusListResDto> getCampaignWorkflowStatusList(MktCampaignWorkflowReqDto mcwr) {
        LogUtil.param(this.getClass(), mcwr);

        String lang = mcwr.getLang();

        //캠페인 진행현황 목록
        List<MktCampaignWorkflowStatusListResDto> resultList = new ArrayList<MktCampaignWorkflowStatusListResDto>();

        MktCampaignWorkflowStatusReqDto mcwsr = new MktCampaignWorkflowStatusReqDto();
        mcwsr.setLang(lang);
        mcwsr.setCampaignId(mcwr.getCampaignId());
        mcwsr.setWorkflowId(mcwr.getWorkflowId());

        for (MktCampaignWorkflowStatusListResDto status : mktCampaignMapper.selectCampaignWorkflowStatusList(mcwsr)) {
            MktCampaignWorkflowDataResDto data = new MktCampaignWorkflowDataResDto();
            if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INFO.name().equals(status.getTaskTypeCode())) {
                /*
                 * 캠페인 기본정보
                 * INFO
                 */
                MktCampaignReqDto mcr = new MktCampaignReqDto();
                mcr.setId(mcwr.getCampaignId());
                data.setCampaignDefaultInfo(mktCampaignMapper.selectCampaignDefaultInfo(mcr));

                //상태 정보 설정
                if (ObjectUtil.isNotEmpty(data.getCampaignDefaultInfo())) {
                    //제목 설정
                    status.setTitle(data.getCampaignDefaultInfo().getCampaignName());
                    //내용 설정
                    status.setText(data.getCampaignDefaultInfo().getCampaignName());
                    //최근 입력시간 설정
                    String date = data.getCampaignDefaultInfo().getModifyDate();
                    long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm", date, "yyyy-MM-dd HH:mm");
                    status.setEnterTime(Long.toString(time));

                    //데이터 설정
                    status.setData(data);
                }
            } else if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.TARGET.name().equals(status.getNodeTypeCode())) {
                /*
                 * 캠페인 대상자
                 * TARGET
                 */
                MktCampaignTargetReqDto mctr = new MktCampaignTargetReqDto();
                mctr.setLang(lang);
                mctr.setCampaignId(mcwr.getCampaignId());
                List<MktCampaignTargetListResDto> campaignTargetList = new ArrayList<MktCampaignTargetListResDto>();

                mctr.init(DB_TYPE.ORACLE);

                campaignTargetList = mktCampaignMapper.selectCampaignTargetList2(mctr);

                //상태 정보 설정
                if (ObjectUtil.isNotEmpty(campaignTargetList)) {
                    //내용 설정
                    status.setText(campaignTargetList.get(0).getSegmentName());
                    //최근 입력시간 설정
                    String date = campaignTargetList.get(0).getModifyDate();
                    long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm", date, "yyyy-MM-dd HH:mm");
                    status.setEnterTime(Long.toString(time));

                    //데이터 설정
                    //status.setData(data);
                }
            } else if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.SCHEDULE.name().equals(status.getNodeTypeCode())) {
                /*
                 * 캠페인 실행정보
                 * SCHEDULE
                 */
                MktCampaignExecutionInfoReqDto mceir = new MktCampaignExecutionInfoReqDto();
                mceir.setLang(lang);
                mceir.setCampaignId(mcwr.getCampaignId());
                MktCampaignExecutionInfoResDto campaignExecutionInfo = new MktCampaignExecutionInfoResDto();
                campaignExecutionInfo = mktCampaignMapper.selectExecutionInfo(mceir);

                //실행정보 아이템 목록
                if (ObjectUtil.isNotEmpty(campaignExecutionInfo)) {
                    MktCampaignExecutionInfoItemReqDto mceiir = new MktCampaignExecutionInfoItemReqDto();
                    mceiir.setExeInfoId(campaignExecutionInfo.getId());
                    List<MktCampaignExecutionInfoItemListResDto> executionInfoItemList = new ArrayList<MktCampaignExecutionInfoItemListResDto>();
                    executionInfoItemList = mktCampaignMapper.selectExecutionInfoItemList2(mceiir);

                    campaignExecutionInfo.setExecutionInfoItemList(executionInfoItemList);
                }

                data.setCampaignExecutionInfo(campaignExecutionInfo);

                //상태 정보 설정
                if (ObjectUtil.isNotEmpty(data.getCampaignExecutionInfo())) {
                    //최근 입력시간 설정
                    String date = data.getCampaignExecutionInfo().getModifyDate();
                    long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm", date, "yyyy-MM-dd HH:mm");
                    status.setEnterTime(Long.toString(time));

                    //데이터 설정
                    //status.setData(data);
                }
            } else if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.SMS.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.LMS.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.MMS.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.PUSH.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.EMAIL.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.CALL.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INSTAGRAM.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.FACEBOOK.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.TERMINAL.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.WEB.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.KAKAO.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.KAKAONOTICE.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.RECEIPT.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.APPNOTICE.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.TM.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.KAKAOFR.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.KAKAONOTI.name().equals(status.getTaskTypeCode())
            ) {
                /*
                 * 캠페인 콘텐츠 채널 관계
                 * SMS, LMS, MMS, PUSH, EMAIL, CALL, FACEBOOK
                 */
                MktCampaignContentsChnnelRelReqDto mcccrr = new MktCampaignContentsChnnelRelReqDto();
                mcccrr.setLang(lang);
                mcccrr.setCampaignId(mcwr.getCampaignId());
                mcccrr.setId(status.getActualTaskId());
                data.setCampaignContents(mktCampaignMapper.selectCampaignContentsChnnelRel(mcccrr));

                //상태 정보 설정
                if (ObjectUtil.isNotEmpty(data.getCampaignContents())) {
                    //내용 설정
                    status.setText(data.getCampaignContents().getContentsName());
                    //최근 입력시간 설정
                    String date = data.getCampaignContents().getModifyDate();
                    long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm", date, "yyyy-MM-dd HH:mm");
                    status.setEnterTime(Long.toString(time));

                    //데이터 설정
                    //status.setData(data);
                }
            } else if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.ETCOND.name().equals(status.getTaskTypeCode())
                    || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.MSCOND.name().equals(status.getTaskTypeCode())) {
                /*
                 * et 조건
                 * ETCOND
                 */
                MktETCampaignNodeReqDto ecnr = new MktETCampaignNodeReqDto();
                ecnr.setSystemColumn(mcwr.getSystemColumn());
                ecnr.setRid(status.getActualTaskId());

                MktETCampaignNodeResDto etCampaignCond = new MktETCampaignNodeResDto();
                etCampaignCond = getETCampaignCond(ecnr);
                data.setEtCampaignCond(etCampaignCond);

                //상태 정보 설정
                if (ObjectUtil.isNotEmpty(data.getEtCampaignCond())) {
                    //title
                    status.setTitle(data.getEtCampaignCond().getTitle());

                    //text
                    status.setText(data.getEtCampaignCond().getTitle());

                    //최근 입력시간 설정
                    String date = data.getEtCampaignCond().getModifyDate();
                    long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm", date, "yyyy-MM-dd HH:mm");
                    status.setEnterTime(Long.toString(time));

                    //데이터 설정
                    //status.setData(data);
                }
            } else if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.ETACT.name().equals(status.getTaskTypeCode())) {
                /*
                 * et 활동
                 * ETACT
                 */
                MktETCampaignNodeReqDto ecnr = new MktETCampaignNodeReqDto();
                ecnr.setSystemColumn(mcwr.getSystemColumn());
                ecnr.setRid(status.getActualTaskId());

                MktETCampaignNodeResDto etCampaignAct = new MktETCampaignNodeResDto();
                etCampaignAct = getETCampaignAct(ecnr);
                data.setEtCampaignAct(etCampaignAct);

                //상태 정보 설정
                if (ObjectUtil.isNotEmpty(data.getEtCampaignAct())) {
                    //title
                    status.setTitle(data.getEtCampaignAct().getTitle());

                    //text
                    status.setText(data.getEtCampaignAct().getTitle());

                    //최근 입력시간 설정
                    String date = data.getEtCampaignAct().getModifyDate();
                    long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm", date, "yyyy-MM-dd HH:mm");
                    status.setEnterTime(Long.toString(time));

                    //데이터 설정
                    //status.setData(data);
                }
            } else if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.WAIT.name().equals(status.getTaskTypeCode())) {
                /*
                 * Wait
                 * WAIT
                 */
                MktCampaignWaitReqDto camWaitReq = new MktCampaignWaitReqDto();
                camWaitReq.setSystemColumn(mcwr.getSystemColumn());
                camWaitReq.setId(status.getActualTaskId());

                MktCampaignWaitResDto camWaitRes = new MktCampaignWaitResDto();
                camWaitRes = getCampaignWait(camWaitReq);

                //상태 정보 설정
                if (ObjectUtil.isNotEmpty(camWaitRes)) {
                    String text = "";
                    if (ObjectUtil.isNotEmpty(camWaitRes.getExeDt())) {
                        text = camWaitRes.getExeDt().substring(0, 4) + "-" + camWaitRes.getExeDt().substring(4, 6) + "-" + camWaitRes.getExeDt().substring(6, 8) + " " + camWaitRes.getExeTm().substring(0, 2) + ":" + camWaitRes.getExeTm().substring(2, 4);
                    }

                    //text
                    status.setText(text);

                    //최근 입력시간 설정
                    String date = camWaitRes.getModifyDate();
                    long time = DateUtil.getComputedDate(DateUtil.getToday("yyyy-MM-dd HH:mm"), "yyyy-MM-dd HH:mm", date, "yyyy-MM-dd HH:mm");
                    status.setEnterTime(Long.toString(time));

                    //데이터 설정
                    //status.setData(data);
                }
            }

            resultList.add(status);
        }

        return resultList;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P02
     * @name : getCampaignDefaultInfo
     * @date : 2015. 10. 16.
     * @author : dg.ryu
     * @table :
     * @description : 캠페인 기본정보 조회
     */
    public MktCampaignDefaultInfoResDto getCampaignDefaultInfo(MktCampaignReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        return mktCampaignMapper.selectCampaignDefaultInfo(mcr);
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P13
     * @name : getCampaignProgramList
     * @date : 2015. 10. 27.
     * @author : dg.ryu
     * @table : mkt.mkt_prog
     * @description : 캠페인 프로그램 목록 조회
     */
    public GridPagingResDto<MktCampaignProgramListResDto> getCampaignProgramList(MktCampaignProgramReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktCampaignProgramListResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktCampaignMapper.selectCampaignProgramList(param), AnnotationType.CommCode);
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P13
     * @name : addCampaignProgram
     * @date : 2015. 10. 27.
     * @author : dg.ryu
     * @table : mkt.mkt_prog
     * @description : 캠페인 프로그램 등록
     */
    public StatusResDto addCampaignProgram(MktCampaignProgramReqDto mcpr) {
        LogUtil.param(this.getClass(), mcpr);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        String id = commonService.getRowID();
        mcpr.setId(id);

        String campaignProgramNo = mktCampaignMapper.selectCampaignProgNo(mcpr);
        mcpr.setCampaignProgramNo(campaignProgramNo);

        mktCampaignMapper.insertCampaignProgram(mcpr);

        rtnValue.setSuccess(false);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P13
     * @name : removeCampaignProgram
     * @date : 2015. 10. 27.
     * @author : dg.ryu
     * @table : mkt.mkt_prog
     * @description : 캠페인 프로그램 삭제
     */
    public StatusResDto removeCampaignProgram(MktCampaignProgramReqDto mcpr) {
        LogUtil.param(this.getClass(), mcpr);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        mktCampaignMapper.deleteCampaignProgram(mcpr);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_002
     * @name : saveCampaignDefaultInfo
     * @date : 2015. 10. 28.
     * @author : dg.ryu
     * @table :
     * @description : 캠페인기본정보 저장
     */
    public StatusResDto saveCampaignDefaultInfo(MktCampaignDefaultInfoReqDto mcdir) {
        LogUtil.param(this.getClass(), mcdir);
//        if (mcdir.getPrmsExceptYn().equals("N")) {
//            mcdir.setFatigueExceptYn("N");
//        } else {
//            mcdir.setFatigueExceptYn("Y");
//        }
        //캠페인 상태 저장여부 확인
        //checkCampaignStatusSaveFlag(mcdir.getId(), CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INFO.name());

        //캠페인 상태 저장여부 확인
        MktCampaignReqDto mcr = new MktCampaignReqDto();
        mcr.setId(mcdir.getId());
        mcr.setNodeType(CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.INFO.name());
        boolean saveFlag = checkCampaignStatusSaveFlag(mcr);

        StatusResDto rtnValue = new StatusResDto(false, "");
        //캠페인 상태 저장여부 true  기본정보 전체 저장
        //캠페인 상태 정장여부 false 기본정보 비고 수정
        if (saveFlag) {
            //mcdir.setType("MKT");
            //캠페인아이디 확인
            if (ObjectUtil.isNotEmpty(mcdir.getId())) {
                //수정
                mktCampaignMapper.updateCampaignMaster(mcdir);
                rtnValue.setMessage(mcdir.getId());
            } else {
                //등록

                String id = commonService.getRowID();
                mcdir.setId(id);

                mktCampaignMapper.insertCampaignMaster(mcdir);
                rtnValue.setMessage(id);
            }
        } else {
            //캠페인 기본정보 비고 수정
            mktCampaignMapper.updateCampaignMaster(mcdir);
            rtnValue.setMessage(mcdir.getId());
        }

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P05
     * @name : getCampaignContentsChnnelRel
     * @date : 2015. 11. 27.
     * @author : "dg.ryu"
     * @table : mkt.mkt_conts_chnl_rel
     * @description : 캠페인 콘텐츠 채널 관계 조회
     */
    public MktCampaignContentsChnnelRelResDto getCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr) {
        LogUtil.param(this.getClass(), mcccrr);

        return mktCampaignMapper.selectCampaignContentsChnnelRel(mcccrr);
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P05
     * @name : saveCampaignContentsChnnelRel
     * @date : 2015. 11. 27.
     * @author : "dg.ryu"
     * @table : mkt.mkt_conts_chnl_rel
     * @description : 캠페인 콘텐츠 채널 관계 저장
     */
    public StatusResDto saveCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr) {
        LogUtil.param(this.getClass(), mcccrr);

        //캠페인 상태 저장여부 확인
        checkCampaignStatusSaveFlag(mcccrr.getCampaignId(), mcccrr.getChnnelTypeCode());

        StatusResDto rtnValue = new StatusResDto();

        //캠페인 콘텐츠 채널 관계 삭제 By Campaign ID
        rtnValue = removeCampaignContentsChnnelRel(mcccrr);

        if ((TASK_DATA_STATUS.I.name().equals(mcccrr.getDataStatus())
                || TASK_DATA_STATUS.U.name().equals(mcccrr.getDataStatus()))
                && ObjectUtil.isNotEmpty(mcccrr.getCampaignId())) {
            if (ObjectUtil.isNotEmpty(mcccrr.getId())) {
                //캠페인 콘텐츠 채널 관계 수정
                rtnValue = editCampaignContentsChnnelRel(mcccrr);
                rtnValue.setMessage(mcccrr.getId());
            } else {
                //캠페인 콘텐츠 채널 관계 등록
                rtnValue = addCampaignContentsChnnelRel(mcccrr);
            }
        }

        int rtnOfferCheckData = mktCampaignMapper.checkContentOffer(mcccrr);

        if(rtnOfferCheckData > 0){
            mktCampaignMapper.updateOfferWaitStatus(mcccrr);
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId : MKT_MNG_P05
     * @name : addCampaignContentsChnnelRel
     * @date : 2015. 11. 27.
     * @author : "류동균"
     * @table : mkt.mkt_conts_chnl_rel
     * @description : 캠페인 콘텐츠 채널 관계 등록
     */
    public StatusResDto addCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr) {
        LogUtil.param(this.getClass(), mcccrr);

        StatusResDto rtnValue = new StatusResDto(false, "");
        String id = commonService.getRowID();
        mcccrr.setId(id);

        mktCampaignMapper.insertCampaignContentsChnnelRel(mcccrr);

        rtnValue.setSuccess(true);
        rtnValue.setMessage(id);


        return rtnValue;
    }

    /**
     * @return :
     * @programId : MKT_MNG_P05
     * @name : editCampaignContentsChnnelRel
     * @date : 2015. 11. 27.
     * @author : "류동균"
     * @table : mkt.mkt_conts_chnl_rel
     * @description : 캠페인 콘텐츠 채널 관계 수정
     */
    public StatusResDto editCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr) {
        LogUtil.param(this.getClass(), mcccrr);

        StatusResDto rtnValue = new StatusResDto(false, "");

        //콘텐츠 채널 관계 수정
        mktCampaignMapper.updateCampaignContentsChnnelRel(mcccrr);

        //콘텐츠 수정
        mktCampaignMapper.updateCampaignContents(mcccrr);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P06
     * @name : getCampaignTargetTotalCount
     * @date : 2015. 11. 16.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had
     * @description : 대상자 헤더 대상 전체 건수
     */
    public MktCampaignTargetTotalCountResDto getCampaignTargetTotalCount(MktCampaignTargetReqDto mctr) {
        LogUtil.param(this.getClass(), mctr);

        return mktCampaignMapper.selectCampaignTargetTotalCount(mctr);
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P06
     * @name : getCampaignTarget
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had
     * @description : 대상자 헤더
     */
    public MktCampaignTargetResDto getCampaignTarget(MktCampaignTargetReqDto param) {
        LogUtil.param(this.getClass(), param);

        return mktCampaignMapper.selectCampaignTarget(param);
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P06
     * @name : getCampaignTargetList
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had
     * @description : 대상자 헤더 목록
     */
    public GridPagingResDto<MktCampaignTargetListResDto> getCampaignTargetList(MktCampaignTargetReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktCampaignTargetListResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktCampaignMapper.selectCampaignTargetList(param), AnnotationType.CommCode);
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P06
     * @name : getCampaignTargetDtlList
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_dtl
     * @description : 대상자 상세 목록
     */
    public GridPagingResDto<MktCampaignTargetDtlReqDto> getCampaignTargetDtlList(MktCampaignTargetDtlReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktCampaignTargetDtlReqDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktCampaignMapper.selectCampaignTargetDtlList(param), AnnotationType.CommCode);
    }

    /**
     * @programId :
     * @name : getTargetId
     * @date : 2018. 4. 24.
     * @author : jh.kim
     * @table :
     * @description : 캠페인ID로 타겟헤더ID조회
     */
    public String getCampaignTargetHadId(String param) {
        LogUtil.param(this.getClass(), param);

        return mktCampaignMapper.selectCampaignTargetHadId(param);
    }

    ;

    /**
     * @programId :
     * @name : getTargetId
     * @date : 2018. 4. 24.
     * @author : jh.kim
     * @table :
     * @description : 캠페인 타겟 헤더 등록
     */
    public StatusResDto saveCampaignTarget(MktCampaignTgtHadReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto(false, "");

        //기존 캠페인 타겟팅 정보 삭제
        String targetingHadId = mktCampaignMapper.selectCampaignTargetHadId(param.getCamId());

        if (ObjectUtil.isNotEmpty(targetingHadId)) {
            MktCampaignTargetReqDto mctr = new MktCampaignTargetReqDto();
            mctr.setSystemColumn(param.getSystemColumn());
            mctr.setId(targetingHadId);

            this.removeCampaignTarget(mctr);
        }

        String targetId = commonService.getRowID();
        param.setTargetId(targetId);

        // 대상자 헤더 저장
        mktCampaignMapper.insertCampaignTargetHad(param);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @programId :
     * @name : getTargetId
     * @date : 2018. 4. 24.
     * @author : jh.kim
     * @table :
     * @description : 캠페인 대상자 헤더 제거 컬럼 Count
     */
    public StatusResDto updateCampaignTargetDelCount(MktCampaignTargetReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto(false, "");

        mktCampaignMapper.updateCampaignTargetDelCount(param);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P06
     * @name : removeCampaignTarget
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had, mkt.mkt_tgt_dtl
     * @description : 캠페인대상 삭제
     */
    public StatusResDto removeCampaignTarget(MktCampaignTargetReqDto mctr) {
        LogUtil.param(this.getClass(), mctr);

        StatusResDto rtnValue = new StatusResDto(false, "");

        //캠페인대상 헤더삭제
        mktCampaignMapper.deleteCampaignTarget(mctr);

        //캠페인대상 상세삭제
        MktCampaignTargetDtlReqDto mctdr = new MktCampaignTargetDtlReqDto();
        mctdr.setCampaignTargetHeaderId(mctr.getId());
        mctdr.setModifyBy(mctr.getModifyBy());

        mktCampaignMapper.deleteCampaignTargetDtlByTargetHeaderId(mctdr);

        //캠페인 대상자 업로드 삭제 By campaignTargetHeaderId
        mktCampaignMapper.deleteCampaignTargetFileUploadByTargetHeaderId(mctdr);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P06
     * @name : setControlGroup
     * @date : 2015. 11. 30.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had, mkt.mkt_tgt_dtl
     * @description : 캠페인대상 제어그룹 설정
     */
    public StatusResDto setControlGroup(MktCampaignTargetReqDto mctr) {
        LogUtil.param(this.getClass(), mctr);

        StatusResDto rtnValue = new StatusResDto(false, "");

        int controlGroupCount = 0;
        if (ObjectUtil.isNotEmpty(mctr.getControlGroupAmt())) {
            controlGroupCount = Integer.parseInt(mctr.getControlGroupAmt());
        }
        String controlGroupUnitCode = mctr.getControlGroupUnitCode();
        if (CommonUtil.MKT_CNTRL_GRP_UOM_R.equals(controlGroupUnitCode)) {
            //제어그룹단위코드 : 비율
            MktCampaignTargetTotalCountResDto totalCount = new MktCampaignTargetTotalCountResDto();
            totalCount = mktCampaignMapper.selectCampaignTargetTotalCount(mctr);
            if (ObjectUtil.isNotEmpty(totalCount)) {
                //전체 건수 확인 후 비율로 제어그룹건수 확인
                int finalCount = Integer.parseInt(totalCount.getFinalCount());
                controlGroupCount = (finalCount * controlGroupCount) / 100;
            }
        }

        mctr.setControlGroupCount(Integer.toString(controlGroupCount));

        //대상자 상세 제어그룹 초기화
        mktCampaignMapper.reSetCampaignTargetControlGroup(mctr);

        //대상자 상세 제어그룹 상태 변경
        mktCampaignMapper.setCampaignTargetControlGroup(mctr);

        //대상자 헤더 제어그룹 count 변경
        mktCampaignMapper.setCampaignTargetControlGroupCount(mctr);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P06
     * @name : removeCampaignTargetDtl
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_dtl
     * @description : 캠페인대상 상세 삭제
     */
    public StatusResDto removeCampaignTargetDtl(MktCampaignTargetDtlReqDto mctdr) {
        LogUtil.param(this.getClass(), mctdr);

        StatusResDto rtnValue = new StatusResDto(false, "");

        //대상자 상세 건삭제
        mktCampaignMapper.deleteCampaignTargetDtl(mctdr);

        //대상자 헤더 건삭제 count
        mktCampaignMapper.setCampaignTargetOneCaseRemoveCount(mctdr);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P06
     * @name : removeCancelCampaignTargetDtl
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_dtl
     * @description : 캠페인대상 상세 삭제 취소
     */
    public StatusResDto removeCancelCampaignTargetDtl(MktCampaignTargetDtlReqDto mctdr) {
        LogUtil.param(this.getClass(), mctdr);

        StatusResDto rtnValue = new StatusResDto(false, "");

        //대상자 상세 건삭제 취소
        mktCampaignMapper.deleteCancelCampaignTargetDtl(mctdr);

        //대상자 헤더 건삭제 count
        mktCampaignMapper.setCampaignTargetOneCaseRemoveCount(mctdr);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P06
     * @name : removeCampaignTargetByCampaignId
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had, mkt.mkt_tgt_dtl
     * @description : 캠페인대상 삭제 By CampaignId
     */
    public StatusResDto removeCampaignTargetByCampaignId(MktCampaignTargetReqDto mctr) {
        LogUtil.param(this.getClass(), mctr);

        StatusResDto rtnValue = new StatusResDto(false, "");

        //캠페인대상 헤더삭제
        mktCampaignMapper.deleteCampaignTargetByCampaignId(mctr);

        //캠페인대상 상세삭제
        MktCampaignTargetDtlReqDto mctdr = new MktCampaignTargetDtlReqDto();
        mctdr.setCampaignId(mctr.getCampaignId());
        mktCampaignMapper.deleteCampaignTargetDtlByCampaignId(mctdr);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P08
     * @name : getCampaignExecutionInfo
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info, mkt.mkt_exe_info_item
     * @description : 캠페인 실행정보 조회
     */
    public MktCampaignExecutionInfoResDto getCampaignExecutionInfo(MktCampaignExecutionInfoReqDto mceir) {
        LogUtil.param(this.getClass(), mceir);

        String lang = mceir.getLang();

        MktCampaignExecutionInfoResDto campaignExecutionInfo = new MktCampaignExecutionInfoResDto();
        campaignExecutionInfo = mktCampaignMapper.selectExecutionInfo(mceir);

        //실행정보 아이템 목록
        if (ObjectUtil.isNotEmpty(campaignExecutionInfo)) {
            MktCampaignExecutionInfoItemReqDto mceiir = new MktCampaignExecutionInfoItemReqDto();
            mceiir.setLang(lang);
            mceiir.setExeInfoId(campaignExecutionInfo.getId());
            List<MktCampaignExecutionInfoItemListResDto> executionInfoItemList = new ArrayList<MktCampaignExecutionInfoItemListResDto>();
            executionInfoItemList = mktCampaignMapper.selectExecutionInfoItemList2(mceiir);

            campaignExecutionInfo.setExecutionInfoItemList(executionInfoItemList);
        }

        return campaignExecutionInfo;
    }

    /**
     * 캠페인 설정정보 마지막 조회
     *
     * @programId :
     * @name : getCampaignLastExecutionInfo
     * @date : 2017. 12. 15.
     * @author : jh.kim
     * @description :
     */
    public String getCampaignLastExeDate(MktCampaignExecutionInfoReqDto mceir) {

        return mktCampaignMapper.selectCampaignLastExeDate(mceir);
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P08
     * @name : saveCampaignExecutionInfo
     * @date : 2015. 11. 19.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info, mkt.mkt_exe_info_item
     * @description : 캠페인 실행정보 저장
     */
    public StatusResDto saveCampaignExecutionInfo(MktCampaignExecutionInfoReqDto mceir) {
        LogUtil.param(this.getClass(), mceir);

        //캠페인 상태 저장여부 확인
        checkCampaignStatusSaveFlag(mceir.getCampaignId(), CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.SCHEDULE.name());

        StatusResDto rtnValue = new StatusResDto(false, "");
        //캠페인 실행정보 삭제
        rtnValue = removeExecutionInfoByCampaignId(mceir);

        //캠페인 실행정보/아이템 삭제
        rtnValue = removeExecutionInfo(mceir);

        //실행정보 아이템과 대상자 상세 관계 초기화 - 실행정보 아이템 상태가 발송완료(D)가 아닌것
        //rtnValue = mktCampaignMapper.deleteTargetDtlExecutionInfoItemRel(mceir);


        if ((TASK_DATA_STATUS.I.name().equals(mceir.getDataStatus())
                || TASK_DATA_STATUS.U.name().equals(mceir.getDataStatus()))
                && ObjectUtil.isNotEmpty(mceir.getCampaignId())) {
            if("REPEAT".equals(mceir.getType())) {  // 정기 캠페인
                if (ObjectUtil.isNotEmpty(mceir.getId())) {  // 수정
                    MktCampaignExecutionInfoResDto exeInfo = mktCampaignMapper.selectExecutionInfoById(mceir);
                    mktCampaignMapper.updateExecutionInfo(mceir);
                    if(!exeInfo.getExeDay().equals(mceir.getExeDay()) || !exeInfo.getExeStartDate().equals(mceir.getExeStartDate())
                            || !exeInfo.getExeEndDate().equals(mceir.getExeEndDate()) || !exeInfo.getExeCycleTypeCode().equals(mceir.getExeCycleTypeCode())
                            || !exeInfo.getExeHour().equals(mceir.getExeHour()) || !exeInfo.getExeMinute().equals(mceir.getExeMinute())
                            || !exeInfo.getExeMonthTypeCode().equals(mceir.getExeMonthTypeCode())) {  // 일정이 바뀐게 있다면
                        setRegularExeInfo(mceir);  // 새로 ITEM 생성
                    } else {  // 없다면
                        for (MktCampaignExecutionInfoItemReqDto item : mceir.getExecutionInfoItemList()) {  // Reqeust의 ITEM 대로
                            item.setSystemColumn(mceir.getSystemColumn());
                            item.setCampaignId(mceir.getCampaignId());
                            item.setExeInfoId(mceir.getId());
                            if (ObjectUtil.isNotEmpty(item.getId())) {
                                mktCampaignMapper.updateExecutionInfoItem(item);
                            } else {
                                String id = commonService.getRowID();
                                item.setId(id);

                                mktCampaignMapper.insertExecutionInfoItem(item);
                            }
                        }
                    }
                } else {  // 신규
                    String id = commonService.getRowID();
                    mceir.setId(id);
                    mktCampaignMapper.insertExecutionInfo(mceir);

                    setRegularExeInfo(mceir);  // 새로 ITEM 생성
                }
            } else {  // 일회성 캠페인
                if (ObjectUtil.isNotEmpty(mceir.getId())) {  // 수정
                    mktCampaignMapper.updateExecutionInfo(mceir);
                } else {  // 신규
                    String id = commonService.getRowID();
                    mceir.setId(id);
                    mktCampaignMapper.insertExecutionInfo(mceir);
                }

                // Reqeust의 ITEM 대로
                for (MktCampaignExecutionInfoItemReqDto item : mceir.getExecutionInfoItemList()) {
                    item.setSystemColumn(mceir.getSystemColumn());
                    item.setCampaignId(mceir.getCampaignId());
                    item.setExeInfoId(mceir.getId());
                    if (ObjectUtil.isNotEmpty(item.getId())) {
                        mktCampaignMapper.updateExecutionInfoItem(item);
                    } else {
                        String id = commonService.getRowID();
                        item.setId(id);

                        mktCampaignMapper.insertExecutionInfoItem(item);
                    }
                }
            }
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_P10
     * @name : getCampaignApproval
     * @date : 2015. 12. 7.
     * @author : "dg.ryu"
     * @table : mkt.mkt_elec_aprv
     * @description : 캠페인 전자결재
     */
    public MktCampaignApprovalResDto getCampaignApproval(MktCampaignApprovalReqDto mcar) {
        LogUtil.param(this.getClass(), mcar);

        MktCampaignApprovalResDto campaignApproval = new MktCampaignApprovalResDto();
        campaignApproval = mktCampaignMapper.selectCampaignApproval(mcar);

        return campaignApproval;
    }

    /**
     * @return :
     * @programId :
     * @name : checkCampaignStatusSaveFlagFlag
     * @date : 2016. 3. 18.
     * @author : "dg.ryu"
     * @table : mkt.mkt_cam_mst
     * @description : 캠페인 상태에 따른 저장여부
     */
    public boolean checkCampaignStatusSaveFlag(MktCampaignReqDto mcr) {
        LogUtil.param(this.getClass(), mcr);

        boolean rtnValue = false;

        /**
         * 1. 캠페인 아이디가 존재할 경우에만 확인 없을 경우 [저장 가능]
         */
        if (mcr.getId() != null && !"".equals(mcr.getId())) {
            String status = mktCampaignMapper.selectCampaignStatus(mcr);
            String approv = mktCampaignMapper.selectCamAprvCheck(mcr);
            String chnlType = mcr.getNodeType();

            /**
             * 2. ROI, MONITORING 모든 상태에서 [저장 가능]
             */
            if (CommonUtil.CAMPAIGN_NODE_TYPE_EXCEPTION.ROI.name().equals(chnlType)
                    || CommonUtil.CAMPAIGN_NODE_TYPE_EXCEPTION.MONITORING.name().equals(chnlType)) {
                return true;
            }

            /**
             * 3. 작성중일 경우 모두 [저장 가능]
             */
            else if (CommonUtil.CAMPAIGN_STATUS_TYPE.W.name().equals(status)) {
//                if(StringUtil.isNotEmpty(approv)) {
//                    if (approv.equals("090") || approv.equals("010") || approv.equals("020")) {
//                        return false;
//                    } else {
                return true;
//                    }
//                } else {
//                    return true;
//                }
            }

            /**
             * 4. 완료, 취소 상태일 경우 [저장 불가]
             */
            else if (CommonUtil.CAMPAIGN_STATUS_TYPE.E.name().equals(status)
                    || CommonUtil.CAMPAIGN_STATUS_TYPE.C.name().equals(status)
                    || CommonUtil.CAMPAIGN_STATUS_TYPE.A.name().equals(status)
                    || CommonUtil.CAMPAIGN_STATUS_TYPE.S.name().equals(status)) {
                return false;
            }

            /**
             * 5. 그외의 경우 해당 노드 유형만 [저장 가능]
             */
            else {
                for (CommonUtil.CAMPAIGN_NODE_TYPE_EXCEPTION node : CommonUtil.CAMPAIGN_NODE_TYPE_EXCEPTION.values()) {
                    if (node.name().equals(chnlType)) {
                        return true;
                    }
                }
            }
        } else {
            return true;
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId :
     * @name : checkCampaignStatusSaveFlagFlag
     * @date : 2016. 3. 18.
     * @author : "dg.ryu"
     * @table : mkt.mkt_cam_mst
     * @description : 캠페인 상태에 따른 저장여부 exception 발생
     */
    public void checkCampaignStatusSaveFlag(String campaignId, String nodeType) {
        //캠페인 아이디가 존재할 경우에만 확인
        if (campaignId != null && !"".equals(campaignId)) {
            MktCampaignReqDto mcr = new MktCampaignReqDto();
            mcr.setId(campaignId);
            mcr.setNodeType(nodeType);

            boolean rtnValue = checkCampaignStatusSaveFlag(mcr);

            if (!rtnValue) {
                LogUtil.error("The state can not save the campaign.");
                throw new DataBadRequestException();
            }
        }
    }

    /**
     * @return :
     * @programId : Mkt_MNG_002
     * @name : saveCampaignWorkflowTemplateUse
     * @date : 2016. 3. 21.
     * @author : "dg.ryu"
     * @table : mkt.mkt_templet_mst
     * @description : 캠페인 템플릿 사용여부 저장
     */
    public StatusResDto saveCampaignWorkflowTemplateUse(MktCampaignWorkflowTemplateReqDto mcwtr) {
        LogUtil.param(this.getClass(), mcwtr);

        StatusResDto rtnValue = new StatusResDto(false, "");

        MktCampaignReqDto mcr = new MktCampaignReqDto();
        mcr.setLang(mcwtr.getLang());
        mcr.setId(mcwtr.getCampaignId());

        //캠페인 기본정보 조회
        MktCampaignDefaultInfoResDto mcdir = getCampaignDefaultInfo(mcr);

        mcwtr.setWfCamPrpsCode(mcdir.getCampaignPurposeCode());
        mcwtr.setWfCamTypeCode(mcdir.getCampaignTypeCode());
        mcwtr.setWfName(mcdir.getCampaignName());

        //템플릿 사용여부 저장
        if ("Y".equals(mcwtr.getTemplateUseFlag())) {
            if (mktCampaignMapper.selectCampaignWorkflowTemplateCount(mcwtr) == 0) {

                String id = commonService.getRowID();
                mcwtr.setId(id);

                // 캠페인 워크플로우 템플릿 등록
                mktCampaignMapper.insertCampaignWorkflowTemplate(mcwtr);

                // 캠페인 템플릿 사용여부 수정
                mktCampaignMapper.updateCampaignTemplateFlag(mcwtr);
            }
        } else {
            // 캠페인 워크플로우 템플릿 삭제
            mktCampaignMapper.deleteCampaignWorkflowTemplate(mcwtr);

            // 캠페인 템플릿 사용여부 수정
            mktCampaignMapper.updateCampaignTemplateFlag(mcwtr);
        }

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_001
     * @name : editCampaignDefaultInfoDesc
     * @date : 2016. 4. 22.
     * @author : "dg.ryu"
     * @table : mkt.mkt_cam_mst
     * @description : 캠페인 기본정보 비고 수정
     */
    public StatusResDto editCampaignDefaultInfoDesc(MktCampaignDefaultInfoReqDto mcdir) {
        LogUtil.param(this.getClass(), mcdir);

        StatusResDto rtnValue = new StatusResDto();

        mktCampaignMapper.updateCampaignDefaultInfoDesc(mcdir);

        return rtnValue;
    }

    /**
     * @return :
     * @programId : Mkt_MNG_004
     * @name : getCampaignStatusList
     * @date : 2016. 4. 8.
     * @author : 송원희
     * @table :
     * @description : 캠페인 현황 목록
     */
    public GridPagingResDto<MktCampaignStatusReqDto> getCampaignStatusList(MktCampaignStatusReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktCampaignStatusReqDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktCampaignMapper.selectCampaignStatusList(param), AnnotationType.CommCode);
    }

    /**
     * @return :
     * @programId : Mkt_MNG_004
     * @name : getCampaignStatusDetailList
     * @date : 2016. 4. 8.
     * @author : 송원희
     * @table :
     * @description : 캠페인 현황 실행 목록
     */
    public GridPagingResDto<MktCampaignStatusReqDto> getCampaignStatusDetailList(MktCampaignStatusReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktCampaignStatusReqDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktCampaignMapper.selectCampaignStatusDetailList(param), AnnotationType.CommCode);
    }

    /**
     * @return : MktCampaignTgtChnlChkResDto
     * @programId :
     * @name : getTgtChnlChk
     * @date : 2016. 12. 06.
     * @author : 이원준
     * @table : mkt_cam_mst, mkt_conts_chnl_rel, mkt_exe_info, mkt_exe_info_item, mkt_tgt_dtl, mkt_conts_mst
     * @description : 캠페인 기획완료 체크
     */
    public MktCampaignTgtChnlChkResDto getTgtChnlChk(MktCampaignTgtChnlChkReqDto ccrsr) {
        LogUtil.param(this.getClass(), ccrsr);

        MktCampaignTgtChnlChkResDto rtnValue = new MktCampaignTgtChnlChkResDto();

        String tgtChk = mktCampaignMapper.selectTgtChk(ccrsr);
        List<String> chnlChk = mktCampaignMapper.selectChnlChk(ccrsr);

        rtnValue.setExeChnlTypeCd(tgtChk);
        rtnValue.setChnlTypeCdList(chnlChk);
        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return : MktGetConidByCamidResDto
     * @name : getConidByCamid
     * @date : 2017. 6. 22.
     * @author : jun.lee
     * @description : camid로 conid 조회
     */

    public List<MktCampaignGetConidByCamidResDto> getConidByCamid(MktCampaignGetConidByCamidReqDto param) {
        LogUtil.param(this.getClass(), param);

        return mktCampaignMapper.selectConidByCamid(param);
    }

    /**
     * 캠페인 삭제
     *
     * @programId :
     * @name : removeCampaign
     * @date : 2017. 11. 29.
     * @author : jh.kim
     * @description :
     */
    public StatusResDto removeCampaign(MktCampaignRemoveReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto(false, "");

        // 작성중 && 결제 진행중이 아니고, 결제 승인완료도 아닌 캠페인만 삭제 가능
        if (CAMPAIGN_STATUS_TYPE.W.name().equals(param.getCampaignStatusCode())) {

            // 1. 삭제처리
            mktCampaignMapper.deleteCampaign(param);

            // 2. 각 채널별 발송 중지
            MktCampaignDefaultInfoReqDto mcdir = new MktCampaignDefaultInfoReqDto();
            mcdir.setSystemColumn(param.getSystemColumn());
            mcdir.setId(param.getId());

            // 2-1. 메세지 발송 중지
            mktCampaignMapper.updateStopSendingMessagesByCampaignId(mcdir);

            // 2-2. PUSH 발송 중지
            mktCampaignMapper.updateStopSendingPushByCampaignId(mcdir);

            // 2-3. 이메일 발송 중지
            mktCampaignMapper.updateStopSendingEmailByCampaignId(mcdir);

            // 2-4. 카카오 친구톡 발송 중지
            mktCampaignMapper.updateStopSendingKakaoByCampaignId(mcdir);

            // 3. 캠페인 템플릿 삭제
            mktCampaignMapper.deleteCampaignTemplates(param);

            // 4. 캠페인 채널 관계 삭제
            MktCampaignContentsChnnelRelReqDto camId = new MktCampaignContentsChnnelRelReqDto();
            camId.setCampaignId(param.getId());
            mktCampaignMapper.deleteCampaignContentsChnnelRelByCampaignId(camId);
        }

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return : StatusResDto
     * @name : callProcCamCopy
     * @date : 2018. 2. 24.
     * @author : dg.ryu
     * @description : 캠페인 복사 프로시저 호춢
     */
    public StatusResDto callProcCamCopy(MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto(false, "");

        if(StringUtil.isNotEmpty(param.getEmpId())&&StringUtil.isNotEmpty(param.getPlanOrgCode())&&StringUtil.isNotEmpty(param.getPlanOrgCodeName())) {
            MktCampaignListResDto resultProcedure = new MktCampaignListResDto();
            resultProcedure = mktCampaignMapper.callProcCamCopy(param);

            if ("S".equals(resultProcedure.getResultCd())) {
                rtnValue.setSuccess(true);
                rtnValue.setMessage(resultProcedure.getResultMsg());
                param.setId(resultProcedure.getResultMsg());
                mktCampaignMapper.camTempPlanerUpdate(param);
            }
        } else {
            rtnValue.setSuccess(false);
            rtnValue.setMessage("사용자 계정이 정상적이지 않습니다. 관리자에게 문의해주세요.");
        }

        return rtnValue;
    }

    /**
     * 캠페인 목록 조회 (내 캠페인 제외 조회)
     *
     * @programId :
     * @name : getCampaignListForParCam
     * @date : 2018. 2. 26.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public GridPagingResDto<MktCampaignListResDto> getCampaignListExcludeMyCam(MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktCampaignListResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktCampaignMapper.selectCampaignListExcludeMyCam(param), AnnotationType.CommCode);
    }

    /**
     * @return :
     * @programId : PLOY_061_P01
     * @name : getETCampaignCond
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : loy.et_cam_node, loy.et_cam_cond_val, anl.anl_lgc_comp_mst, anl.anl_atrib_group_column
     * @description : et 조건 조회
     */
    public MktETCampaignNodeResDto getETCampaignCond(MktETCampaignNodeReqDto ecnr) {
        LogUtil.param(this.getClass(), ecnr);

        MktETCampaignNodeResDto rtnValue = new MktETCampaignNodeResDto();

        //et 캠페인 노드 조회
        ecnr.setSVCAlias("t1");
        rtnValue = mktCampaignMapper.selectETCampaignNode(ecnr);

        if (ObjectUtil.isNotEmpty(rtnValue)) {
            MktETCampaignCondValReqDto eccvr = new MktETCampaignCondValReqDto();
            eccvr.setSystemColumn(ecnr.getSystemColumn());
            eccvr.setRidCamNode(ecnr.getRid());

            List<MktETCampaignCondValListResDto> condValList = new ArrayList<MktETCampaignCondValListResDto>();
            eccvr.setSVCAlias("t1");

            //et 조건값 목록 조회
            condValList = mktCampaignMapper.selectETCampaignCondValList(eccvr);

            if (ObjectUtil.isNotEmpty(condValList)) {
                rtnValue.setCondValList(condValList);
            }
        }
        return rtnValue;
    }

    /**
     * @return :
     * @programId : PLOY_061_P01
     * @name : saveETCampaignCond
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : loy.et_cam_node, loy.et_cam_cond_val
     * @description : et 조건값 저장
     */
    public StatusResDto saveETCampaignCond(MktETCampaignNodeReqDto ecnr) {
        LogUtil.param(this.getClass(), ecnr);

        //캠페인 상태 저장여부 확인
        checkCampaignStatusSaveFlag(ecnr.getCampaignId(), CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.ETCOND.name());

        StatusResDto rtnValue = new StatusResDto();

        MktETCampaignCondValReqDto eccvr = new MktETCampaignCondValReqDto();
        eccvr.setRidCamNode(ecnr.getRid());
        eccvr.setModifyBy(ecnr.getModifyBy());
        //조건값 삭제
        //iMKTCampaign.removeETCampaignCondValByRidCamNode(eccvr);
        mktCampaignMapper.deleteETCampaignCondValByRidCamNode(eccvr);

        if ((TASK_DATA_STATUS.I.name().equals(ecnr.getDataStatus())
                || TASK_DATA_STATUS.U.name().equals(ecnr.getDataStatus()))
                && ObjectUtil.isNotEmpty(ecnr.getCampaignId())) {

            String ridCamNode = "";

            //nodeType
            ecnr.setRidNodeType(ET_NODE_TYPE.RUL.name());

            if (ObjectUtil.isNotEmpty(ecnr.getRid())) {
                //et 캠페인 노드 수정
                //rtnValue = iMKTCampaign.editETCampaignNode(ecnr);
                ecnr.setRidPgm(ecnr.getLoyProgramId());
                mktCampaignMapper.updateETCampaignNode(ecnr);
                rtnValue.setSuccess(true);
                ridCamNode = ecnr.getRid();
            } else {
                //et 캠페인 노드 등록
                //rtnValue = iMKTCampaign.addETCampaignNode(ecnr);
                String rid = CommonUtil.newRid();
                ecnr.setRid(rid);
                ecnr.setRidPgm(ecnr.getLoyProgramId());
                mktCampaignMapper.insertETCampaignNode(ecnr);

                rtnValue.setSuccess(true);
                rtnValue.setMessage(rid);

                ridCamNode = rtnValue.getMessage();
            }

            for (MktETCampaignCondValReqDto conVal : ecnr.getCondValList()) {
                conVal.setCreateBy(ecnr.getCreateBy());
                conVal.setModifyBy(ecnr.getModifyBy());
                conVal.setRidCamNode(ridCamNode);
                if (ObjectUtil.isNotEmpty(conVal.getRid())) {
                    //조건값 수정
                    //rtnValue = iMKTCampaign.editETCampaignCondVal(conVal);
                    mktCampaignMapper.updateETCampaignCondVal(conVal);
                    rtnValue.setSuccess(true);


                } else {
                    //조건값 등록
                    //rtnValue = iMKTCampaign.addETCampaignCondVal(conVal);
                    String rid = CommonUtil.newRid();
                    conVal.setRid(rid);

                    mktCampaignMapper.insertETCampaignCondVal(conVal);

                    rtnValue.setSuccess(true);
                    rtnValue.setMessage(rid);
                }
            }

            rtnValue.setMessage(ridCamNode);
        } else {
            //et 캠페인 노드 삭제
            //rtnValue = iMKTCampaign.removeETCampaignNode(ecnr);
            mktCampaignMapper.deleteETCampaignNode(ecnr);
            rtnValue.setSuccess(true);
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId : PLOY_065_P01
     * @name : getETCampaignAct
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : loy.et_cam_act_val, mkt.mkt_offer_mst
     * @description : et 활동 조회
     */
    public MktETCampaignNodeResDto getETCampaignAct(MktETCampaignNodeReqDto ecnr) {
        LogUtil.param(this.getClass(), ecnr);

        MktETCampaignNodeResDto rtnValue = new MktETCampaignNodeResDto();

        //et 캠페인 노드 조회
        //rtnValue = iMKTCampaign.getETCampaignNode(ecnr);
        ecnr.setSVCAlias("t1");

        rtnValue = mktCampaignMapper.selectETCampaignNode(ecnr);

        if (ObjectUtil.isNotEmpty(rtnValue)) {
            MktETCampaignActValReqDto ecavr = new MktETCampaignActValReqDto();
            ecavr.setSystemColumn(ecavr.getSystemColumn());
            ecavr.setRidCamNode(ecnr.getRid());

            MktETCampaignActValResDto actVal = new MktETCampaignActValResDto();

            //et 조건값 목록 조회
            //actVal = iMKTCampaign.getETCampaignActVal(ecavr);

            ecavr.setSVCAlias("t1");

            actVal = mktCampaignMapper.selectETCampaignActVal(ecavr);

            if (ObjectUtil.isNotEmpty(actVal)) {
                rtnValue.setActVal(actVal);
            }

            MktETCampaignActParamReqDto actParamReq = new MktETCampaignActParamReqDto();
            actParamReq.setSystemColumn(ecavr.getSystemColumn());
            actParamReq.setRidCamNode(ecnr.getRid());

            List<MktETCampaignActParamResDto> actParam = mktCampaignMapper.selectETCampaignActParamList(actParamReq);

            if (ObjectUtil.isNotEmpty(actParam)) {
                rtnValue.setActParam(actParam);
            }
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId : PLOY_065_P01
     * @name : saveETCampaignAct
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : loy.et_cam_node, loy.et_cam_act_val
     * @description : et 활동값 저장
     */
    public StatusResDto saveETCampaignAct(MktETCampaignNodeReqDto ecnr) {
        LogUtil.param(this.getClass(), ecnr);

        //캠페인 상태 저장여부 확인
        checkCampaignStatusSaveFlag(ecnr.getCampaignId(), CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.ETCOND.name());

        StatusResDto rtnValue = new StatusResDto();

        if ((TASK_DATA_STATUS.I.name().equals(ecnr.getDataStatus())
                || TASK_DATA_STATUS.U.name().equals(ecnr.getDataStatus()))
                && ObjectUtil.isNotEmpty(ecnr.getCampaignId())) {

            String ridCamNode = "";

            //nodeType
            ecnr.setRidNodeType(ET_NODE_TYPE.ACT.name());

            if (ObjectUtil.isNotEmpty(ecnr.getRid())) {
                //et 캠페인 노드 수정
                //rtnValue = iMKTCampaign.editETCampaignNode(ecnr);
                ecnr.setRidPgm(ecnr.getLoyProgramId());
                mktCampaignMapper.updateETCampaignNode(ecnr);
                rtnValue.setSuccess(true);
                ridCamNode = ecnr.getRid();
            } else {
                //et 캠페인 노드 등록
                //rtnValue = iMKTCampaign.addETCampaignNode(ecnr);
                String rid = CommonUtil.newRid();
                ecnr.setRid(rid);
                ecnr.setRidPgm(ecnr.getLoyProgramId());

                mktCampaignMapper.insertETCampaignNode(ecnr);

                rtnValue.setSuccess(true);
                rtnValue.setMessage(rid);

                ridCamNode = rtnValue.getMessage();
            }

            if (ObjectUtil.isNotEmpty(ecnr.getActVal())) {
                ecnr.getActVal().setRidCamNode(ridCamNode);
                ecnr.getActVal().setSystemColumn(ecnr.getSystemColumn());
                if (ObjectUtil.isNotEmpty(ecnr.getActVal().getRid())) {
                    //활동값 수정
                    //rtnValue = iMKTCampaign.editETCampaignActVal(ecnr.getActVal());
                    mktCampaignMapper.updateETCampaignActVal(ecnr.getActVal());

                    rtnValue.setSuccess(true);
                } else {
                    //활동값 등록
                    //rtnValue = iMKTCampaign.addETCampaignActVal(ecnr.getActVal());
                    String rid = CommonUtil.newRid();
                    ecnr.getActVal().setRid(rid);

                    mktCampaignMapper.insertETCampaignActVal(ecnr.getActVal());
                    rtnValue.setSuccess(true);
                    rtnValue.setMessage(rid);
                }
            }

            if (ObjectUtil.isNotEmpty(ecnr.getActParam())) {
                MktETCampaignActParamReqDto actParamReq = new MktETCampaignActParamReqDto();
                actParamReq.setRidCamNode(ridCamNode);
                actParamReq.setSystemColumn(ecnr.getSystemColumn());

                mktCampaignMapper.deleteETCampaignActParamByRidCamNode(actParamReq);

                for (MktETCampaignActParamReqDto param : ecnr.getActParam()) {
                    param.setRidCamNode(ridCamNode);
                    param.setSystemColumn(ecnr.getSystemColumn());

                    mktCampaignMapper.insertETCampaignActParam(param);
                }
            }

            rtnValue.setMessage(ridCamNode);
        } else {
            //et 캠페인 노드 삭제
            //rtnValue = iMKTCampaign.removeETCampaignNode(ecnr);
            mktCampaignMapper.deleteETCampaignNode(ecnr);
            MktETCampaignActValReqDto ecavr = new MktETCampaignActValReqDto();
            ecavr.setSystemColumn(ecnr.getSystemColumn());
            ecavr.setRidCamNode(ecnr.getRid());

            //활동값 삭제
            //rtnValue = iMKTCampaign.removeETCampaignActValByRidCamNode(ecavr);
            mktCampaignMapper.deleteETCampaignActValByRidCamNode(ecavr);
            rtnValue.setSuccess(true);
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId : PLOY_060_P01
     * @name : getETIntactTypeList
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : loy.loy_intact_type
     * @description : et 인터랙션 유형 목록 조회
     */
    public GridPagingResDto<MktETIntactTypeListResDto> getETIntactTypeList(MktETIntactTypeListReqDto eitlr) {
        LogUtil.param(this.getClass(), eitlr);
        eitlr.setSVCAlias("t1");
        return new GridPagingResHelper<MktETIntactTypeListResDto>().newGridPagingResDto(
                eitlr.init(CommonUtil.getInstance().getDBType())
                , mktCampaignMapper.selectETIntactTypeList(eitlr));
    }

    /**
     * @return :
     * @programId : PLOY_061_P02
     * @name : getETLogicalComponentList
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : anl.anl_lgc_comp_mst, anl.anl_atrib_group, anl.anl_atrib_group_column
     * @description : et 로지컬 컴포넌트 목록 조회
     */

    public GridPagingResDto<MktETLogicalComponentListResDto> getETLogicalComponentList(MktETLogicalComponentListReqDto elclr) {
        LogUtil.param(this.getClass(), elclr);
        elclr.setSVCAlias("l");
        return new GridPagingResHelper<MktETLogicalComponentListResDto>().newGridPagingResDto(
                elclr.init(CommonUtil.getInstance().getDBType())
                , mktCampaignMapper.selectETLogicalComponentList(elclr));
    }

    /**
     * @return :
     * @programId : PLOY_061_P01
     * @name : getETLogicalComponentColumnList
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : anl.anl_lgc_comp_mst, anl.anl_atrib_group, anl.anl_atrib_group_column
     * @description : et 로지컬 컴포넌트 컬럼 목록
     */
    public List<MktETLogicalComponentColumnListResDto> getETLogicalComponentColumnList(MktETLogicalComponentColumnListReqDto elcclr) {
        LogUtil.param(this.getClass(), elcclr);
        List<MktETLogicalComponentColumnListResDto> rtnValue = new ArrayList<MktETLogicalComponentColumnListResDto>();
        elcclr.setSVCAlias("t1");
        rtnValue = mktCampaignMapper.selectETLogicalComponentColumnList(elcclr);


        return rtnValue;
    }

    /**
     * @return :
     * @programId : PLOY_062_P02
     * @name : getETFunctionList
     * @date : 2016. 11. 17.
     * @author : dg.ryu
     * @table : loy.et_node_type, loy.et_node_sub_type
     * @description : et function 목록 조회
     */
    public GridPagingResDto<MktETFunctionListResDto> getETFunctionList(MktETFunctionListReqDto eflr) {
        LogUtil.param(this.getClass(), eflr);
        eflr.setSVCAlias("t2");
        return new GridPagingResHelper<MktETFunctionListResDto>().newGridPagingResDto(
                eflr.init(CommonUtil.getInstance().getDBType())
                , mktCampaignMapper.selectETFunctionList(eflr));
    }

    public MktCampaignPromotionDateResDto getCampaignPromotionDate(MktCampaignPromotionDateReqDto param) {
        LogUtil.param(this.getClass(), param);
        MktCampaignPromotionDateResDto rtnDto =
                mktCampaignMapper.selectCampaignPromotionDate(param);
        return rtnDto;
    }

    /**
     * @programId :
     * @name : getCampaignWait
     * @date : 2020. 5. 7.
     * @author : dg.ryu
     * @table :
     * @description : 캠페인 Wait 조회
     */
    public MktCampaignWaitResDto getCampaignWait(MktCampaignWaitReqDto param) {
        LogUtil.param(this.getClass(), param);

        return mktCampaignMapper.selectCampaignWait(param);
    }

    /**
     * @programId :
     * @name : saveCampaignWait
     * @date : 2020. 5. 7.
     * @author : dg.ryu
     * @table :
     * @description : 캠페인 Wait 저장
     */
    public StatusResDto saveCampaignWait(MktCampaignWaitReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto(false, "");

        if (ObjectUtil.isNotEmpty(param.getId())) {
            // 수정
            mktCampaignMapper.updateCampaignWait(param);
            rtnValue.setMessage(param.getId());
        } else {
            // 등록
            String id = CommonUtil.newRid();
            param.setId(id);
            mktCampaignMapper.insertCampaignWait(param);
            rtnValue.setMessage(param.getId());
        }

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @programId :
     * @name : removeCampaignWait
     * @date : 2020. 5. 7.
     * @author : dg.ryu
     * @table :
     * @description : 캠페인 Wait 삭제
     */
    public StatusResDto removeCampaignWait(MktCampaignWaitReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto(false, "");
        mktCampaignMapper.deleteCampaignWait(param);
        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @programId :
     * @name : getProdList
     * @date : 2020. 7. 14.
     * @author : yj.choi
     * @table :
     * @description : 반응상품 리스트
     */

    public GridPagingResDto<MktCampaignProdResDto> getProdList(MktCampaignProdReqDto param) {
        LogUtil.param(this.getClass(), param);

        return new GridPagingResHelper<MktCampaignProdResDto>().newGridPagingResDto(
                param.init(CommonUtil.getInstance().getDBType()),
                mktCampaignMapper.selectProdList(param));
    }

    /**
     * @programId :
     * @name : getProdTreeList
     * @date : 2020. 7. 14.
     * @author : yj.choi
     * @table :
     * @description : 반응상품 트리
     */
    public List<MktCampaignProdResDto> getProdTreeList(MktCampaignProdReqDto param) {
        LogUtil.param(this.getClass(), param);
        return mktCampaignMapper.selectProdTreeList(param);
    }

    /**
     * @programId :
     * @name : saveCampaignProd
     * @date : 2020. 7. 14.
     * @author : yj.choi
     * @table :
     * @description : 반응상품 저장
     */
    public StatusResDto saveCampaignProd(MktCampaignProdReqDto param) {
        LogUtil.param(this.getClass(), param);
        StatusResDto rtnVal = new StatusResDto();
        rtnVal.setSuccess(false);
        mktCampaignMapper.insertCampaignProd(param);
        rtnVal.setSuccess(true);
        return rtnVal;
    }

    /**
     * @programId :
     * @name : getProdTreeSearchList
     * @date : 2020. 7. 15.
     * @author : yj.choi
     * @table :
     * @description : 반응상품 검색
     */
    public List<MktCampaignProdResDto> getProdTreeSearchList(MktCampaignProdReqDto param) {
        LogUtil.param(this.getClass(), param);
        return mktCampaignMapper.selectProdTreeSearchList(param);
    }

    /**
     * @programId :
     * @name : removeProd
     * @date : 2020. 7. 15.
     * @author : yj.choi
     * @table :
     * @description : 반응상품 삭제
     */
    public StatusResDto removeProd(MktCampaignProdReqDto param) {
        LogUtil.param(this.getClass(), param);
        StatusResDto rtnVal = new StatusResDto();
        rtnVal.setSuccess(false);
        mktCampaignMapper.deleteProd(param);
        rtnVal.setSuccess(true);
        return rtnVal;
    }

    /**
     * @programId :
     * @name : removeAllProd
     * @date : 2020. 7. 15.
     * @author : yj.choi
     * @table :
     * @description : 반응상품 전체 삭제
     */
    public StatusResDto removeAllProd(MktCampaignProdReqDto param) {
        LogUtil.param(this.getClass(), param);
        StatusResDto rtnVal = new StatusResDto();
        rtnVal.setSuccess(false);
        mktCampaignMapper.deleteAllProd(param);
        rtnVal.setSuccess(true);
        return rtnVal;
    }

    /**
     * 컨텐츠 오퍼 조회
     *
     * @param reqDto
     * @return
     */
    public Integer getCampaignOfferCount(MktCampaignContentsChnnelRelReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        return mktCampaignMapper.selectCampaignOfferCount(reqDto);
    }

    /**
     * 캠페인 불러오기시 오퍼에 쿠폰이 있는지에 대한 여부 체크
     *
     * @return
     */
    public Integer getCampaignLoadOfferCount(MktCampaignContentsChnnelRelReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        return mktCampaignMapper.getCampaignLoadOfferCount(reqDto);
    }

    /**
     * 캠페인 컨텐츠 오퍼 팝업시 쿠폰 체크
     *
     * @return
     */
    public Integer getCampaignLoadOfferPopCount(MktCampaignContentsChnnelRelReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        return mktCampaignMapper.getCampaignLoadOfferPopCount(reqDto);
    }

    /**
     * 캠페인 실행 가능 시간 조회
     *
     * @return
     */
    public MktSchePermitResDto getSchedulingPermitTime(MktSchePermitReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        //요구 사항에 따라서 채널별 시간을 뿌리도록 리스트로 변환 될 수 있음.
        MktSchePermitResDto permitList = mktCampaignMapper.getSchedulingPermitTime(reqDto);

        return permitList;
    }

    /**
     * 캠페인 오퍼 발급 완료 체크
     *
     * @param param
     * @return
     */
    public StatusResDto getOfferDataCheck(MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);
        StatusResDto rtnValue = new StatusResDto();

        OfferReqDto ofrCheckParam = new OfferReqDto();
        ofrCheckParam.setRid(param.getId());

        OfferResDto ofrCheckRtn = mktCampaignMapper.selectCamOfferCheck(ofrCheckParam);

        if(ObjectUtil.isNotEmpty(ofrCheckRtn)) {
            param.setOfferId(ofrCheckRtn.getRid());
            param.setOfferTypeCodeName(ofrCheckRtn.getOfferTypeCodeName());
        }

        try {
            if (StringUtil.isNotEmpty(param.getOfferId())) {

                //정기 캠페인의 경우 마케팅 배치에서 발급
                if(param.getCampaignTypeCode().equals("REGULAR")){
                    rtnValue.setSuccess(true);
                    rtnValue.setMessage("R");
                    return rtnValue;
                }

                //조회할 테이블 지정
                if (param.getOfferTypeCodeName().equals("C")) {
                    param.setOfferTableName("ESHOPUSER.TB_IF_CRM_CPN");
                } else if (param.getOfferTypeCodeName().equals("P")) {
                    param.setOfferTableName("ESHOPUSER.TB_IF_CRM_POINT");
                } else {
                    //오퍼 없음
                    rtnValue.setSuccess(true);
                    rtnValue.setMessage("N");
                    return rtnValue;
                }

                //데이터 요청 여부
                if (mktCampaignEshopMapper.selectOfferDataIsNull(param) > 0) {

                    //발급 진행 체크
                    if (mktCampaignEshopMapper.selectOfferDataCheck(param) > 0) {

                        String method = "/runJob";

                        String result = "";
                        method += "?jobName=" + "jobCampaignOfferCheck";

                        LogUtil.debug("jobScheduler 실행");
                        String url = CommonUtil.getInstance().getServletProp("icignal.batch.host");
                        url += "/api" + method;
                        LogUtil.debug("url : " + url);
                        RestTemplate restTemplate = new RestTemplate();
                        result = restTemplate.getForObject(url, String.class);
                        LogUtil.debug("Scheduler 결과 : " + result);

                        String str[] = result.split("&");
                        if (str[0].split("=")[1].equals("S")) {
                            //발급 완료
                            rtnValue.setSuccess(true);
                            rtnValue.setMessage("S");
                        } else {
                            rtnValue.setSuccess(false);
                            rtnValue.setMessage("예상치 못한 에러가 발생하였습니다. 관리자에게 문의해주세요.");
                        }
                    } else {
                        //발급 진행중 및 실패
                        rtnValue.setSuccess(false);
                        rtnValue.setMessage("0");
                    }
                } else {
                    //발급 요청 없음
                    rtnValue.setSuccess(false);
                    rtnValue.setMessage("1");
                }
            } else {
                //오퍼 없음
                rtnValue.setSuccess(true);
                rtnValue.setMessage("N");
            }
        } catch (Exception e) {
            rtnValue.setSuccess(false);
            rtnValue.setMessage("예상치 못한 에러가 발생하였습니다. 관리자에게 문의해주세요.");
            return rtnValue;
        }

        return rtnValue;
    }

    /**
     * 캠페인 오퍼 발급
     *
     * @param param
     * @return
     */
    public StatusResDto camOfferRequest(MktCampaignReqDto param) {
        LogUtil.param(this.getClass(), param);
        StatusResDto rtnValue = new StatusResDto();

        // 연결 정보(mart),쿼리 정보(mart)
        MktCampaignOfferCallResDto camOfferTgtInfo = new MktCampaignOfferCallResDto();
        camOfferTgtInfo = mktCampaignMapper.selectCamOfferForReqData(param);

        MKTDBInfoDTO martConnectionInfo = new MKTDBInfoDTO();
        martConnectionInfo.setDriverClassName(camOfferTgtInfo.getConDbClass());
        martConnectionInfo.setConDbType(camOfferTgtInfo.getConDbType());
        martConnectionInfo.setConIp(camOfferTgtInfo.getConIp());
        martConnectionInfo.setConPort(camOfferTgtInfo.getConPort());
        martConnectionInfo.setUserName(camOfferTgtInfo.getConId());
        martConnectionInfo.setPassword(encrypor.decrypt(camOfferTgtInfo.getConPassword()));
        martConnectionInfo.setUrl(camOfferTgtInfo.getConUrl());

        //조회할 테이블 지정
        if (camOfferTgtInfo.getOfferTypeCodeName().equals("C")) {
            camOfferTgtInfo.setOfferTableName("ESHOPUSER.TB_IF_CRM_CPN");
        } else if (camOfferTgtInfo.getOfferTypeCodeName().equals("P")) {
            camOfferTgtInfo.setOfferTableName("ESHOPUSER.TB_IF_CRM_POINT");
        } else {
            //오퍼 없음
            rtnValue.setSuccess(false);
            return rtnValue;
        }

        MktCampaignOfferCallResDto camOfferEshopInfo = new MktCampaignOfferCallResDto();
        camOfferEshopInfo = mktCampaignMapper.selectCamOfferForEshopDbInfo(param);

        MKTDBInfoDTO eshopConnectionInfo = new MKTDBInfoDTO();
        eshopConnectionInfo.setDriverClassName(camOfferTgtInfo.getConDbClass());
        eshopConnectionInfo.setConDbType(camOfferEshopInfo.getConDbType());
        eshopConnectionInfo.setConIp(camOfferEshopInfo.getConIp());
        eshopConnectionInfo.setConPort(camOfferEshopInfo.getConPort());
        eshopConnectionInfo.setUserName(camOfferEshopInfo.getConId());
        eshopConnectionInfo.setPassword(encrypor.decrypt(camOfferEshopInfo.getConPassword()));
        eshopConnectionInfo.setUrl(camOfferEshopInfo.getConUrl());


        OfferReqDto camOfferReq = new OfferReqDto();
        camOfferReq.setRid(param.getId());
        OfferResDto camOfferRes = new OfferResDto();
        camOfferRes = mktCampaignMapper.selectCamOfferDetail(camOfferReq);

        // eshop insert 작업
        // jdbc 배치 작업
        try {

            if (ObjectUtil.isNotEmpty(martConnectionInfo) && ObjectUtil.isNotEmpty(camOfferTgtInfo.getFilterSqlCount())) {

                // 대상자 추출(mart)
                List<String> tgtRtnValue = new ArrayList<>();

                StringBuilder sqlQuery = new StringBuilder(camOfferTgtInfo.getFilterSql());
                KprTargetGroupTargetListReqDto queryTgtInfo = new KprTargetGroupTargetListReqDto();
                queryTgtInfo.setSVCAlias("");

                int tgtAllSize = 0;
                tgtAllSize = camOfferTgtInfo.getTgtCnt();
                int splitCnt = (int) Math.ceil((double) tgtAllSize / splitSize);

                StringBuilder query = new StringBuilder();

                if (camOfferTgtInfo.getOfferTypeCodeName().equals("C")) {

                    query.append(" insert into " + camOfferTgtInfo.getOfferTableName() + " ( ")
                            .append(" ROW_SEQ")
                            .append(", FST_REG_ID")
                            .append(", FST_REG_DT")
                            .append(", LST_MOD_ID")
                            .append(", LST_MOD_DT")
                            .append(", USR_ID")
                            .append(", CRM_CAM_RID")
                            .append(", CRM_CAM_NO")
                            .append(", CPON_PUBLISH_SEQ")
                            .append(") values ( ")
                            .append(" ESHOPUSER.SQ_IF_CRM_CPN.NEXTVAL")
                            .append(", '" + camOfferTgtInfo.getCreateBy() + "'")
                            .append(", sysdate")
                            .append(", '" + camOfferTgtInfo.getModifyBy() + "'")
                            .append(", sysdate")
                            .append(", ?")
                            .append(", '" + camOfferTgtInfo.getCamId() + "'")
                            .append(", '" + camOfferTgtInfo.getCamNo() + "'")
                            .append(", ? )");
                } else {

                    query.append("insert into " + camOfferTgtInfo.getOfferTableName() + "(")
                            .append(" ROW_SEQ")
                            .append(", FST_REG_ID")
                            .append(", FST_REG_DT")
                            .append(", LST_MOD_ID")
                            .append(", LST_MOD_DT")
                            .append(", USR_ID")
                            .append(", CRM_CAM_RID")
                            .append(", CRM_CAM_NO")
                            .append(", point_give_st_cd")
                            .append(", point_give_prc")
                            .append(", point_give_tp_cd")
                            .append(", point_give_tp_doc")
                            .append(", point_extin_dt")
                            .append(" ) values ( ")
                            .append(" ESHOPUSER.SQ_IF_CRM_POINT.NEXTVAL")
                            .append(", '" + camOfferTgtInfo.getCreateBy() + "'")
                            .append(", sysdate")
                            .append(", '" + camOfferTgtInfo.getModifyBy() + "'")
                            .append(", sysdate")
                            .append(", ?")
                            .append(", '" + camOfferTgtInfo.getCamId() + "'")
                            .append(", '" + camOfferTgtInfo.getCamNo() + "'")
                            .append(", '0046002'")
                            .append(", ? ")
                            .append(", ? ")
                            .append(", ? ")
                            .append(", ? )");
                }

                for (int i = 1; i <= splitCnt; i++) {
                    StringBuilder exeTgtQuery = new StringBuilder();

                    exeTgtQuery.append("select t.segkey\n")
                            .append("  from (\n")
                            .append("select t.* ")
                            .append("       , ROW_NUMBER() OVER (ORDER BY segkey DESC) as \"RowNumber\"\n")
                            .append("  from ( ")
                            .append("    " + sqlQuery)
                            .append(") t")
                            .append("        ) t \n")
                            .append(" WHERE RowNumber > " + splitSize * (i-1) + " and RowNumber <= " + splitSize * i + "\n");

                    tgtRtnValue = mktCallQueryDao.callSelectForList("selectCamOfferTgtDataCount", exeTgtQuery.toString(), new ArrayList<>(), martConnectionInfo, java.lang.String.class);

                    if(ObjectUtil.isNotEmpty(tgtRtnValue)){

                        List<Map<Integer, Object>> params = new ArrayList<Map<Integer, Object>>();

                        for(String data : tgtRtnValue) {
                            int sIdx = 1;
                            Map<Integer, Object> paramData = new HashMap<Integer, Object>();
                            if (camOfferTgtInfo.getOfferTypeCodeName().equals("C")) {
                                paramData.put(sIdx++, data);
                                paramData.put(sIdx++, camOfferRes.getOfrNo());
                            } else {
                                paramData.put(sIdx++, data);
                                paramData.put(sIdx++, camOfferRes.getOfrValAmt());
                                paramData.put(sIdx++, camOfferRes.getOfrSubType());
                                paramData.put(sIdx++, camOfferRes.getDescText());
                                paramData.put(sIdx++, camOfferRes.getUseExpirDay());

                            }
                            params.add(paramData);
                        }
                        addBatchService.addBatch(query.toString(), params,eshopConnectionInfo);


                        String camId = camOfferTgtInfo.getCamId();
                        if(mktCampaignMapper.updateOfferSendStatus(camId) > 0){
                            rtnValue.setSuccess(true);
                        }

                    } else {
                        rtnValue.setSuccess(false);
                        return rtnValue;
                    }

                }
                rtnValue.setSuccess(true);
            } else {
                throw new Exception();
            }
        } catch (Exception e) {
            LogUtil.error(e.getMessage(), e);
            rtnValue.setSuccess(false);
        }

        return rtnValue;
    }

}
