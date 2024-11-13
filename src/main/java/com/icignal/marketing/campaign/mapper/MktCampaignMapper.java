package com.icignal.marketing.campaign.mapper;

import java.util.List;

import com.icignal.marketing.campaign.dto.request.*;
import com.icignal.marketing.campaign.dto.response.*;
import com.icignal.marketing.contents.dto.request.MktContentReqDto;
import com.icignal.offer.dto.request.OfferReqDto;
import com.icignal.offer.dto.response.OfferResDto;
import org.apache.ibatis.annotations.Mapper;


/**
 * @name : IMktCampaign.java
 * @date : 2015. 9. 23.
 * @author : dg.ryu
 * @description : 캠페인 DAO Interface
 */
@Mapper
public interface MktCampaignMapper {

    /**
     * @programId : Mkt_MNG_001
     * @name : selectCampaignList
     * @date : 2015. 9. 23.
     * @author : dg.ryu
     * @description : 캠페인 목록
     */
    public List<MktCampaignListResDto> selectCampaignList(MktCampaignReqDto param);


    /**
     * @programId :
     * @name : selectCampaignAuth
     * @date : 2022. 1. 19.
     * @author : sj.jung
     * @description : 캠페인 권한
     */
    public List<MktCampaignListResDto> selectCampaignAuth(MktCampaignReqDto param);
    
    /**
     * @programId : Mkt_MNG_001
     * @name : insertCampaignWorkflowStatus
     * @date : 2015. 9. 23.
     * @author : dg.ryu
     * @description : 캠페인 워크플로우 진행현황 등록
     */
    public void insertCampaignWorkflowStatus(MktCampaignWorkflowStatusReqDto mcwsr);

    /**
     * @programId : Mkt_MNG_P02
     * @name : selectCampaignDefaultInfo
     * @date : 2015. 10. 16.
     * @author : dg.ryu
     * @table : mkt.mkt_campaign
     * @return : 
     * @description : 캠페인 기본정보 조회
     */
    public MktCampaignDefaultInfoResDto selectCampaignDefaultInfo(MktCampaignReqDto mcr);

    /**
     * @programId : Mkt_MNG_P02
     * @name : insertCampaignMaster
     * @date : 2015. 10. 16.
     * @author : dg.ryu
     * @table : mkt.mkt_campaign
     * @return : 
     * @description : 캠페인 마스터 등록
     */
    public void insertCampaignMaster(MktCampaignDefaultInfoReqDto mcdir);

    /**
     * @programId : Mkt_MNG_P02
     * @name : updateCampaignMaster
     * @date : 2015. 10. 19.
     * @author : dg.ryu
     * @table : mkt.mkt_campaign
     * @return : 
     * @description : 캠페인 마스터 수정(기본정보 수정)
     */
    public void updateCampaignMaster(MktCampaignDefaultInfoReqDto mcdir);

    /**
     * @programId : Mkt_MNG_P02
     * @name : updateCampaignWorkflowStatus
     * @date : 2015. 10. 19.
     * @author : dg.ryu
     * @table : mkt.mkt_cmn_wf_cam
     * @return : 
     * @description : 캠페인 워크플로우 진행현황 수정
     */
    public void updateCampaignWorkflowStatus(MktCampaignWorkflowStatusReqDto mcwsr);
    
    /**
     * @programId : 
     * @name : selectCampaignWorkflowStatusList
     * @date : 2015. 10. 19.
     * @author : dg.ryu
     * @table : 
     * @return : 
     * @description : 캠페인 워크플로우 진행현황 목록
     */
    public List<MktCampaignWorkflowStatusListResDto> selectCampaignWorkflowStatusList(MktCampaignWorkflowStatusReqDto mcwsr);

    /**
     * @programId : Mkt_MNG_P02
     * @name : deleteAllCampaignWorkflowStatusByWorkflowId
     * @date : 2015. 10. 20.
     * @author : dg.ryu
     * @table : mkt.mkt_cmn_wf_cam
     * @return : 
     * @description : 캠페인 워크플로우 진행현황 삭제 by workflow ID
     */
    public void deleteAllCampaignWorkflowStatusByWorkflowId(MktCampaignWorkflowStatusReqDto mcwsr);

    /**
     * @programId : Mkt_MNG_P02
     * @name : selectCampaignIdCheck
     * @date : 2015. 10. 20.
     * @author : dg.ryu
     * @table : mkt.mkt_campaign
     * @return : 
     * @description : 캠페인 아이디 확인
     */
    public Integer selectCampaignIdCheck(MktCampaignDefaultInfoReqDto mcdir);

    /**
     * @programId : 
     * @name : updateCampaignWorkflowRel
     * @date : 2015. 10. 21.
     * @author : dg.ryu
     * @table : 
     * @return : 
     * @description : 캠페인 워크플로우 관계 수정
     */
    public void updateCampaignWorkflowRel(MktCampaignWorkflowReqDto mcwr);

