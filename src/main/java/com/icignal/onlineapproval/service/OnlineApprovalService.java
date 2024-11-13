package com.icignal.onlineapproval.service;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

import com.icignal.common.tranChnl.dto.request.TranChnlReqDto;
import com.icignal.common.tranChnl.mapper.TranChnlEshopMapper;
import com.icignal.common.tranChnl.service.TranChnlService;
import com.icignal.onlineapproval.dto.response.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.APPROVAL_STATUS;
import com.icignal.common.util.CommonUtil.CAMPAIGN_WORKFLOW_NODE_DATA_TYPE;
import com.icignal.common.util.CommonUtil.MKT_CAM_TYPE_CD;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.external.thundermail.dto.request.ThunderMailReqDto;
import com.icignal.external.thundermail.service.ThunderMailService;
import com.icignal.loyalty.membership.dto.request.LoyMbrTiersDetailReqDto;
import com.icignal.loyalty.membership.dto.request.LoyTierApprovalReqDto;
import com.icignal.loyalty.membership.service.LoyMbrService;
import com.icignal.onlineapproval.dto.request.ApprovalAdminDetailReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalAdminListReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalDetailReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalEmailTargetReqtDto;
import com.icignal.onlineapproval.dto.request.ApprovalEmpListReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalEmpReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalInsertReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalListReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalReqDto;
import com.icignal.onlineapproval.dto.request.ApprovalUpdateReqDto;
import com.icignal.onlineapproval.dto.request.ApproverItemDeleteReqDto;
import com.icignal.onlineapproval.dto.request.ApproverItemInsertReqDto;
import com.icignal.onlineapproval.dto.request.ApproverItemRejectReqDto;
import com.icignal.onlineapproval.dto.request.ApproverListReqDto;
import com.icignal.onlineapproval.dto.request.ApprvReqReqDto;
import com.icignal.onlineapproval.dto.request.AprvCountReqDto;
import com.icignal.onlineapproval.dto.request.AprvReportReqDto;
import com.icignal.onlineapproval.dto.request.AprvTemplateReqDto;
import com.icignal.onlineapproval.dto.request.CommonApprovalReqDto;
import com.icignal.onlineapproval.dto.request.ManualDtlValidCheckReqDto;
import com.icignal.onlineapproval.mapper.OnlineApprMapper;


@Service
public class OnlineApprovalService {

    @Autowired
    OnlineApprMapper onlineApprMapper;
    @Autowired
    ThunderMailService thunderMailService;
    @Autowired
    LoyMbrService loyMbrService;
    @Autowired
    TranChnlEshopMapper tranChnlEshopMapper;
    @Autowired
    private TranChnlService tranChnlService;