    /**
     * @programId : Mkt_MNG_P13
     * @name : selectCampaignProgramList
     * @date : 2015. 10. 27.
     * @author : dg.ryu
     * @table : mkt.mkt_prog
     * @return : 
     * @description : 캠페인 프로그램 목록 조회
     */
    public List<MktCampaignProgramListResDto> selectCampaignProgramList(MktCampaignProgramReqDto mcpr);

    /**
     * @programId : Mkt_MNG_P13
     * @name : insertCampaignProgram
     * @date : 2015. 10. 27.
     * @author : dg.ryu
     * @table : mkt.mkt_prog
     * @return : 
     * @description : 캠페인 프로그램 등록
     */
    public void insertCampaignProgram(MktCampaignProgramReqDto mcpr);
    
    /**
     * @programId : Mkt_MNG_P13
     * @name : selectCampaignProgNo
     * @date : 2015. 10. 27.
     * @author : dg.ryu
     * @table : mkt.mkt_prog
     * @return : 
     * @description : 프로그램 번호 생성
     */
    public String selectCampaignProgNo(MktCampaignProgramReqDto mcpr);

    /**
     * @programId : Mkt_MNG_P13
     * @name : deleteCampaignProgram
     * @date : 2015. 10. 27.
     * @author : dg.ryu
     * @table : mkt.mkt_prog
     * @return : 
     * @description : 캠페인 프로그램 삭제
     */
    public void deleteCampaignProgram(MktCampaignProgramReqDto mcpr);

    /**
     * @programId : Mkt_MNG_001
     * @name : updateCampaignStatus
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst
     * @return : 
     * @description : 캠페인 상태 수정
     */
    public void updateCampaignStatus(MktCampaignDefaultInfoReqDto mcdir);
    
    /**
     * @programId : Mkt_MNG_001
     * @name : updateCampaignExeInfoStatusActive
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst
     * @return : 
     * @description : 캠페인 상태 수정(활성)
     */
    public void updateCampaignExeInfoStatusActive(MktCampaignDefaultInfoReqDto mcdir);
    
    /**
     * @programId : Mkt_MNG_001
     * @name : updateCampaignExeInfoStatusStop
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst
     * @return : 
     * @description : 캠페인 실행정보아이템 수정(중지)
     */
    public void updateCampaignExeInfoStatusStop(MktCampaignDefaultInfoReqDto mcdir);

    /**
     * @programId : Mkt_MNG_001
     * @name : updateCampaignExeInfoChnlStatusStop
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst
     * @return :
     * @description : 캠페인 실행정보채널 수정(중지)
     */
    public void updateCampaignExeInfoChnlStatusStop(MktCampaignDefaultInfoReqDto mcdir);
    
    /**
     * @programId : 
     * @name : checkChnlInfo
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst, mkt.mkt_conts_chnl_rel
     * @return : 
     * @description : 채널정보 확인
     */
    public int checkChnlInfo(MktCampaignStatusCheckReqDto parma);
    
    /**
     * @programId : 
     * @name : checkExeInfoItemId
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst, mkt.mkt_exe_info_item
     * @return : 
     * @description : 실행정보 아이템 확인
     */
    public int checkExeInfoItemId(MktCampaignStatusCheckReqDto parma);
    
    /**
     * @programId : 
     * @name : checkCamTypeCd
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_cam_mst
     * @return : 
     * @description : 캠페인 유형 확인
     */
    public String checkCamTypeCd(MktCampaignStatusCheckReqDto parma);
    
    /**
     * @programId : 
     * @name : chnlTypeCheck
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.MKT_CONTS_CHNL_REL
     * @return : 
     * @description : 채널 유형 확인
     */
    public List<MktCampaignScheduleCheckResDto> chnlTypeCheck(MktCampaignScheduleCheckReqDto parma);
    
    /**
     * @programId : 
     * @name : chnlTimeValidCheck
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.MKT_CONTS_CHNL_REL, mkt.MKT_CHNL 
     * @return : 
     * @description : 채널 기간 확인
     */
    public int chnlTimeValidCheck(MktCampaignScheduleCheckReqDto parma);
    
    /**
     * @programId : 
     * @name : checkCamTgtDtl
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_dtl 
     * @return : 
     * @description : 캠페인 대상자 확인
     */
    public int checkCamTgtDtl(MktCampaignStatusCheckReqDto parma);
    
    /**
     * @programId : 
     * @name : checkElecAprov
     * @date : 2015. 10. 29.
     * @author : dg.ryu
     * @table : mkt.mkt_elec_aprv 
     * @return : 
     * @description : 결제 상태 확인
     */
    public String checkElecAprov(MktCampaignStatusCheckReqDto parma);
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : selectCampaignTargetTotalCount
     * @date : 2015. 11. 16.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had
     * @return : 
     * @description : 대상자 헤더 대상 전체 건수
     */
    public MktCampaignTargetTotalCountResDto selectCampaignTargetTotalCount(MktCampaignTargetReqDto mctr);
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : selectCampaignTarget
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had
     * @return : 
     * @description : 대상자 헤더
     */
    public MktCampaignTargetResDto selectCampaignTarget(MktCampaignTargetReqDto mctr);
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : selectCampaignTargetList
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had
     * @return : 
     * @description : 대상자 헤더 목록
     */
    public List<MktCampaignTargetListResDto> selectCampaignTargetList(MktCampaignTargetReqDto mctr);
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : selectCampaignTargetList2
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had
     * @return : 
     * @description : 대상자 헤더 목록
     */
    public List<MktCampaignTargetListResDto> selectCampaignTargetList2(MktCampaignTargetReqDto mctr);

    /**
     * @programId : Mkt_MNG_P06
     * @name : selectCampaignTargetDtlList
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_dtl
     * @return : 
     * @description : 대상자 상세 목록
     */
    public List<MktCampaignTargetDtlReqDto> selectCampaignTargetDtlList(MktCampaignTargetDtlReqDto mctdr);

    /**
     * @programId : Mkt_MNG_P06
     * @name : selectCampaignTargetDtlList2
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_dtl
     * @return : 
     * @description : 대상자 상세 목록
     */
    public List<MktCampaignTargetDtlListResDto> selectCampaignTargetDtlList2(MktCampaignTargetDtlReqDto mctdr);
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : reSetCampaignTargetControlGroup
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_dtl
     * @return : 
     * @description : 캠페인 대상자 상세 제어그룹 설정
     */
    public List<MktCampaignTargetReqDto> reSetCampaignTargetControlGroup(MktCampaignTargetReqDto mctr);
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : setCampaignTargetControlGroup
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_dtl
     * @return : 
     * @description : 캠페인 대상자 상세 제어그룹 설정
     */
    public List<MktCampaignTargetReqDto> setCampaignTargetControlGroup(MktCampaignTargetReqDto mctr);
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : setCampaignTargetControlGroupCount
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had
     * @return : 
     * @description : 캠페인 대상자 헤더 제어그룹 Count
     */
    public List<MktCampaignTargetReqDto> setCampaignTargetControlGroupCount(MktCampaignTargetReqDto mctr);
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : deleteCampaignTarget
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had, mkt.mkt_tgt_dtl 
     * @return : 
     * @description : 캠페인대상 삭제
     */
    public void deleteCampaignTarget(MktCampaignTargetReqDto mctr);

    /**
     * @programId : Mkt_MNG_P06
     * @name : deleteCampaignTargetByCampaignId
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had, mkt.mkt_tgt_dtl 
     * @return : 
     * @description : 캠페인대상 삭제 By CampaignId
     */
    public void deleteCampaignTargetByCampaignId(MktCampaignTargetReqDto mctr);

    /**
     * @programId : Mkt_MNG_P06
     * @name : deleteCampaignTargetDtl
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_dtl
     * @return : 
     * @description : 캠페인대상 상세 삭제
     */
    public void deleteCampaignTargetDtl(MktCampaignTargetDtlReqDto mctdr);
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : setCampaignTargetOneCaseRemoveCount
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had
     * @return : 
     * @description : 캠페인 대상자 헤더 건삭제 count
     */
    public void setCampaignTargetOneCaseRemoveCount(MktCampaignTargetDtlReqDto mctdr);
    
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : deleteCancelCampaignTargetDtl
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_dtl
     * @return : 
     * @description : 대상자 상세 건삭제 취소
     */
    public void deleteCancelCampaignTargetDtl(MktCampaignTargetDtlReqDto mctdr);
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : deleteCampaignTargetDtlByTargetHeaderId
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_dtl
     * @return : 
     * @description : 캠페인대상 상세 삭제 By TargetHeaderId
     */
    public void deleteCampaignTargetDtlByTargetHeaderId(MktCampaignTargetDtlReqDto mctdr);
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : deleteCampaignTargetFileUploadByTargetHeaderId
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_upload_tgt_had
     * @return : 
     * @description : 캠페인대상 업로드 삭제 By TargetHeaderId
     */
    public void deleteCampaignTargetFileUploadByTargetHeaderId(MktCampaignTargetDtlReqDto mctdr);

    /**
     * @programId : Mkt_MNG_P06
     * @name : deleteCampaignTargetDtlByCampaignId
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_dtl
     * @return : 
     * @description : 캠페인대상 상세 삭제 By CampaignId
     */
    public void deleteCampaignTargetDtlByCampaignId(MktCampaignTargetDtlReqDto mctdr);
    
    /**
     * @programId : Mkt_MNG_P06
     * @name : setControlGroup
     * @date : 2015. 11. 30.
     * @author : dg.ryu
     * @table : mkt.mkt_tgt_had, mkt.mkt_tgt_dtl
     * @return : 
     * @description : 캠페인대상 제어그룹 설정
     */
    public void setControlGroup(MktCampaignTargetReqDto mctr);  

    /**
     * @programId : Mkt_MNG_P08
     * @name : selectExecutionInfo
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info
     * @return : 
     * @description : 실행정보
     */
    public MktCampaignExecutionInfoResDto selectExecutionInfo(MktCampaignExecutionInfoReqDto mceir);

    public MktCampaignExecutionInfoResDto selectExecutionInfoById(MktCampaignExecutionInfoReqDto mceir);