    /**
     * @return : StatusResDto
     * @programId : MKT_APR_002
     * @name : setApproval
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : el_approval (전자결제 승인 정보 관리 테이블)
     * @description : 전자결제 등록 - 신규 버튼 클릭 후 전자 결제 등록
     */
    public StatusResDto setApproval(ApprovalInsertReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        String id = CommonUtil.newRid();
        reqDto.setId(id);
        String aprvNo = onlineApprMapper.createAprvNo(reqDto);
        reqDto.setElecAprvNo(aprvNo);

        onlineApprMapper.insertApproval(reqDto);

        rtnValue.setMessage(id);
        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return : StatusResDto
     * @programId : MKT_APR_P02
     * @name : setItemApproval
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_elec_aprv_item (전자결제 승인자 관리 테이블)
     * @description : 전자결제 등록 -전자 결제 승인자 등록
     */

    public StatusResDto setItemApproval(ApproverItemInsertReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        reqDto.setSVCAlias("");
        String count;
        String seq;
        if (reqDto.getApvrType().equals("10")) {
            seq = onlineApprMapper.selectRefItemSeq(reqDto);
            count = onlineApprMapper.getRefApproverCount(reqDto);
        } else {
            count = onlineApprMapper.getApproverCount(reqDto);
            seq = onlineApprMapper.selectItemSeq(reqDto);
            onlineApprMapper.updateItemType(reqDto);
        }
        reqDto.setId(CommonUtil.newRid());
        reqDto.setSeq(seq);

        //결제 검토 체크
        if (reqDto.getAprbStatus().equals("013") && Integer.parseInt(count) != 0) {
            reqDto.setAprbStatus("");
        }
        onlineApprMapper.insertItemApproval(reqDto);
        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return : GridPagingResponseDTO
     * @programId : MKT_APR_001
     * @name : getMyElapproval
     * @date : 2015. 11. 30.
     * @author : 박지열
     * @table : mkt_elec_aprv (전자 결제 승인 관리 테이블)
     * @description : 내가 승인 요청한 캠페인 조회
     */
    public GridPagingResDto<ApprovalListResDto> getMyElapproval(ApprovalListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setSVCAlias("a");

        return new GridPagingResHelper<ApprovalListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                onlineApprMapper.selectMyElapproval(reqDto), AnnotationType.CommCode);
    }

    /**
     * @return : GridPagingResponseDTO
     * @programId : MKT_APR_001
     * @name : getMyElapproval2
     * @date : 2015. 11. 30.
     * @author : 박지열
     * @table : mkt_elec_aprv (전자 결제 승인 관리 테이블)
     * @description : 내가 승인할 캠페인 목록 조회
     */
    public GridPagingResDto<ApprovalListResDto> getMyElapproval2(ApprovalListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);


        return new GridPagingResHelper<ApprovalListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                onlineApprMapper.selectMyElapproval2(reqDto), AnnotationType.CommCode);
    }

    /**
     * @return : GridPagingResponseDTO
     * @programId : MKT_APR_001
     * @name : getRefElapproval
     * @date : 2015. 11. 30.
     * @author : 박지열
     * @table : mkt_elec_aprv (전자 결제 승인 관리 테이블)
     * @description : 내가 참조된 캠페인 목록 조회
     */
    public GridPagingResDto<ApprovalListResDto> getRefElapproval(ApprovalListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setSVCAlias("mea");

        return new GridPagingResHelper<ApprovalListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                onlineApprMapper.selectRefElapproval(reqDto));
    }

    /**
     * @return : MKTElapprovalDetailResponseDTO
     * @programId : MKT_APR_002
     * @name : getDetailAprv
     * @date : 2015. 11. 30.
     * @author : 박지열
     * @table : mkt_elec_aprv (전자 결제 승인 관리 테이블)
     * @description : 전자결재 정보 조회
     */
    public GridPagingResDto<ApprovalDetailResDto> getDetailAprv(ApprovalDetailReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setSVCAlias("mea");

        return new GridPagingResHelper<ApprovalDetailResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                onlineApprMapper.selectDetailAprv(reqDto));
    }

    /**
     * 캠페인 ID로 전자결제 정보 조회
     *
     * @return : MKTElapprovalDetailResponseDTO
     * @programId :
     * @name : getDetailAprvByCamId
     * @date : 2017. 12. 27.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public GridPagingResDto<ApprovalDetailResDto> getDetailAprvByCamId(ApprovalDetailReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setSVCAlias("mea");
        return new GridPagingResHelper<ApprovalDetailResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                onlineApprMapper.selectDetailAprvByCamId(reqDto));
    }

    /**
     * @return : GridPagingResponseDTO
     * @programId : MKT_APR_P02
     * @name : getAprvList
     * @date : 2015. 11. 30.
     * @author : 박지열
     * @table : mkt_elec_aprv_item (결재 승인자 관리 테이블)
     * @description : 결재 승인자 조회
     */
    public List<ApprvReqResDto> getAprvList(ApprvReqReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setSVCAlias("meai");

        return new AnnotationHelper<List<ApprvReqResDto>>(AnnotationType.CommCode, onlineApprMapper.selectAprvList(reqDto)).getItem();
    }

    /**
     * @return : GridPagingResponseDTO
     * @programId : MKT_APR_P02
     * @name : selecReftAprvList
     * @date : 2015. 11. 30.
     * @author : 박지열
     * @table : mkt_elec_aprv_item (결재 승인자 관리 테이블)
     * @description : 결재 참조자 조회
     */
    public List<ApprvReqResDto> getReftAprvList(ApprvReqReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setSVCAlias("meai");

        return onlineApprMapper.selecReftAprvList(reqDto);
    }


    /**
     * @return : MKTApprvReqRequestDTO
     * @programId : MKT_APR_002
     * @name : getCampaign
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : el_approval (전자결제 승인 정보 관리 테이블)
     * @description : 자결제 등록 - 캠페인 검색
     */

    public GridPagingResDto<ApprvCamListResDto> getCampaign(ApprvReqReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setSVCAlias("mcm");

        reqDto.setInDataAuthTargetColumn("mcm.CAM_PLAN_ORG_CD");
        return new GridPagingResHelper<ApprvCamListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                onlineApprMapper.selectCampaign(reqDto));
    }


    /**
     * @return : StatusResDto
     * @programId : MKT_APR_P02
     * @name : editAprvType
     * @date : 2015. 12. 02.
     * @author : 박지열
     * @table : mkt_elec_aprv (전자결제 관리 테이블)
     * @description : 결제 결제 유형 수정 - 전자 결제 상신/상신 취소/작성 중 등등에 따른 유형 변경
     */
    public StatusResDto editAprvType(ApprovalUpdateReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        String saveId = reqDto.getId();

        //결제 상신
        if (reqDto.getElecAprvStatusCd().equals(APPROVAL_STATUS.APPROVAL_IN_PROCESS.getCode())) {

            String codeType = onlineApprMapper.selectElCode(reqDto);
            //상신일 시 결재 반려 체크 후 결재 반려일 시 모든 승인자들을 초기값으로 되돌린다.(재상신)
            if (codeType.equals("020")) {
                onlineApprMapper.updateItemReStatusType(reqDto);
            }
            //결재 상신 누를 시 현재 결재 검토가 아닌 seq 1인 row Data를 가져오기.
            ApproverItemInsertReqDto item =
                    new AnnotationHelper<ApproverItemInsertReqDto>(AnnotationType.CommCode, onlineApprMapper.selectSeqOne(reqDto)).getItem();

            if (item != null) {
                reqDto.setId(item.getId());
                //로그로 남기기 위해 해당 건 flag 0으로 업데이트
                onlineApprMapper.deleteItemLogSave(reqDto);

                //같은 Data 다시 set(유형 바꿔 set)
                item.setId(CommonUtil.newRid());
                item.setAprbStatus("014");
                onlineApprMapper.insertItemApproval(item);
                reqDto.setId(saveId);
            }

        }
        if (reqDto.getElecAprvStatusCd().equals("011")) {
            onlineApprMapper.updateItemStatusType(reqDto);
        }

        ApprovalListReqDto dtlReq = new ApprovalListReqDto();
        dtlReq.setApvrId(reqDto.getApvrId());
        dtlReq.setDataVal(reqDto.getDataVal());

        onlineApprMapper.updateAprvType(reqDto);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return : StatusResDto
     * @programId : MKT_APR_002
     * @name : removeElapproval
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : el_approval (전자결제 승인 정보 관리 테이블)
     * @description : 결제 결제 삭제
     */
    public StatusResDto removeElapproval(ApprovalReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        reqDto.setSVCAlias("ag");
        onlineApprMapper.deleteElapproval(reqDto);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return : GridPagingResponseDTO
     * @programId : MKT_APR_P02
     * @name : getApproverList
     * @date : 2015. 11. 30.
     * @author : 박지열
     * @table : employee (직원 관리 테이블)
     * @description : 전자결제 등록 - 결제자 조회
     */
    public GridPagingResDto<ApprovalEmpListResDto> getApproverList(ApprovalEmpListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setSVCAlias("em");
        reqDto.setEmpType(onlineApprMapper.getEmpType(reqDto).getEmpType());

        return new GridPagingResHelper<ApprovalEmpListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                onlineApprMapper.selectApproverList(reqDto), AnnotationType.PersonalData);

    }


    /**
     * @return : GridPagingResponseDTO
     * @programId : MKT_APR_002
     * @name : getMember
     * @date : 2015. 11. 30.
     * @author : 박지열
     * @table : employee (직원 관리 테이블)
     * @description : 기안자 및 기안자 부서 조회
     */
    public ApprovalEmpResDto getMember(ApprovalEmpReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setSVCAlias("em");

        return onlineApprMapper.selectMember(reqDto);
    }

    /**
     * @return : StatusResDto
     * @programId : MKT_APR_P02
     * @name : removeItem
     * @date : 2015. 11. 30.
     * @author : 박지열
     * @table : mkt_elec_aprv_item (결재 승인자 관리 테이블)
     * @description : 결재 승인자 삭제
     */
    public StatusResDto removeItem(ApproverItemDeleteReqDto mid) {
        LogUtil.param(this.getClass(), mid);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        mid.setSVCAlias("");
        onlineApprMapper.deleteItem(mid);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    /**
     * @return : List<MKTApprvReqResponseDTO>
     * @programId : MKT_APR_001
     * @name : getApproverStatus
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : mkt_elec_aprv_item (전자결제 승인 정보 관리 테이블)
     * @description : 전자결제  승인상태 조회
     */
    public List<ApprvReqResDto> getApproverStatus(ApprvReqReqDto mer) {
        LogUtil.param(this.getClass(), mer);

        mer.setSVCAlias("meai");

        return onlineApprMapper.selectApproverStatus(mer);
    }
//////////////////////////수정필요

    /**
     * @return : StatusResDto
     * @programId : MKT_APR_001
     * @name : editReject
     * @date : 2015. 12. 02.
     * @author : 박지열
     * @table : mkt_elec_aprv (전자결제 관리 테이블)
     * @description : 결제 반려
     */
    public StatusResDto editReject(ApproverItemRejectReqDto majr) {
        LogUtil.param(this.getClass(), majr);
        String headerRid = majr.getId();

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        ApprovalListReqDto dtlReq = new ApprovalListReqDto();
        TranChnlReqDto tranChnlReq = new TranChnlReqDto();

        String callBackNo = null;
        String revcCallNo = null;

        onlineApprMapper.updateReject(majr);
        majr.setStatusCode("010");
        onlineApprMapper.updateRejectAprv(majr);

        if (!"06".equals(majr.getAprvType())) {
            String id = onlineApprMapper.selectRejectNxId(majr);

            if (ObjectUtil.isNotEmpty(id)) {
                majr.setId(id);
                onlineApprMapper.updateReStatus(majr);
            }
        }
        //editReject

        CommonApprovalReqDto param = new CommonApprovalReqDto();
        param.setSystemColumn(majr.getSystemColumn());
        param.setAprvType(majr.getAprvType());
        param.setRecordRid(majr.getRecordRid());
        param.setLastFlg(majr.getLastFlg());
        param.setCreateBy(majr.getCreateBy());
        param.setApvId(majr.getApvrId());
        param.setSVCAlias("a");
        CommonReqApprovalMstInfoResDto resVaild = onlineApprMapper.selectReqApprovalMstInfo(param);

        int seq = Integer.parseInt(majr.getSeq());
        StatusResDto rtnFn = new StatusResDto();

        if (APPROVAL_STATUS.APPROVAL_SUCCESS.getCode().equals(majr.getElecAprvStatusCd())) {

            if (!"06".equals(majr.getAprvType())) {

                seq = seq * 20;  // Ex) 1차 승인 20 , 2차승인 40
                param.setStatus(Integer.toString(seq));

                onlineApprMapper.updateApprovalStatCd(majr);
                boolean nextCheck = false;
                int checkSeq = Integer.parseInt(majr.getSeq());

                if (majr.getApprovalTypeCd() != null && majr.getApprovalTypeCd().equals("9")) {
                    dtlReq.setDataVal("02");
                    param.setLastFlg(true);
//                        sendEmpEmail(headerRid , "40");8
                } else {
                    dtlReq.setDataVal("01");
                    checkSeq = checkSeq + 1;
                    param.setLastFlg(false);
//                        sendEmpEmail(headerRid , "30");
                    nextCheck = true;
                }

                dtlReq.setApvrId(majr.getApvrId());
                dtlReq.setItemId(majr.getItemId());

                String msgSbst = onlineApprMapper.getAprvContentsVal(dtlReq).getContents();

                String martCode = "{{매장코드}}";
                String campaignCode = "{{캠페인명}}";

                if (msgSbst.indexOf(martCode) > -1) {
                    msgSbst = msgSbst.replace(martCode, majr.getElecAprvEmpNo());
                } else if (msgSbst.indexOf(campaignCode) > -1) {
                    msgSbst = msgSbst.replace(campaignCode, majr.getElecAprvTitle());
                }

                AprvSendContsResDto mobileNo = new AprvSendContsResDto();

                if (nextCheck) {
                    dtlReq.setNextYn("Y");
                    dtlReq.setCheckSeq(String.valueOf(checkSeq));
                    dtlReq.setElecAprvId(majr.getElecAprvId());
                    mobileNo = onlineApprMapper.getAprvContentsDetail(dtlReq);
                    revcCallNo = mobileNo.getResMobileNo();
                } else {
                    mobileNo = onlineApprMapper.getAprvContentsDetail(dtlReq);
                    revcCallNo = mobileNo.getReqMobileNo();
                }

                callBackNo = mobileNo.getReqMobileNo();

                tranChnlReq.setToCallbackNo("18990232");
                tranChnlReq.setRevcCallNo(revcCallNo);
                tranChnlReq.setMsgSbst(msgSbst);

                this.tranChnlService.tranApproLms(tranChnlReq);

                //rtnFn = callDynamicMethod(resVaild.getElecAprvFuncNm(), param);

            } else {
                modifyTierUpdate(majr);
            }
        }
        // 반려
        else if (APPROVAL_STATUS.APPROVAL_RETURN.getCode().equals(majr.getElecAprvStatusCd())) {
            String reject = null;

            dtlReq.setElecAprvId(majr.getId());
            dtlReq.setApvrId(majr.getApvrId());
            dtlReq.setDataVal("03");

            callBackNo = "18990232";
            revcCallNo = onlineApprMapper.getMidAprvNo(dtlReq).getReqMobileNo();

            String msgSbst = onlineApprMapper.getAprvContentsVal(dtlReq).getContents();

            String martCode = "{{매장코드}}";
            String campaignCode = "{{캠페인명}}";

            if(msgSbst.indexOf(martCode) > -1){
                msgSbst = msgSbst.replace(martCode, majr.getElecAprvEmpNo());
            } else if(msgSbst.indexOf(campaignCode) > -1){
                msgSbst = msgSbst.replace(campaignCode, majr.getElecAprvTitle());
            }

            tranChnlReq.setToCallbackNo(callBackNo);
            tranChnlReq.setRevcCallNo(revcCallNo);
            tranChnlReq.setMsgSbst(msgSbst);

            reject = majr.getRejectRsn();
            param.setRejectRsn(reject);
            //param.setRejectRsn(majr.getRejectRsn());
            seq = seq * 20 + 10;  // Ex) 1차 거절 30 , 2차거절 50
            param.setStatus(Integer.toString(seq));
            //rtnFn = callDynamicMethod(resVaild.getElecRjtFuncNm(), param);

            if (majr.getApprovalTypeCd() != null && majr.getApprovalTypeCd().equals("9")) {
                onlineApprMapper.updateApprovalStatCd(majr);
                //           sendEmpEmail(headerRid , "40");
            }

            //onlineApprMapper.updateApprovalStatCd(majr);

            //메일 발송
            //                sendEmpEmail(headerRid , "20");

            this.tranChnlService.tranApproLms(tranChnlReq);
        }

        //rtnFn.setSuccess(true);


        rtnValue.setSuccess(true);

        return rtnValue;
    }



    /*
     * 1. 메소드명: modifyTierUpdate
     * 2. 클래스명: OnlineApprovalService
     * 3. 작성자명: 서정환
     * 4. 작성일자: 2020. 8. 3.
     */

    /**
     * <PRE>
     * 1. 설명
     * <p>
     * 2. 사용법
     *
     * </PRE>
     *
     * @param majr
     */
    @Transactional
    private void modifyTierUpdate(ApproverItemRejectReqDto majr) {
        onlineApprMapper.updateApprovalStatCd(majr);
        LoyMbrTiersDetailReqDto tierHistReqDto = new LoyMbrTiersDetailReqDto();
        tierHistReqDto = onlineApprMapper.selectModfiyTier(majr);
        tierHistReqDto.setCreateBy(majr.getCreateBy());
        tierHistReqDto.setModifyBy(majr.getModifyBy());
        tierHistReqDto.setRid(CommonUtil.newRid());
        tierHistReqDto.setApproValId(majr.getId());
        onlineApprMapper.updateApprovalAttr(tierHistReqDto);
        loyMbrService.modifyTiers(tierHistReqDto);

    }

    /**
     * @return : MKTAprvCountResponseDTO
     * @programId : MKT_APR_002
     * @name : getMyRefCount
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : el_approval (전자결제 승인 정보 관리 테이블)
     * @description : 전자 결제 승인 건수 카운트(내가 참조된 목록)
     */
    public AprvCountResDto getMyRefCount(AprvCountReqDto mer) {
        LogUtil.param(this.getClass(), mer);

        mer.setSVCAlias("mea");

        return onlineApprMapper.selectMyRefCount(mer);
    }

    /**
     * @return : MKTAprvCountResponseDTO
     * @programId : MKT_APR_002
     * @name : getMyAgreeCount
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : el_approval (전자결제 승인 정보 관리 테이블)
     * @description : 전자 결제 승인 건수 카운트(내가 승인할 목록)
     */
    public AprvCountResDto getMyAgreeCount(AprvCountReqDto mer) {
        LogUtil.param(this.getClass(), mer);

        mer.setSVCAlias("mea");

        return onlineApprMapper.selectMyAgreeCount(mer);
    }

    /**
     * @return : MKTAprvCountResponseDTO
     * @programId : MKT_APR_002
     * @name : getMyAprvCount
     * @date : 2015. 9. 21.
     * @author : 박지열
     * @table : el_approval (전자결제 승인 정보 관리 테이블)
     * @description : 전자 결제 승인 건수 카운트
     */
    public AprvCountResDto getMyAprvCount(AprvCountReqDto mer) {
        LogUtil.param(this.getClass(), mer);

        mer.setSVCAlias("mea");

        return onlineApprMapper.selectMyAprvCount(mer);
    }


    /**
     * @return : StatusResDto
     * @programId : MKT_APR_P02
     * @name : removeItem
     * @date : 2015. 11. 30.
     * @author : 박지열
     * @table : mkt_elec_aprv_item (결재 승인자 관리 테이블)
     * @description : 결재 승인자 수정
     */
    public StatusResDto editItem(ApproverItemDeleteReqDto mid) {
        LogUtil.param(this.getClass(), mid);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        mid.setSVCAlias("");
        onlineApprMapper.updateItem(mid);

        rtnValue.setSuccess(true);

        return rtnValue;
    }


    /**
     * @return :
     * @programId :
     * @name : getReqApprovalMstInfo
     * @date : 2017. 11. 6.
     * @author : 이성원
     * @table :
     * @description :
     */
    public CommonReqApprovalMstInfoResDto getReqApprovalMstInfo(CommonApprovalReqDto param) {
        LogUtil.param(this.getClass(), param);

        param.setSVCAlias("a");

        return onlineApprMapper.selectReqApprovalMstInfo(param);
    }

    /**
     * @return : MKTCommonReqApprovalMstInfoResponseDTO
     * @programId :
     * @name : getEmpEmail
     * @date : 2018. 1. 31.
     * @author : 이성원
     * @table :
     * @description :
     */
    public String getEmpEmail(String param) {
        LogUtil.param(this.getClass(), param);
        return onlineApprMapper.selectEmpEmail(param);
    }


    /**
     * @return :
     * @programId :
     * @name : getTableRecordExist
     * @date : 2017. 11. 6.
     * @author : 이성원
     * @table :
     * @description :
     */
    public String getTableRecordExist(CommonApprovalReqDto param) {
        LogUtil.param(this.getClass(), param);

        param.setSVCAlias("a");
        String rtnSuc = onlineApprMapper.selectTableRecordExist(param);
        if (rtnSuc == null) {
            rtnSuc = "N";

        }
        return rtnSuc;

    }


    /**
     * @return :
     * @programId :
     * @name : insertApprovalHeader
     * @date : 2017. 11. 6.
     * @author : 이성원
     * @table :
     * @description :
     */
    public StatusResDto insertApprovalHeader(CommonApprovalReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        String rid = CommonUtil.newRid();
        param.setRid(rid);
        param.setSVCAlias("a");
        onlineApprMapper.insertApprovalHeader(param);
        rtnValue.setSuccess(true);
        rtnValue.setMessage(rid);
        return rtnValue;
    }


    /**
     * @return :
     * @programId :
     * @name : insertApprovalItem1
     * @date : 2017. 11. 6.
     * @author : 이성원
     * @table :
     * @description :
     */
    public StatusResDto insertApprovalItem(ApproverListReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        param.setSVCAlias("a");
        onlineApprMapper.insertApprovalItem(param);
        rtnValue.setSuccess(true);
        return rtnValue;
    }


    /**
     * @return :
     * @programId :
     * @name : insertApprovalItem2
     * @date : 2017. 11. 6.
     * @author : 이성원
     * @table :
     * @description :
     */
    public StatusResDto insertApprovalItem2(CommonApprovalReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        param.setSVCAlias("a");
        onlineApprMapper.insertApprovalItem2(param);
        rtnValue.setSuccess(true);
        return rtnValue;
    }


    /**
     * @return :
     * @programId :
     * @name : getApprovalAdminList
     * @date : 2017. 11. 7.
     * @author : 이성원
     * @table :
     * @description :
     */
    public GridPagingResDto<ApprovalAdminListResDto> getApprovalAdminList(ApprovalAdminListReqDto mer) {
        LogUtil.param(this.getClass(), mer);
        mer.setSVCAlias("a");
        return new GridPagingResHelper<ApprovalAdminListResDto>().newGridPagingResDto(
                mer.init(CommonUtil.getInstance().getDBType()),
                onlineApprMapper.selectApprovalAdminList(mer));
    }


    public ApprovalAdminDetailResDto getApprovalAdminDetail(ApprovalAdminDetailReqDto mer) {

        LogUtil.param(this.getClass(), mer);

        return onlineApprMapper.selectApprovalAdminDetail(mer);
    }


    public StatusResDto saveApprovalAdminDetail(ApprovalAdminDetailReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        param.setId(CommonUtil.newRid());
        param.setSVCAlias("a");
        onlineApprMapper.insertApprovalAdminDetail(param);
        rtnValue.setSuccess(true);
        return rtnValue;
    }


    /**
     * @return :
     * @programId :
     * @name : editApprovalAdminDetail
     * @date : 2017. 11. 7.
     * @author : 이성원
     * @table :
     * @description :
     */
    public StatusResDto editApprovalAdminDetail(ApprovalAdminDetailReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        param.setSVCAlias("a");
        onlineApprMapper.updateApprovalAdminDetail(param);
        rtnValue.setSuccess(true);
        return rtnValue;
    }


    public StatusResDto deleteApprovalAdminDetail(ApprovalAdminDetailReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        param.setSVCAlias("a");
        onlineApprMapper.deleteApprovalAdminDetail(param);
        rtnValue.setSuccess(true);
        return rtnValue;
    }

    public ManualDtlValidCheckReqDto getMenualApproval(CommonApprovalReqDto param) {
        LogUtil.param(this.getClass(), param);

        return onlineApprMapper.selectMenualApproval(param);
    }


    /**
     * @return :
     * @programId :
     * @name : getApproverDetail
     * @date : 2017. 11. 29.
     * @author : 이성원
     * @table :
     * @description :
     */
    public ApproverListResDto getApproverDetail(ApproverListReqDto param) {
        LogUtil.param(this.getClass(), param);

        return onlineApprMapper.selectApproverDetail(param);
    }


    /**
     * @return :
     * @programId :
     * @name : getMailTemplate
     * @date : 2018. 1. 16.
     * @author : 이성원
     * @table :
     * @description :
     */
    public AprvTemplateResDto getMailTemplate(AprvTemplateReqDto param) {
        LogUtil.param(this.getClass(), param);

        return onlineApprMapper.selectMailTemplate(param);
    }


    /**
     * @return :
     * @programId :
     * @name : getEmailTargetInfo
     * @date : 2018. 2. 1.
     * @author : 이성원
     * @table :
     * @description :
     */
    public ApprovalEmailTargetResDto getEmailTargetInfo(ApprovalEmailTargetReqtDto targetReq) {
        LogUtil.param(this.getClass(), targetReq);
        return onlineApprMapper.selectEmailTargetInfo(targetReq);
    }


    /**
     * @return :
     * @programId :
     * @name : getEmailInfo
     * @date : 2018. 2. 1.
     * @author : 이성원
     * @table :
     * @description :
     */
    public ApprovalEmailInfoResDto getEmailInfo(ApprovalEmailTargetReqtDto targetReq) {
        LogUtil.param(this.getClass(), targetReq);

        return onlineApprMapper.selectEmailInfo(targetReq);
    }

    /**
     * @return : int
     * @name : editLastItemApproval
     * @date : 2018. 03. 03.
     * @author : hy.jun
     * @table : mkt_elec_aprv_item (전자결제 승인자 관리 테이블)
     * @description : 전자결제 등록 - 마지막 결재승인자 최종승인자로 변경
     */
    public int editLastItemApproval(ApproverItemInsertReqDto mir) {
        LogUtil.param(this.getClass(), mir);
        return onlineApprMapper.editLastItemApproval(mir);
    }

    /**
     * @return : String
     * @name : getApproverCount
     * @table : mkt_elec_aprv_item (전자결제 승인자 관리 테이블)
     * @description : 결재아이템 개수 조회
     */
    public String getApproverCount(ApproverItemInsertReqDto mir) {
        LogUtil.param(this.getClass(), mir);
        return onlineApprMapper.getApproverCount(mir);
    }

    /**
     * @return : List
     * @name : getRequiredItemApproval
     * @date : 2018. 03. 06.
     * @author : hy.jun
     * @table : mkt_elec_aprv_item (전자결제 승인자 관리 테이블)
     * @description : 전자결제 등록 - 필수 결재승인자 목록 조회
     */
    public List<ApproverItemInsertReqDto> getRequiredItemApproval(ApproverItemInsertReqDto mir) {
        LogUtil.param(this.getClass(), mir);
        return onlineApprMapper.getRequiredItemApproval(mir);
    }

    /**
     * @return : List
     * @name : getNoRequiredItemApproval
     * @date : 2018. 03. 06.
     * @author : hy.jun
     * @table : mkt_elec_aprv_item (전자결제 승인자 관리 테이블)
     * @description : 전자결제 등록 - 현재 등록되어있는 결재승인자 목록 조회 (필수결재승인자 제외)
     */
    public List<ApproverItemInsertReqDto> getNoRequiredItemApproval(ApproverItemInsertReqDto mir) {
        LogUtil.param(this.getClass(), mir);
        return onlineApprMapper.getNoRequiredItemApproval(mir);
    }

    /**
     * @return : String
     * @name : setApprovalItemSave
     * @date : 2018. 03. 13.
     * @author : hy.jun
     * @description : 결재저장시 결재아이템 저장
     */
    public String setApprovalItemSave(ApproverListReqDto param) {
        LogUtil.param(this.getClass(), param);
        int cnt = onlineApprMapper.setApprovalItemSave(param);
        return String.valueOf(cnt);

    }

    /**
     * @return :
     * @programId :
     * @name : removeApprovalHeaderCampaign
     * @date : 2018. 5. 24.
     * @author : hy.jun
     * @table :
     * @description : 캠페인 결재 헤더 삭제
     */
    public StatusResDto removeApprovalHeaderCampaign(CommonApprovalReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto(false, "");
        int cnt = onlineApprMapper.removeApprovalHeaderCampaign(param);

        if (cnt > 0) {
            rtnValue.setSuccess(true);
        } else {
            rtnValue.setSuccess(false);
            rtnValue.setMessage("1");
        }

        return rtnValue;
    }

    /**
     * @return :
     * @programId :
     * @name : removeApprovalItemCampaign
     * @date : 2018. 5. 24.
     * @author : hy.jun
     * @table :
     * @description : 캠페인 결재 아이템 삭제
     */
    public StatusResDto removeApprovalItemCampaign(CommonApprovalReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto(false, "");
        onlineApprMapper.removeApprovalItemCampaign(param);
        rtnValue.setSuccess(true);

        return rtnValue;
    }

    //////////////////////////////////////

    /**
     * @return : StatusResponseDTO
     * @programId :
     * @name : sendEmpEmail
     * @date : 2018. 2. 1.
     * @author : 이성원
     * @table :
     * @description : [aprRid] 승인해더  Rid , [type]  10 요청 , 20 거절 , 30 승인 , 40 최종승인
     */
    public StatusResDto sendEmpEmail(String aprvRid, String type) {
        StatusResDto rtnVal = new StatusResDto();
        rtnVal.setSuccess(true);
//	    	// 메일 전송 대상 및 테이블 , Record Rid 조회
//	    	ApprovalEmailTargetReqtDto targetReq = new ApprovalEmailTargetReqtDto();
//	    	targetReq.setAprvRid(aprvRid);
//	    	targetReq.setType(type);
//	    	ApprovalEmailTargetResDto targetRes = onlineApprMapper.selectEmailTargetInfo(targetReq);
//	    	if (targetRes == null ){
//	    		// 대상 없음
//	    		return rtnVal;
//	    	}
//
//	    	ApprovalEmailInfoResDto infoRes = onlineApprMapper.selectEmailInfo(targetReq);
//	    	infoRes.setAprvRid(aprvRid);
//
//	    	AprvTemplateReqDto templReq = new AprvTemplateReqDto();
//	    	ThunderMailReqDto sendReq = new ThunderMailReqDto();
//
//
//	    	if(type.equals("10")){	//요청
//	    		templReq.setReq_user(infoRes.getRqtrNm()); //결재 요청자 성명
//	    		sendReq.setEmailAddr(targetRes.getApvrEmail());
//	    		sendReq.setReceiverName(targetRes.getApvrNm()); //결재검토중 성명
//	    		
//	    		infoRes.setApvrNm(""); //요청 시에는 직전 승인처리자가 존재하지 않으므로 빈값 처리한다.
//	    		
//	    	}else if(type.equals("20")){ // 반려
//	    		templReq.setReq_user(infoRes.getApvrNm()); //반려 처리자 성명
//	    		sendReq.setEmailAddr(targetRes.getRqtrEmail());
//	    		sendReq.setReceiverName(targetRes.getRqtrNm()); //결재 요청자 성명
//	    	}else if(type.equals("30")){ // 승인
//	    		templReq.setReq_user(infoRes.getApvrNm()); //직전 승인 처리자 성명
//	    		sendReq.setEmailAddr(targetRes.getApvrEmail());
//	    		sendReq.setReceiverName(targetRes.getApvrNm()); //결재검토중 성명
//	    	}else if(type.equals("40")){ // 최종 승인
//	    		templReq.setReq_user(infoRes.getApvrNm()); //직전 승인 처리자 성명
//	    		sendReq.setEmailAddr(targetRes.getRqtrEmail());
//	    		sendReq.setReceiverName(targetRes.getRqtrNm()); //결재 요청자 성명
//	    	}else{
//	    		rtnVal.setSuccess(false);
//	    		return rtnVal;
//	    	}
//
//
//	    	if(sendReq.getEmailAddr()!=null && !sendReq.getEmailAddr().equals("")){
//		    	// 템플릿 조회 및  치환
//		    	templReq.setReq_status(infoRes.getType());
////		    	templReq.setApvStatus(type.equals("40") ? "30" : type);
//		    	templReq.setApvStatus(type);
//		    	templReq.setApvType(targetRes.getAprvType());
//		    	AprvTemplateResDto templRes = getMailTemplate(templReq);
//
//
//
//
//		    	if(templRes!=null && templRes.getContent()!=null && !templRes.getContent().equals("")){
//		    		//메일전송 ThunderMail 전용
//		        	sendReq.setEmailTitle(templRes.getTitle());
//		        	sendReq.setComment(templRes.getContent());
//		        	sendReq.setActionRID("");
//		        	sendReq.setMsgType("");
//		        	//rtnVal = thunderMailService.sendEmailAutoMail(sendReq);
//		        	
//		        	rtnVal.setSuccess(true);
//
//		    	} else if(ObjectUtil.isNotEmpty(templRes.getAutomailID())) {
//		    		sendReq.setAutomailID(templRes.getAutomailID());
//		    		sendReq.setOnetooneInfoMap(setOnetooneInfo(infoRes, sendReq));
//		    		//rtnVal = thunderMailService.sendEmailAutoMail(sendReq);
//		    		
//		    		rtnVal.setSuccess(true);
//		    		
//		    		//결재 요청자에게 모든 전자결재 진행과정에 대한 알림메일 발송로직 추가 필요
//		    	}
//	    	}
//
        return rtnVal;
    }


    public StatusResDto callDynamicMethod(String methodNm, Object param) {

        StatusResDto rtnMethod = new StatusResDto();

        Object obj = this;
        Class cls = obj.getClass();
        Class[] paramsType = {param.getClass()};
        Object paramsValue[] = {param};

        try {
            Method callMethod = cls.getMethod(methodNm, paramsType);
            rtnMethod = (StatusResDto) callMethod.invoke(obj, paramsValue);

        } catch (NoSuchMethodException | SecurityException e) {

            LogUtil.error(e);
        } catch (IllegalAccessException e) {

            LogUtil.error(e);
        } catch (IllegalArgumentException e) {

            LogUtil.error(e);
        } catch (InvocationTargetException e) {

            LogUtil.error(e);
        }

        return rtnMethod;
    }

    /**
     * @return : HashMap<String,String>
     * @programId :
     * @name : setOnetooneInfo
     * @date : 2018. 12. 5.
     * @author : hy.jun
     * @table :
     * @description : 업무유형별 썬더메일 자동메일api 일대일치환값 세팅
     */
    public HashMap<String, String> setOnetooneInfo(ApprovalEmailInfoResDto infoRes, ThunderMailReqDto sendReq) {
        HashMap<String, String> map = new HashMap<String, String>();

        //승인업무 유형 : 캠페인
        if (infoRes.getElecAprvType().equals(CommonUtil.MKT_ELEC_APRV_TYPE.CAMPAIGN.getValue())) {

            //캠페인 정보 조회
            HashMap<String, String> camInfo = onlineApprMapper.getCampaignInfoByElecAprvId(infoRes);

            map.put("etc1", StringUtil.convertNull(camInfo.get("dispNo"), ""));
            map.put("etc2", StringUtil.convertNull(camInfo.get("camNm"), ""));
            map.put("etc3", StringUtil.convertNull(camInfo.get("camDesc"), ""));
            map.put("etc4", StringUtil.convertNull(camInfo.get("pntAccntBigTypeCdNm"), "")); //지급계정 대분류
            map.put("etc5", StringUtil.convertNull(camInfo.get("pntAccntMidTypeCdNm"), "")); //지급계정 중분류
            map.put("etc6", StringUtil.convertNull(camInfo.get("pntAccntSmlTypeCdNm"), "")); //지급계정 소분류
            map.put("etc7", StringUtil.convertNull(camInfo.get("pntAccntDetailTypeCdNm"), "")); //지급계정 세분류
            map.put("etc8", StringUtil.convertNull(camInfo.get("pntAccntCustDispTxt"), "")); //안내문구
            map.put("etc9", StringUtil.convertNull(camInfo.get("camStartDd"), ""));
            map.put("etc10", StringUtil.convertNull(camInfo.get("camEndDd"), ""));
            map.put("etc11", StringUtil.convertNull(infoRes.getRqtrNm(), "")); //전자결재 요청자
            map.put("etc12", StringUtil.convertNull(infoRes.getApvrNm(), "")); //직전 처리자. 요청 시에는 직전 승인처리자가 존재하지 않으므로 빈값 처리한다.
            map.put("name", StringUtil.convertNull(sendReq.getReceiverName(), "")); //이메일 수신자명
            map.put("etc13", StringUtil.convertNull(infoRes.getRejectRsn(), "")); //반려사유
        }

        return map;
    }

    /**
     * 캠페인 결제 상신
     *
     * @programId :
     * @name : campaignRequestApproval
     * @date : 2017. 12. 27.
     * @author : jh.kim
     * @description :
     */
    public StatusResDto campaignRequestApproval(CommonApprovalReqDto param) {
        LogUtil.param(this.getClass(), param);

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);

        // 캠페인 '저장' 시 생성된 결재 헤더.아이템 삭제
        int cnt = onlineApprMapper.removeApprovalHeaderCampaign(param);

        if (cnt > 0) {
            rtnValue.setSuccess(true);
        } else {
            rtnValue.setSuccess(false);
            rtnValue.setMessage("1");
        }

        if (rtnValue.getSuccess()) {
            onlineApprMapper.removeApprovalItemCampaign(param);
        } else {
            return rtnValue;
        }

        // 승인요청 프로세스
        rtnValue = requestApproval(param);
        rtnValue.setSuccess(true);

        LogUtil.debug("campaignRequestApproval ------ request approval result ------ ");
        LogUtil.debug("campaignRequestApproval :: success = " + rtnValue.getSuccess());
        LogUtil.debug("campaignRequestApproval :: message = " + rtnValue.getMessage());

        // 상태 변경
        if (rtnValue.getSuccess()) {
            ApprovalUpdateReqDto meur = new ApprovalUpdateReqDto();
            meur.setSystemColumn(param.getSystemColumn());
            meur.setId(param.getRid());
            meur.setElecAprvStatusCd(APPROVAL_STATUS.APPROVAL_IN_PROCESS.getCode());

            rtnValue = editAprvType(meur);
        }

        return rtnValue;
    }

    /**
     * @return : StatusResponseDTO
     * @programId :
     * @name : requestApproval
     * @date : 2017. 11. 3.
     * @author : 이성원
     * @table :
     * @description :
     */
    public StatusResDto requestApproval(CommonApprovalReqDto param) {
        LogUtil.param(this.getClass(), param);
        //param.setMem
        StatusResDto rtnVal = new StatusResDto();

        //=========================================================================================
        // 1. input validation
        // 1.1 필수값 체크
        if (ObjectUtil.isEmpty(param.getAprvType()) ||
                ObjectUtil.isEmpty(param.getAprvTitle()) ||
                ObjectUtil.isEmpty(param.getReqRid()) ||
                ObjectUtil.isEmpty(param.getApproverList()) ||
                ObjectUtil.isEmpty(param.getRecordRid())) {
            rtnVal.setSuccess(false);
            rtnVal.setMessage("필수값 에러");
            return rtnVal;
        }

        //1.2  요청자 , 데이터 체크
//        param.setSVCAlias("a");
//        CommonReqApprovalMstInfoResDto resVaild = onlineApprMapper.selectReqApprovalMstInfo(param);
//        param.setElecAprvTblNm(resVaild.getElecAprvTblNm());

        try {
//            if (!resVaild.getReqRidSuc()) {
//                rtnVal.setErrorType(003);
//                rtnVal.setSuccess(false);
//                rtnVal.setMessage("요청자가 올바르지 않습니다.");
//                return rtnVal;
//            }

            // 1.3 승인자 조회 및 체크
            int maxSeq = 0;
            List<ApproverListReqDto> approverList = param.getApproverList();
            List<ApproverListResDto> approverDetailList = new ArrayList<>();
            for (ApproverListReqDto approver : approverList) {

                ApproverListResDto approverDetail = onlineApprMapper.selectApproverDetail(approver);
                String seq = approver.getSeq();
                approverDetail.setSeq(seq);
                approverDetailList.add(approverDetail);

                if (maxSeq < Integer.parseInt(seq)) maxSeq = Integer.parseInt(seq);
            }

            for (ApproverListResDto approverDetail : approverDetailList) {
                if (approverDetail.getValid().equals("N")) {
                    rtnVal.setErrorType(004);
                    rtnVal.setSuccess(false);
                    rtnVal.setMessage("승인자가 올바르지 않습니다.");
                    return rtnVal;
                }
            }

            //=========================================================================================
            // 2.승인 요청 내용 생성
            // 2.1해더 생성
            StatusResDto resHeader = insertApprovalHeader(param);
            param.setRid(resHeader.getMessage());

            //2.2아이템 생성
            for (ApproverListReqDto approver : approverList) {

                approver.setApprRid(resHeader.getMessage());
                approver.setCreateBy(param.getCreateBy());
                approver.setModifyBy(param.getModifyBy());
                if (maxSeq == Integer.parseInt(approver.getSeq())) {
                    approver.setApvrTypeCd("9");
                } else {
                    approver.setApvrTypeCd("2");
                }
                insertApprovalItem(approver);
            }

            //=========================================================================================
            // 3. 요청후 함수 호출
//            if (ObjectUtil.isNotEmpty(resVaild.getElecReqFuncNm())) {
            param.setStatus("10");//1차 승인요청
            //callDynamicMethod(resVaild.getElecReqFuncNm(), param);

            ApprovalListReqDto dtlReq = new ApprovalListReqDto();
            dtlReq.setApvrId(param.getApvrId());
            dtlReq.setDataVal(param.getDataVal());
            dtlReq.setElecAprvId(resHeader.getMessage());

            AprvSendContsResDto mobileNo = new AprvSendContsResDto();
            mobileNo = onlineApprMapper.getMidAprvNo(dtlReq);

            String callBackNo = mobileNo.getReqMobileNo();
            String revcCallNo = mobileNo.getResMobileNo();

            String msgSbst = onlineApprMapper.getAprvContentsVal(dtlReq).getContents();

            String martName = "{{매장명}}";
            String martCode = "{{매장코드}}";
            String campaignCode = "{{캠페인명}}";

            if (msgSbst.indexOf(martCode) > -1) {
                msgSbst = msgSbst.replace(martName, param.getElecAprvEmpName());
                msgSbst = msgSbst.replace(martCode, param.getElecAprvEmpNo());
            } else if (msgSbst.indexOf(campaignCode) > -1) {
                msgSbst = msgSbst.replace(campaignCode, param.getElecAprvTitle());
            }

            TranChnlReqDto tranChnlReq = new TranChnlReqDto();
            tranChnlReq.setToCallbackNo("18990232");
            tranChnlReq.setRevcCallNo(revcCallNo);
            tranChnlReq.setMsgSbst(msgSbst);
            this.tranChnlService.tranApproLms(tranChnlReq);

//            }

            //=========================================================================================
            // 4. 승인요청 메일 발송
            //      sendEmpEmail(param.getRid() , "10");
        } catch (Exception e) {
            rtnVal.setErrorType(999);
            rtnVal.setSuccess(false);
            rtnVal.setMessage("승인요청에 실패하였습니다. 관리자에게 문의하십시오.");
            LogUtil.error(e);
            return rtnVal;
        }
        rtnVal.setSuccess(true);
        return rtnVal;
    }

    /**
     * @return : StatusResponseDTO
     * @name : setRequiredItemApproval
     * @date : 2018. 03. 03.
     * @author : hy.jun
     * @table : mkt_elec_aprv_item (전자결제 승인자 관리 테이블)
     * @description : 전자결제 등록 -전자 결제 승인자 등록 완료 후 필수 결재 승인자 추가 (필수 결재 승인자는 공통코드로 관리.MKT_EL_APPROVAL_REQUIRED)
     */
    public StatusResDto setRequiredItemApproval(ApproverItemInsertReqDto mir) {

        StatusResDto rtnValue = new StatusResDto(false, "");

        //필수결재승인자 제외한 현재 등록된 결재승인자 목록
        List<ApproverItemInsertReqDto> noRequiredItemList = getNoRequiredItemApproval(mir);
        //필수결재승인자 목록
        List<ApproverItemInsertReqDto> requireditemList = getRequiredItemApproval(mir);

        //등록된 & 등록할 결재승인자 미존재 시
/*				if(ObjectUtil.isEmpty(noRequiredItemList) && ObjectUtil.isEmpty(requireditemList)) {
					rtnValue.setSuccess(true);
					rtnValue.setErrorType(1);
					return rtnValue;
				}*/


        //기존 결재승인자 목록 전체 삭제
        ApproverItemDeleteReqDto mid = new ApproverItemDeleteReqDto();
        mid.setId(mir.getAprvId());
        removeItem(mid);

        int seq = 1;
        //필수결재승인자 제외한 현재 등록된 결재승인자 등록
        for (ApproverItemInsertReqDto noRequiredItem : noRequiredItemList) {

            ApproverListReqDto param = new ApproverListReqDto();

            param.setCreateBy(mir.getMemId());
            param.setApprRid(mir.getAprvId());
            param.setApvrTypeCd("2");
            param.setId(noRequiredItem.getArvrId());
            param.setSeq(Integer.toString(seq));

            setApprovalItemSave(param);

            seq++;
        }

        //필수결재승인자 등록
        for (ApproverItemInsertReqDto requireditem : requireditemList) {

            ApproverListReqDto param = new ApproverListReqDto();

            param.setCreateBy(mir.getMemId());
            param.setApprRid(mir.getAprvId());
            param.setApvrTypeCd("2");
            param.setId(requireditem.getArvrId());
            param.setSeq(Integer.toString(seq));

            setApprovalItemSave(param);

            seq++;
        }

        rtnValue.setSuccess(true);

        //마지막 결재승인자 최종승인자로 변경
        String lastIdx = getApproverCount(mir);
        mir.setSeq(lastIdx);
        editLastItemApproval(mir);


        return rtnValue;
    }

    public List<ApprovalResDto> getElapproval(ApprovalReqDto mer) {
        mer.setSVCAlias("ag");
        return onlineApprMapper.selectElapproval(mer);
    }

    public StatusResDto editElapproval(ApprovalUpdateReqDto mer) {
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        onlineApprMapper.updateElapproval(mer);

        rtnValue.setSuccess(true);

        return rtnValue;
    }

    public AprvReportResDto getCampaignReportInfo(AprvReportReqDto param) {
        AprvReportResDto allInfo = new AprvReportResDto();
        //기본정보 조회
        AprvReportCampaignResDto camDefaultInfo = onlineApprMapper.selectCampaignDefaultInfo(param);
        allInfo.setCampaignDefaultInfo(camDefaultInfo);

        //승인자 목록
        allInfo.setApprovalList(onlineApprMapper.selectApprovalList(param));

        //오퍼 조회
        //allInfo.setOfferInfo(onlineApprMapper.selectOfferInfo(param));

        //쿠폰 조회
        //allInfo.setCoupnInfo(onlineApprMapper.selectCoupnInfo(param));

        //타겟팅 정보
        allInfo.setTargetingInfo(onlineApprMapper.selectTargetingInfo(param));

        //프로모션 정보
        //  allInfo.setPromInfo(onlineApprMapper.selectPromInfo(param));

        //일정정보
        AprvReportSchedulingResDto schedulingInfo = onlineApprMapper.selectSchedulingInfo(param);
        if (ObjectUtil.isNotEmpty(schedulingInfo)) {
            schedulingInfo.setDtlList(onlineApprMapper.selectSchedulingDtlList(param));
            allInfo.setSchedulingInfo(schedulingInfo);
        }

        //콘텐츠 정보
        allInfo.setContsList(onlineApprMapper.selectContsList(param));

        //이벤트 트리거일 경우 노드 조회
        if (MKT_CAM_TYPE_CD.TRIGGER.name().equals(camDefaultInfo.getCamTypeCd())) {
            List<List<AprvReportNodeResDto>> allNodeList = new ArrayList<>();
            List<AprvReportNodeResDto> nodeList = new ArrayList<>();

            List<AprvReportNodeResDto> startNodeList = onlineApprMapper.selectStartNodeList(param);
            for (AprvReportNodeResDto startNode : startNodeList) {
                nodeList = new ArrayList<>();

                //룰&액션 정보 조회
                if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.ETCOND.name().equals(startNode.getNodeTypeCd())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.ETACT.name().equals(startNode.getNodeTypeCd())) {
                    param.setActTaskId(startNode.getActTaskId());
                    startNode.setRuleInfo(onlineApprMapper.selectRuleInfo(param));
                }
                //채널정보
                else {
                    param.setContsId(startNode.getActTaskId());
                    startNode.setChnlInfo(onlineApprMapper.selectContsInfo(param));
                }
                nodeList.add(startNode);

                nodeList.addAll(childNodeList(startNode.getTaskNodeId(), param));
                allNodeList.add(nodeList);
            }
            allInfo.setEventNodeList(allNodeList);
        }

        //연관 캠페인 조회
        allInfo.setRelCampaignList(onlineApprMapper.selectRelCampaignList(param));

        allInfo.setSuccess(true);
        return allInfo;
    }


    /**
     * 이벤트 트리거 하위 노드 정보 조회
     *
     * @param taskNodeId
     * @param param
     * @return
     * @programId :
     * @name : childNodeList
     * @date : 2018. 3. 2.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public List<AprvReportNodeResDto> childNodeList(String taskNodeId, AprvReportReqDto param) {

        List<AprvReportNodeResDto> rtnChildNodeList = new ArrayList<>();

        param.setTaskNodeId(taskNodeId);
        List<AprvReportNodeResDto> childNodeList = onlineApprMapper.selectChildNodeList(param);

        if (ObjectUtil.isNotEmpty(childNodeList) && childNodeList.size() > 0) {
            for (int i = 0; i < childNodeList.size(); i++) {
                AprvReportNodeResDto childNode = childNodeList.get(i);

                //룰&액션 정보 조회
                if (CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.ETCOND.name().equals(childNode.getNodeTypeCd())
                        || CAMPAIGN_WORKFLOW_NODE_DATA_TYPE.ETACT.name().equals(childNode.getNodeTypeCd())) {
                    param.setActTaskId(childNode.getActTaskId());
                    childNode.setRuleInfo(onlineApprMapper.selectRuleInfo(param));
                    rtnChildNodeList.add(childNode);
                }
                //채널정보
                else {
                    param.setContsId(childNode.getActTaskId());
                    childNode.setChnlInfo(onlineApprMapper.selectContsInfo(param));
                    rtnChildNodeList.add(childNode);
                }

                // 하위 노드 조회
                if (i == childNodeList.size() - 1) {
                    List<AprvReportNodeResDto> cChildNodeList = childNodeList(childNode.getsNode(), param);
                    rtnChildNodeList.addAll(cChildNodeList);
                }
            }
        }
        return rtnChildNodeList;
    }

    public AprvReportCampaignResDto getCampaignDefaultInfo(AprvReportReqDto mcr) {
        return onlineApprMapper.selectCampaignDefaultInfo(mcr);
    }

    /*
     * 1. 메소드명: saveTierApproval
     * 2. 클래스명: OnlineApprovalService
     * 3. 작성자명: 서정환
     * 4. 작성일자: 2020. 7. 29.
     */

    /**
     * <PRE>
     * 1. 설명
     * 등급변경 승인요청 저장
     * 2. 사용법
     *
     * </PRE>
     *
     * @param reqDto
     */
    @Transactional
    public StatusResDto saveTierApproval(LoyTierApprovalReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();
        ApprovalInsertReqDto reqsDto = new ApprovalInsertReqDto();
        reqDto.setRid(CommonUtil.newRid());
        reqDto.setAprvoRid(reqDto.getRid());
        String aprvNo = onlineApprMapper.createAprvNo(reqsDto);
        reqDto.setElecAprvNo(aprvNo);
        onlineApprMapper.insertTierApproval(reqDto);
        reqDto.setRid(CommonUtil.newRid());
        onlineApprMapper.insertTierApprovalItem(reqDto);
        rtnValue.setSuccess(true);
        rtnValue.setMessage("승인이 요청되었습니다.");
        return rtnValue;

    }

    /**
     * @return : GridPagingResponseDTO
     * @programId : MKT_APR_P02
     * @name : getApproverList
     * @date : 2015. 11. 30.
     * @author : 박지열
     * @table : employee (직원 관리 테이블)
     * @description : 전자결제 등록 - 결제자 조회
     */
    public GridPagingResDto<ApprovalEmpListResDto> getStoreManagerInfo(ApprovalEmpListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        reqDto.setSVCAlias("em");

        ApprovalEmpListResDto empType = new ApprovalEmpListResDto();
        empType = onlineApprMapper.getEmpType(reqDto);

        reqDto.setEmpType(empType.getEmpType());
        reqDto.setDivRid(empType.getDivRid());

        if (empType.getDivNo().equals("S1048")) {
            //DX팀은 팀장 > 총괄로 2번 결재
            reqDto.setCheckDiv("DX");
        }

        return new GridPagingResHelper<ApprovalEmpListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                onlineApprMapper.getStoreManagerInfo(reqDto), AnnotationType.PersonalData);

    }
}