    /**
     * 마지막 실행 일정 조회
     * 
     * @programId : 
     * @name : selectCampaignLastExeDate
     * @date : 2017. 12. 15.
     * @author : jh.kim
     * @table : 
     * @return : MktCampaignExecutionInfoItemListResDto
     * @description : 
     */
    public String selectCampaignLastExeDate(MktCampaignExecutionInfoReqDto mceir);
    
    /**
     * @programId : Mkt_MNG_P08
     * @name : insertExecutionInfo
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info
     * @return : 
     * @description : 실행정보 등록
     */
    public void insertExecutionInfo(MktCampaignExecutionInfoReqDto mceir);

    /**
     * @programId : Mkt_MNG_P08
     * @name : updateExecutionInfo
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info
     * @return : 
     * @description : 실행정보 수정
     */
    public void updateExecutionInfo(MktCampaignExecutionInfoReqDto mceir);

    /**
     * @programId : Mkt_MNG_P08
     * @name : deleteExecutionInfo
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info
     * @return : 
     * @description : 실행정보 삭제
     */
    public void deleteExecutionInfo(MktCampaignExecutionInfoReqDto mceir);
    
    /**
     * @programId : Mkt_MNG_P08
     * @name : deleteExecutionInfoItemByExeInfoId
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info
     * @return : 
     * @description : 실행정보 아이템 삭제
     */
    public void deleteExecutionInfoItemByExeInfoId(MktCampaignExecutionInfoItemReqDto param);

    /**
     * @programId : Mkt_MNG_P08
     * @name : deleteExecutionInfoByCampaignId
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info
     * @return : 
     * @description : 실행정보 삭제 By CampaignId
     */
    public void deleteExecutionInfoByCampaignId(MktCampaignExecutionInfoReqDto mceir);

    /**
     * @programId : Mkt_MNG_P08
     * @name : selectExecutionInfoItemList
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info_item
     * @return : 
     * @description : 실행정보 아이템 목록
     */
    public List<MktCampaignExecutionInfoItemListResDto> selectExecutionInfoItemList(MktCampaignExecutionInfoItemGridReqDto mceiir);
    
    /**
     * @programId : Mkt_MNG_P08
     * @name : selectExecutionInfoItemList2
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info_item
     * @return : 
     * @description : 실행정보 아이템 목록
     */
    public List<MktCampaignExecutionInfoItemListResDto> selectExecutionInfoItemList2(MktCampaignExecutionInfoItemReqDto mceiir);

    /**
     * @programId : Mkt_MNG_P08
     * @name : insertExecutionInfoItem
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info_item
     * @return : 
     * @description : 실행정보 아이템 등록
     */
    public void insertExecutionInfoItem(MktCampaignExecutionInfoItemReqDto mceiir);

    /**
     * @programId : Mkt_MNG_P08
     * @name : updateExecutionInfoItem
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info_item
     * @return : 
     * @description : 실행정보 아이템 수정
     */
    public void updateExecutionInfoItem(MktCampaignExecutionInfoItemReqDto mceiir);
    
    /**
     * @programId : Mkt_MNG_P08
     * @name : deleteExecutionInfoItem
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info_item
     * @return : 
     * @description : 실행정보 아이템 삭제
     */
    public void deleteExecutionInfoItem(MktCampaignExecutionInfoItemReqDto mceiir);

    /**
     * @programId : Mkt_MNG_P08
     * @name : deleteExecutionInfoItemByCampaignId
     * @date : 2015. 11. 2.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info_item
     * @return : 
     * @description : 실행정보 아이템 삭제By campaignId
     */
    public void deleteExecutionInfoItemByCampaignId(MktCampaignExecutionInfoItemReqDto mceiir);

    /**
     * @programId : Mkt_MNG_P08
     * @name : deleteTargetDtlExecutionInfoItemRel
     * @date : 2015. 11. 26.
     * @author : dg.ryu
     * @table : mkt.mkt_exe_info_item
     * @return : 
     * @description : 실행정보 아이템과 대상자 상세 관계 초기화 - 실행정보 아이템 상태가 발송완료(D)가 아닌것
     */
    public void deleteTargetDtlExecutionInfoItemRel(MktCampaignExecutionInfoReqDto mceir);

    /**
     * @programId : Mkt_MNG_P05
     * @name : selectCampaignContentsChnnelRel
     * @date : 2015. 11. 27.
     * @author : "dg.ryu"
     * @table : mkt.mkt_conts_chnl_rel
     * @return : 
     * @description : 캠페인 콘텐츠 채널 관계
     */
    public MktCampaignContentsChnnelRelResDto selectCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr);

    /**
     * @programId : Mkt_MNG_P05
     * @name : insertCampaignContentsChnnelRel
     * @date : 2015. 11. 27.
     * @author : "dg.ryu"
     * @table : mkt.mkt_conts_chnl_rel
     * @return : 
     * @description : 캠페인 콘텐츠 채널 관계 등록
     */
    public void insertCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr);

    /**
     * @programId : Mkt_MNG_P05
     * @name : updateCampaignContentsChnnelRel
     * @date : 2015. 11. 27.
     * @author : "dg.ryu"
     * @table : mkt.mkt_conts_chnl_rel
     * @return : 
     * @description : 캠페인 콘텐츠 채널 관계 수정
     */
    public void updateCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr);
    
    /**
     * @programId : Mkt_MNG_P05
     * @name : updateCampaignContents
     * @date : 2015. 11. 27.
     * @author : "dg.ryu"
     * @table : mkt.mkt_conts_chnl_rel
     * @return : 
     * @description : 캠페인 콘텐츠 수정
     */
    public void updateCampaignContents(MktCampaignContentsChnnelRelReqDto mcccrr);

    /**
     * @programId : Mkt_MNG_P05
     * @name : deleteCampaignContentsChnnelRel
     * @date : 2015. 11. 27.
     * @author : "dg.ryu"
     * @table : mkt.mkt_conts_chnl_rel
     * @return : 
     * @description : 캠페인 콘텐츠 채널 관계 삭제
     */
    public void deleteCampaignContentsChnnelRel(MktCampaignContentsChnnelRelReqDto mcccrr);
    
    /**
     * @programId : Mkt_MNG_P05
     * @name : deleteCampaignContents
     * @date : 2015. 11. 27.
     * @author : "dg.ryu"
     * @table : mkt.mkt_conts_mst
     * @return : 
     * @description : 캠페인 콘텐츠 채널 삭제
     */
    public void deleteCampaignContents(MktCampaignContentsChnnelRelReqDto mcccrr);

    /**
     * @programId : Mkt_MNG_P05
     * @name : deleteCampaignContentsChnnelRelByCampaignId
     * @date : 2015. 11. 27.
     * @author : "dg.ryu"
     * @table : mkt.mkt_conts_chnl_rel
     * @return : 
     * @description : 캠페인 콘텐츠 채널 관계 삭제 By Campaign ID
     */
    public void deleteCampaignContentsChnnelRelByCampaignId(MktCampaignContentsChnnelRelReqDto mcccrr);
    
    /**
     * @programId : 
     * @name : selectTempNodeList
     * @date : 2015. 11. 24.
     * @author : 안형욱
     * @table : mkt.mkt_wf_template_mst,com.wf_task_had,mkt.wf_task_node,com.wf_node_mst
     * @return : 
     * @description : 템플렛에 등록된 작업 노드 리스트 조회
     */
    public List<MktCampaignGetTempNodeListResDto> selectTempNodeList(MktCampaignGetTempNodeListReqDto dto);

     /**
      * @programId : 
      * @name : selectTemp
      * @date : 2015. 11. 24.
      * @author : 안형욱
      * @table : mkt.mkt_wf_template_mst
      * @return : 
      * @description : 등록된 템플릿 조회
      */
    public List<MktCampaignGetTempNodeListResDto> selectTemp(MktCampaignGetTempNodeListReqDto dto);

    /**
     * @programId : Mkt_MNG_P10
     * @name : selectCampaignApproval
     * @date : 2015. 12. 7.
     * @author : "dg.ryu"
     * @table : mkt.mkt_elec_aprv
     * @return : 
     * @description : 캠페인 전자결재
     */
    public MktCampaignApprovalResDto selectCampaignApproval(MktCampaignApprovalReqDto mcar);

    /**
     * @programId : Mkt_MNG_P02
     * @name : insertCampaignWorkflowTemplate
     * @date : 2016. 1. 5.
     * @author : "dg.ryu"
     * @table : mkt.mkt_wf_template_mst
     * @return : 
     * @description : 캠페인 워크플로우 템플릿 등록
     */
    public void insertCampaignWorkflowTemplate(MktCampaignWorkflowTemplateReqDto mcwtr);
    
    /**
     * @programId : Mkt_MNG_P02
     * @name : updateCampaignTemplateFlag
     * @date : 2016. 1. 5.
     * @author : "dg.ryu"
     * @table : mkt.mkt_cam_mst
     * @return : 
     * @description : 캠페인 템플릿 사용여부 수정
     */
    public void updateCampaignTemplateFlag(MktCampaignWorkflowTemplateReqDto mcwtr);

    /**
     * @programId : Mkt_MNG_P02
     * @name : updateCampaignWorkflowTemplate
     * @date : 2016. 1. 5.
     * @author : "dg.ryu"
     * @table : mkt.mkt_wf_template_mst
     * @return : 
     * @description : 캠페인 워크플로우 템플릿 수정
     */
    public void updateCampaignWorkflowTemplate(MktCampaignWorkflowTemplateReqDto mcwtr);
    
    /**
     * @programId : Mkt_MNG_P02
     * @name : deleteCampaignWorkflowTemplate
     * @date : 2016. 1. 5.
     * @author : "dg.ryu"
     * @table : mkt.mkt_wf_template_mst
     * @return : 
     * @description : 캠페인 워크플로우 템플릿 삭제
     */
    public void deleteCampaignWorkflowTemplate(MktCampaignWorkflowTemplateReqDto mcwtr);
    
    /**
     * @programId : Mkt_MNG_P02
     * @name : selectCampaignWorkflowTemplateCount
     * @date : 2016. 1. 5.
     * @author : "dg.ryu"
     * @table : mkt.mkt_wf_template_mst
     * @return : 
     * @description : 캠페인 워크플로우 템플릿 Count
     */
    public int selectCampaignWorkflowTemplateCount(MktCampaignWorkflowTemplateReqDto mcwtr);

    /**
     * @programId : 
     * @name : selectCampaignStatus
     * @date : 2016. 3. 18.
     * @author : "dg.ryu"
     * @table : mkt.mkt_cam_mst
     * @return : 
     * @description : 캠페인 상태 조회
     */
    public String selectCampaignStatus(MktCampaignReqDto mcr);

    /**
     * @programId : Mkt_MNG_001
     * @name : updateCampaignDefaultInfoDesc
     * @date : 2016. 4. 22.
     * @author : "dg.ryu"
     * @table : mkt.mkt_cam_mst
     * @return : 
     * @description : 캠페인 기본정보 비고 수정
     */
    public void updateCampaignDefaultInfoDesc(MktCampaignDefaultInfoReqDto mcdir);

    /**
     * @programId : Mkt_MNG_004
     * @name : selectCampaignStatusList
     * @date : 2016. 4. 8.
     * @author : 송원희
     * @table : 
     * @return : 
     * @description : 캠페인 현황 목록
     */
    public List<MktCampaignStatusReqDto> selectCampaignStatusList(MktCampaignStatusReqDto param);
    
    /**
     * @programId : Mkt_MNG_004
     * @name : getCampaignStatusDetailList
     * @date : 2016. 4. 8.
     * @author : 송원희
     * @table : 
     * @return : 
     * @description : 캠페인 현황 실행 목록
     */
    public List<MktCampaignStatusReqDto> selectCampaignStatusDetailList(MktCampaignStatusReqDto param);
    
	/**
     * @programId : 
     * @name : selectChnlChk
     * @date : 2016. 12. 06.
     * @author : 이원준
     * @table : mkt_cam_mst, mkt_conts_chnl_rel, mkt_exe_info, mkt_exe_info_item, mkt_tgt_dtl, mkt_conts_mst
     * @return : String
     * @description : 캠페인 기획완료 체크
     */
	public List<String> selectChnlChk(MktCampaignTgtChnlChkReqDto ccrsr);

	/**
     * @programId : 
     * @name : selectTgtChk
     * @date : 2016. 12. 06.
     * @author : 이원준
     * @table : mkt_cam_mst, mkt_conts_chnl_rel, mkt_exe_info, mkt_exe_info_item, mkt_tgt_dtl, mkt_conts_mst
     * @return : String
     * @description : 캠페인 기획완료 체크
     */
	public String selectTgtChk(MktCampaignTgtChnlChkReqDto ccrsr);

    /**
     * @programId : 
     * @name : updateStopSendingMessagesByCampaignId
     * @date : 2017. 6. 2.
     * @author : "dg.ryu"
     * @table : mkt.mkt_msg_send_log
     * @return : void
     * @description : 메세지 발송 중지
     */
	public void updateStopSendingMessagesByCampaignId(MktCampaignDefaultInfoReqDto mcdir);

    /**
     * @programId : 
     * @name : updateStopSendingEmailByCampaignId
     * @date : 2017. 6. 2.
     * @author : "dg.ryu"
     * @table : mkt.mkt_email_send_log
     * @return : void
     * @description : 이메일 발송 중지
     */
	public void updateStopSendingEmailByCampaignId(MktCampaignDefaultInfoReqDto mcdir);

    /**
     * @programId : 
     * @name : updateStopSendingPushByCampaignId
     * @date : 2017. 6. 2.
     * @author : "dg.ryu"
     * @table : mkt.mkt_push_send_log
     * @return : void
     * @description : PUSH 발송 중지
     */
	public void updateStopSendingPushByCampaignId(MktCampaignDefaultInfoReqDto mcdir);

    /**
     * 카카오 친구톡 발송중지
     * 
     * @programId : 
     * @name : updateStopSendingKakaoByCampaignId
     * @date : 2018. 1. 11.
     * @author : jh.kim
     * @table : 
     * @return : void
     * @description : 
     */
    public void updateStopSendingKakaoByCampaignId(MktCampaignDefaultInfoReqDto mcdir);
	
	/**
     * @programId : 
     * @name : setStopExeInfoItemByCampaignId
     * @date : 2017. 6. 5.
     * @author : "dg.ryu"
     * @table : mkt.mkt_exe_info_item
     * @return : void
     * @description : 실행정보 아이템 상태 변경 (취소)
     */
	public void setStopExeInfoItemByCampaignId(MktCampaignDefaultInfoReqDto mcdir);

	/**
	 * @name : selectConidByCamid
	 * @date : 2017. 6. 22.
	 * @author : jun.lee
	 * @return : MktGetConidByCamidResDto
	 * @description : camid로 conid 조회
	 */
	public List<MktCampaignGetConidByCamidResDto> selectConidByCamid(MktCampaignGetConidByCamidReqDto param);

	/**
	 * 캠페인 삭제
	 * 
	 * @programId : 
	 * @name : deleteCampaign
	 * @date : 2017. 11. 29.
	 * @author : jh.kim
	 * @table : 
	 * @return : void
	 * @description : 
	 */
	public void deleteCampaign(MktCampaignRemoveReqDto param);
	
	/**
	 * 실행 가능 사용자인가 ? 
	 * 
	 * @programId : 
	 * @name : isExecutableUser
	 * @date : 2018. 1. 22.
	 * @author : jh.kim
	 * @table : 
	 * @return : boolean
	 * @description : 
	 */
	public MktCampaignExecutableUserResDto isExecutableUser(MktCampaignExecutableUserReqDto param);

	/**
	 * @name : callProcCamCopy
	 * @date : 2018. 2. 24.
	 * @author : dg.ryu
	 * @return : void
	 * @description : 캠페인 복사 프로시저 호춢
	 */
    MktCampaignListResDto callProcCamCopy(MktCampaignReqDto param);
	
	/**
     * 캠페인 목록 조회 (내 캠페인 제외 조회)
     * 
	 * @programId : 
	 * @name : selectCampaignListExcludeMyCam
	 * @date : 2018. 2. 26.
	 * @author : jh.kim
	 * @table : 
	 * @param param
	 * @return
	 * @description : 
	 */
	public List<MktCampaignListResDto> selectCampaignListExcludeMyCam(MktCampaignReqDto param);

	/**
     * @programId : 
     * @name : removeCampaignTemplates
     * @date : 2018. 10. 02.
     * @author : dw.keum
     * @table : 
     * @return :
     * @description : 템플릿 삭제
     */
	public void deleteCampaignTemplates(MktCampaignRemoveReqDto param);
	
    /**
     * @programId :
     * @name : getTargetId
     * @date : 2018. 4. 24.
     * @author : jh.kim
     * @table :
     * @description : 캠페인ID로 타겟헤더ID조회
     */
    public String selectCampaignTargetHadId(String param);
    
    /**
     * @programId :
     * @name : getTargetId
     * @date : 2018. 4. 24.
     * @author : jh.kim
     * @table :
     * @description : 캠페인 타겟 헤더 등록
     */
    public void insertCampaignTargetHad(MktCampaignTgtHadReqDto param);
    
    /**
     * @programId :
     * @name : getTargetId
     * @date : 2018. 4. 24.
     * @author : jh.kim
     * @table :
     * @description : 캠페인 대상자 헤더 제거 컬럼 Count
     */
    public void updateCampaignTargetDelCount(MktCampaignTargetReqDto param);

	public MktETCampaignNodeResDto selectETCampaignNode(MktETCampaignNodeReqDto ecnr);

	public void updateETCampaignNode(MktETCampaignNodeReqDto ecnr);

	public void updateETCampaignCondVal(MktETCampaignCondValReqDto conVal);

	public void deleteETCampaignNode(MktETCampaignNodeReqDto ecnr);

	public void deleteETCampaignCondValByRidCamNode(MktETCampaignCondValReqDto eccvr);

	public MktETCampaignActValResDto selectETCampaignActVal(MktETCampaignActValReqDto ecavr);

	public void insertETCampaignNode(MktETCampaignNodeReqDto ecnr);

	public void insertETCampaignActVal(MktETCampaignActValReqDto ecnr);
	
	public void insertETCampaignActParam(MktETCampaignActParamReqDto param);

	public void updateETCampaignActVal(MktETCampaignActValReqDto ecnr);

	public void deleteETCampaignActValByRidCamNode(MktETCampaignActValReqDto ecavr);
	
	public void deleteETCampaignActParamByRidCamNode(MktETCampaignActParamReqDto param);

	public List<MktETIntactTypeListResDto> selectETIntactTypeList(MktETIntactTypeListReqDto eitlr);

	public List<MktETLogicalComponentListResDto> selectETLogicalComponentList(MktETLogicalComponentListReqDto elclr);

	public List<MktETLogicalComponentColumnListResDto> selectETLogicalComponentColumnList(
			MktETLogicalComponentColumnListReqDto elcclr);

	public List<MktETFunctionListResDto> selectETFunctionList(MktETFunctionListReqDto eflr);

	public List<MktETCampaignCondValListResDto> selectETCampaignCondValList(MktETCampaignCondValReqDto eccvr);
	
	public List<MktETCampaignActParamResDto> selectETCampaignActParamList(MktETCampaignActParamReqDto param);

	public void insertETCampaignCondVal(MktETCampaignCondValReqDto conVal);

	public MktCampaignPromotionDateResDto selectCampaignPromotionDate(MktCampaignPromotionDateReqDto param);

    /**
     * @programId :
     * @name : selectCamWait
     * @date : 2020. 5. 7.
     * @author : dg.ryu
     * @table :
     * @description : 캠페인 Wait 조회
     */
	public MktCampaignWaitResDto selectCampaignWait(MktCampaignWaitReqDto param);
	
    /**
     * @programId :
     * @name : insertCamWait
     * @date : 2020. 5. 7.
     * @author : dg.ryu
     * @table :
     * @description : 캠페인 Wait 등록
     */
	public void insertCampaignWait(MktCampaignWaitReqDto param);
	
    /**
     * @programId :
     * @name : updateCamWait
     * @date : 2020. 5. 7.
     * @author : dg.ryu
     * @table :
     * @description : 캠페인 Wait 수정
     */
	public void updateCampaignWait(MktCampaignWaitReqDto param);
	
    /**
     * @programId :
     * @name : deleteCamWait
     * @date : 2020. 5. 7.
     * @author : dg.ryu
     * @table :
     * @description : 캠페인 Wait 삭제
     */
	public void deleteCampaignWait(MktCampaignWaitReqDto param);
	
	 /**
	   * @programId :
	   * @name : getProdList
	   * @date : 2020. 7. 14.
	   * @author : yj.choi
	   * @table :
	   * @description : 반응상품 리스트
	   */
	public List<MktCampaignProdResDto> selectProdList(MktCampaignProdReqDto param);

	 /**
	   * @programId :
	   * @name : getProdTreeList
	   * @date : 2020. 7. 14.
	   * @author : yj.choi
	   * @table :
	   * @description : 반응상품 트리 
	   */
	public List<MktCampaignProdResDto> selectProdTreeList(MktCampaignProdReqDto param);

	 /**
	   * @programId :
	   * @name : saveCampaignProd
	   * @date : 2020. 7. 14.
	   * @author : yj.choi
	   * @table :
	   * @description : 반응상품 저장
	   */
	public void insertCampaignProd(MktCampaignProdReqDto param);

	  /**
	   * @programId :
	   * @name : getProdTreeSearchList
	   * @date : 2020. 7. 15.
	   * @author : yj.choi
	   * @table :
	   * @description : 반응상품 검색
	   */
	public List<MktCampaignProdResDto> selectProdTreeSearchList(MktCampaignProdReqDto param);

	  /**
	   * @programId :
	   * @name : removeProd
	   * @date : 2020. 7. 15.
	   * @author : yj.choi
	   * @table :
	   * @description : 반응상품 삭제
	   */
	public void deleteProd(MktCampaignProdReqDto param);

	   /**
	    * @programId :
	    * @name : removeAllProd
	    * @date : 2020. 7. 15.
	    * @author : yj.choi
	    * @table :
	    * @description : 반응상품 전체 삭제
	    */
	public void deleteAllProd(MktCampaignProdReqDto param);

    /**
     * 캠페인 오퍼수 조회
     * @param reqDto
     * @return
     */
    public Integer selectCampaignOfferCount(MktCampaignContentsChnnelRelReqDto reqDto);

    /**
     * @programId : Mkt_MNG_001
     * @name : selectCampaignApprList
     * @date : 2021. 01. 05.
     * @author : sj.jung
     * @description : 캠페인 결재 목록
     */
    public List<MktCampaignListResDto> selectCampaignApprList(MktCampaignReqDto param);

    /**
     * 캠페인 불러오기시 오퍼에 쿠폰이 있는지에 대한 여부 체크
     * @param request
     * @param response
     * @param param
     * @return
     */
    public Integer getCampaignLoadOfferCount(MktCampaignContentsChnnelRelReqDto reqDto);

    /**
     * 캠페인 불러오기시 오퍼에 쿠폰이 있는지에 대한 여부 체크
     * @param request
     * @param response
     * @param param
     * @return
     */
    public Integer getCampaignLoadOfferPopCount(MktCampaignContentsChnnelRelReqDto reqDto);

    /**
     * 캠페인 실행 가능 시간 조회
     * @param request
     * @param response
     * @param param
     * @return
     */
    public MktSchePermitResDto getSchedulingPermitTime(MktSchePermitReqDto reqDto);

    /**
     * @programId :
     * @name : camCpPoCheck
     * @date : 2022. 02. 23.
     * @author : gy.lee
     * @table : com.mkt_conts_mst
     * @return :
     * @description : 캠페인 쿠폰/포인트 여부
     */
    public String camCpPoCheck(MktCampaignStatusCheckReqDto param);

    String selectCamAprvCheck(MktCampaignReqDto param);

    MktCampaignOfferCallResDto selectCamOfferForReqData(MktCampaignReqDto param);

    MktCampaignOfferCallResDto selectCamOfferForEshopDbInfo(MktCampaignReqDto param);

    OfferResDto selectCamOfferDetail(OfferReqDto param);

    int selectTgtOfferCount(MktCampaignReqDto param);

    int updateOfferSendStatus(String param);

    int updateOfferWaitStatus(MktCampaignContentsChnnelRelReqDto param);

    int checkContentOffer(MktCampaignContentsChnnelRelReqDto mcccrr);

    int checkExecItem(MktCampaignStatusCheckReqDto parma);

    public void camTempPlanerUpdate(MktCampaignReqDto param);

    int checkTgtExecItem(MktCampaignStatusCheckReqDto parma);

    OfferResDto selectCamOfferCheck(OfferReqDto param);

    String selectTargetCntByCamId(String camId);
}