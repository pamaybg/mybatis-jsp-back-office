package com.icignal.kepler.targetGroup.targetGroup.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.request.GridPagingReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.helper.IFVMErrorHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.DB_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.external.aws.SecretsManager;
import com.icignal.kepler.segment.dto.request.KprCopySegmentReqDto;
import com.icignal.kepler.segment.dto.request.KprSetSegmentReqDto;
import com.icignal.kepler.segment.service.KprSegmentService;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprSetTargetGroupColumnReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprSetTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupColumnListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupDBInfoReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupTargetListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupColumnListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupDBInfoResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupResDto;
import com.icignal.kepler.targetGroup.targetGroup.mapper.KprTargetGroupMapper;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.service.SystemCommCodeService;




/**
 * @name : infavor.kepler.targetGroup.dao.impl
 * @date : 2016. 7. 21.
 * @author : 류동균
 * @description : 타겟그룹 Service
 */
@Service
public class KprTargetGroupService {

    @Autowired
    private KprTargetGroupMapper kprTargetGroupMapper;

    @Autowired
    private KprSegmentService iKPRSegmentService;
   
    @Autowired
    private StandardPBEStringEncryptor encrypor;
    
	@Autowired
	private MKTCallQueryDao mktCallQueryDao;
	
	@Autowired
	private SystemCommCodeService systemCommcodeService;

	/**
	 * @programId : ANL_TGT_001
	 * @name : getTargetGroupList
	 * @date : 2016. 7. 21.
	 * @author : 류동균
	 * @table : anl.anl_tgt_group, com.employee
	 * @return :
	 * @description : 타겟그룹 목록 조회
	 */
    public GridPagingResDto<KprTargetGroupListResDto> getTargetGroupList(KprTargetGroupListReqDto tglr) {
        LogUtil.param(this.getClass(), tglr);
        tglr.setSVCAlias("tg");
         
        return new GridPagingResHelper<KprTargetGroupListResDto>().newGridPagingResDto(
        				 tglr.init(CommonUtil.getInstance().getDBType()),
        	    		 kprTargetGroupMapper.selectTargetGroupList(tglr));
    }

    /**
     * 타겟그룹 & Import 목록 조회
     *
     * @programId :
     * @name : getTargetGroupImportList
     * @date : 2018. 3. 5.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public GridPagingResDto<KprTargetGroupListResDto> getTargetGroupImportList(KprTargetGroupListReqDto tglr) {
        LogUtil.param(this.getClass(), tglr);
        tglr.setSVCAlias("t");

        return new GridPagingResHelper<KprTargetGroupListResDto>().newGridPagingResDto(
				 tglr.init(CommonUtil.getInstance().getDBType()),
				 kprTargetGroupMapper.selectTargetGroupImportList(tglr));
    }

    /**
     * @name : getMktTgtHadFileUploadList
     * @date : 2018. 4. 26.
     * @author : jun.lee
     * @return : GridPagingResDto<>
     * @description : 타겟그룹 대조군 파일업로드 유형 목록 조회
    **/
	/*쿼리없음
	 * public GridPagingResDto<>
	 * getMktTgtHadFileUploadList(KPRTargetGroupListRequestDTO tglr) {
	 * LogUtil.param(KPRTargetGroupService.class, tglr); tglr.setSVCAlias("t1");
	 * return new
	 * GridPagingresHelper<>().newGridPagingResDto(tglr.init(Common.getInstance().
	 * getDBType(),) kprTragetGroupMapper.selectMktTgtHadFileUploadList(tglr)); }
	 */

    /**
     * @programId : ANL_TGT_002
     * @name : selectTargetGroup
     * @date : 2016. 7. 21.
     * @author : 류동균
     * @table : anl.anl_tgt_group, com.comm_code, com.employee
     * @return :
     * @description : 타겟그룹 상세 조회
     */
    public KprTargetGroupResDto getTargetGroup(KprTargetGroupReqDto tgr) {
        LogUtil.param(this.getClass(), tgr);

        KprTargetGroupResDto rtnValue = new KprTargetGroupResDto();
       // rtnValue = kprTragetGroupMapper.getTargetGroup(tgr);

        // 타겟그룹 상세 조회
        rtnValue =kprTargetGroupMapper.selectTargetGroup(tgr);

        // 대상수
        /*
        if (ObjectUtil.isNotEmpty(rtnValue.getFilterSqlCount())) {
            String selectContent = rtnValue.getFilterSqlCount();

            KprTargetGroupDBInfoReqDto tgsfdr = new KprTargetGroupDBInfoReqDto();
            tgsfdr.setTargetGroupId(tgr.getTargetGroupId());
            tgsfdr.setLang(tgr.getLang());

            try {
                // 로지컬 컴포넌트 db 정보 조회
                MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
                dbInfo = getTargetGroupDBInfo(tgsfdr);

                if (ObjectUtil.isNotEmpty(dbInfo)) {
                    String rtnQuery = "";
                    // 쿼리 실행
                    rtnQuery = (String) mktCallQueryDao.callSelectObject("getSegmentAllCount", selectContent, new ArrayList<String>(), dbInfo, java.lang.String.class);
                    rtnValue.setTargetCount(rtnQuery);
                    
                    //건수 저장
                    tgr.setCnt(Integer.parseInt(rtnQuery));
                    kprTargetGroupMapper.updateTagetGroupCount(tgr);
                }
            }
            catch (IllegalArgumentException e) {
                LogUtil.error(e);
                rtnValue.setTargetCount(IFVMErrorHelper.MSG_T0001);
            }
        }
        */
        return rtnValue;
    }
    
    /**
     * @programId : ANL_TGT_002
     * @name : getTargetCount
     * @date : 2016. 7. 21.
     * @author : 류동균
     * @table : anl.anl_tgt_group, com.comm_code, com.employee
     * @return :
     * @description : 타겟그룹 대상자수 조회
     */
    public KprTargetGroupResDto getTargetCount(KprTargetGroupReqDto tgr) {
        LogUtil.param(this.getClass(), tgr);

        KprTargetGroupResDto rtnValue = new KprTargetGroupResDto();
       // rtnValue = kprTragetGroupMapper.getTargetGroup(tgr);

        // 타겟그룹 상세 조회
        rtnValue =kprTargetGroupMapper.selectTargetGroup(tgr);

        // 대상수
        if (ObjectUtil.isNotEmpty(rtnValue.getFilterSqlCount())) {
            String selectContent = rtnValue.getFilterSqlCount();

            KprTargetGroupDBInfoReqDto tgsfdr = new KprTargetGroupDBInfoReqDto();
            tgsfdr.setTargetGroupId(tgr.getTargetGroupId());
            tgsfdr.setLang(tgr.getLang());

            try {
                // 로지컬 컴포넌트 db 정보 조회
                MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
                dbInfo = getTargetGroupDBInfo(tgsfdr);

                if (ObjectUtil.isNotEmpty(dbInfo)) {
                    String rtnQuery = "";
                    // 쿼리 실행
                    rtnQuery = (String) mktCallQueryDao.callSelectObject("getSegmentAllCount", selectContent, new ArrayList<String>(), dbInfo, java.lang.String.class);
                    rtnValue.setTargetCount(rtnQuery);
                    
                    //건수 저장
                    tgr.setCnt(Integer.parseInt(rtnQuery));
                    kprTargetGroupMapper.updateTagetGroupCount(tgr);
                }
            }
            catch (IllegalArgumentException e) {
                LogUtil.error(e);
                rtnValue.setTargetCount(IFVMErrorHelper.MSG_T0001);
            }
        }
        
        return rtnValue;
    }

    /**
     * @programId : ANL_TGT_002
     * @name : getTargetGroupTargetList
     * @date : 2016. 7. 21.
     * @author : 류동균
     * @table :
     * @return :
     * @description : 대상 목록
     *
     * -----------------------------------------------------------------------------------------
     *  변 경 이 력
     * -----------------------------------------------------------------------------------------
     * 2018. 2. 26.    김재희.    공통으로 f_member 테이블에서 고객 정보를 조회하도록 수정
     *
     */
    
    @SuppressWarnings("unchecked")
	public GridPagingResDto getTargetGroupTargetList(KprTargetGroupTargetListReqDto tgtlr) {
        LogUtil.param(this.getClass(), tgtlr);

        ((GridPagingReqDto) tgtlr).init(CommonUtil.getInstance().getDBType());

        GridPagingResDto rtnValue = new GridPagingResDto<>();
        String lgcCompId = "";
        List<String> targetMemberList = selectTargetMemberNumListSql(tgtlr, "PAGE");

        if (ObjectUtil.isNotEmpty(targetMemberList) && targetMemberList.size() > 0) {

            // 공통코드 테이블에서 회원정보 공통LC RID 조회
            MKTCommonCodeRequestDTO commCodeReq = new MKTCommonCodeRequestDTO();
            commCodeReq.setGroupCode("TGT_MBR_BASIC_LC");
            GridPagingResDto commCodeGrid = systemCommcodeService.getCommCodeList(commCodeReq);
            if (ObjectUtil.isNotEmpty(commCodeGrid.getRows())) {
                List<Object> mccr = commCodeGrid.getRows();

                for (Object obj : mccr) {
                    MKTCommonCodeResponseDTO mccgrd = (MKTCommonCodeResponseDTO) obj;
                    lgcCompId = mccgrd.getAttrib02();
                }
            }

            KprTargetGroupDBInfoReqDto tgdir = new KprTargetGroupDBInfoReqDto();
            tgdir.setSystemColumn(tgtlr.getSystemColumn());
            tgdir.setLgcCompId(lgcCompId);
            
            //LC DB 정보 조회
            KprTargetGroupDBInfoResDto lcDBInfo = getTargetGroupLcDBInfo(tgdir);
            
            //db 정보 Setting
            MKTDBInfoDTO reqDbInfoDto = new MKTDBInfoDTO();
            reqDbInfoDto.setDriverClassName(lcDBInfo.getConDbClass());
            reqDbInfoDto.setConIp(lcDBInfo.getConIp());
            reqDbInfoDto.setConPort(lcDBInfo.getConPort());
            reqDbInfoDto.setUserName(lcDBInfo.getConId());
            reqDbInfoDto.setPassword(lcDBInfo.getConPassword());
            reqDbInfoDto.setUrl(lcDBInfo.getConUrl());
            reqDbInfoDto.setConDbType(lcDBInfo.getConDbType());

            // 회원정보 조회하여 대상자 수 조회
            KprTargetGroupReqDto tgrReq = new KprTargetGroupReqDto();
            tgrReq.setSystemColumn(tgtlr.getSystemColumn());
            tgrReq.setTargetGroupId(tgtlr.getTargetGroupId());

            KprTargetGroupResDto targetGroupInfo = getTargetGroup(tgrReq);
            rtnValue.setRecords(Integer.parseInt(targetGroupInfo.getTargetCount()));

            //기본 쿼리 생성
            StringBuilder query = new StringBuilder();
            
            query.append(lcDBInfo.getLgcSql());
            
           // int qrIdx = query.toString().indexOf("SELECT");
            
            query.insert(6, "  DISTINCT  ");
            
            query.append(" where " + lcDBInfo.getSegKeyCol() + " in (");

            for (int idx = 0; idx < targetMemberList.size(); idx++) {
                String targetMember = targetMemberList.get(idx);
                if (idx != 0) query.append(",");
                query.append("'").append(targetMember).append("'");
            }
            query.append(")");

            String queryStr = query.toString();

            //타겟그룹 LC 데이터 조회
            List<LinkedHashMap<String, String>> list = mktCallQueryDao.callSelectForListMap("getTargetGroupTargetList", queryStr, new ArrayList<>(), reqDbInfoDto);
            
            //결과 list
       //     List<LinkedHashMap<String, String>> rsTable = new ArrayList<>();
            
            rtnValue = ObjectUtil.ConvertListToGrid(tgtlr, list, rtnValue.getRecords(), targetGroupInfo.getConDbType());
        }
        
        return rtnValue;
    }

    /**
     * 대상자그룹 목록 전체 조회
     *
     * @programId :
     * @name : getAllTargetGroupTargetList
     * @date : 2018. 2. 26.
     * @author : jh.kim
     * @table :
     * @param tgtlr
     * @return
     * @description :
     */
    @SuppressWarnings("unchecked")
	public GridPagingResDto getAllTargetGroupTargetList(KprTargetGroupTargetListReqDto tgtlr) {
        LogUtil.param(this.getClass(), tgtlr);

        GridPagingResDto rtnList = new GridPagingResDto();
        List<LinkedHashMap<String, String>> list = new ArrayList<LinkedHashMap<String, String>>();
        
        String lgcCompId = "";

        List<String> targetMemberList =selectTargetMemberNumListSql(tgtlr, "ALL");

        if (ObjectUtil.isNotEmpty(targetMemberList) && targetMemberList.size() > 0) {

            // 공통코드 테이블에서 회원정보 공통LC RID 조회
            MKTCommonCodeRequestDTO commCodeReq = new MKTCommonCodeRequestDTO();
            commCodeReq.setGroupCode("TGT_MBR_BASIC_LC");
            GridPagingResDto commCodeGrid = systemCommcodeService.getCommCodeList(commCodeReq);

            if (ObjectUtil.isNotEmpty(commCodeGrid.getRows())) {
                List<Object> mccr = commCodeGrid.getRows();

                for (Object obj : mccr) {
                    MKTCommonCodeResponseDTO mccgrd = (MKTCommonCodeResponseDTO) obj;
                    lgcCompId = mccgrd.getAttrib02();
                }
            }
            
            KprTargetGroupDBInfoReqDto tgdir = new KprTargetGroupDBInfoReqDto();
            tgdir.setSystemColumn(tgtlr.getSystemColumn());
            tgdir.setLgcCompId(lgcCompId);
            
            //LC DB 정보 조회
            KprTargetGroupDBInfoResDto lcDBInfo = getTargetGroupLcDBInfo(tgdir);
            
            //db 정보 Setting
            MKTDBInfoDTO reqDbInfoDto = new MKTDBInfoDTO();
            reqDbInfoDto.setDriverClassName(lcDBInfo.getConDbClass());
            reqDbInfoDto.setConIp(lcDBInfo.getConIp());
            reqDbInfoDto.setConPort(lcDBInfo.getConPort());
            reqDbInfoDto.setUserName(lcDBInfo.getConId());
            reqDbInfoDto.setPassword(lcDBInfo.getConPassword());
            reqDbInfoDto.setUrl(lcDBInfo.getConUrl());
            reqDbInfoDto.setConDbType(lcDBInfo.getConDbType());
            
            //기본 쿼리 생성
            StringBuilder query = new StringBuilder();
            query.append(lcDBInfo.getLgcSql());
            
            query.insert(6, "  DISTINCT  ");
            
            query.append(" where " + lcDBInfo.getSegKeyCol());
            
       
            int idx = 1;
            int size = targetMemberList.size();
            String inStr = "";
            
            //대상자 목록
            for (String memId : targetMemberList) {
            	
				//in 절 값 생성
				if (idx % 900 == 0 || idx == size) {
					inStr += "'" + memId + "'";
				} else {
					inStr += "'" + memId + "',";
				}
            	
            	//900단위로 나누어 실행 또는 마지막
				if (idx % 900 == 0 || idx == size) {
					//sql 생성
					String sql = query.toString() + " in (" + inStr + ")";
					
					//타겟그룹 대상자 목록 조회
					list.addAll(mktCallQueryDao.callSelectForListMap("getAllTargetGroupTargetList", sql, new ArrayList<String>(), reqDbInfoDto));
	                
	                //초기화
	                inStr = "";
				}
				
				idx++;
            }
            
            rtnList = ObjectUtil.ConvertListToGrid(tgtlr, list, list.size(), "");
        }
        
        return rtnList;
    }

	/**
	 * @programId : ANL_SEG_P05
	 * @name : addTargetGroup
	 * @date : 2016. 7. 21.
	 * @author : 류동균
	 * @table : anl.anl_tgt_group
	 * @return :
	 * @description : 타겟그룹 등록
	 */
	
	public StatusResDto addTargetGroup(KprSetTargetGroupReqDto stgr) {
		LogUtil.param( this.getClass() , stgr );

		StatusResDto rtnValue = new StatusResDto();

		//세그먼트 복제
		KprCopySegmentReqDto csr = new KprCopySegmentReqDto();
        csr.setCreateBy(stgr.getCreateBy());
        csr.setModifyBy(stgr.getModifyBy());
        csr.setSegFilterId(stgr.getSegFilterId());
        csr.setSegmentType(stgr.getSegmentType());
        rtnValue = iKPRSegmentService.copySegmentBySegmentFilterId(csr);

		if (rtnValue.getSuccess()) {
		    //세그먼트 필터 아이디 설정
		    stgr.setSegFilterId(rtnValue.getMessage());

		    //타겟그룹 등록
		    //rtnValue = kprTragetGroupMapper.addTargetGroup(stgr);
		    String id = CommonUtil.newRid();
			stgr.setTargetGroupId(id);
//	        String id = (String) /this.insert("KPRTargetGroup.insertTargetGroup", stgr, true);
			
	        if(kprTargetGroupMapper.insertTargetGroup(stgr)>0){
	            rtnValue.setSuccess(true);
	            rtnValue.setMessage(id);
	        }

			return rtnValue;
		    
		    
		}

		return rtnValue;
	}

	/**
	 * @programId : ANL_TGT_002
	 * @name : editTargetGroup
	 * @date : 2016. 7. 21.
	 * @author : 류동균
	 * @table : anl.anl_tgt_group
	 * @return :
	 * @description : 타겟그룹 수정
	 */
	
	public StatusResDto editTargetGroup(KprSetTargetGroupReqDto stgr) {
		LogUtil.param( this.getClass() , stgr );

		StatusResDto rtnValue = new StatusResDto();
		//rtnValue = kprTragetGroupMapper.editTargetGroup(stgr);
		kprTargetGroupMapper.updateTargetGroup(stgr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

    /**
     * @programId : ANL_TGT_002, ANL_TGT_P01
     * @name : getTargetGroupColumnList
     * @date : 2016. 7. 25.
     * @author : 류동균
     * @table : anl.anl_tgt_group, anl.anl_tgt_group_column
     * @return :
     * @description : 타겟그룹 컬럼 목록 조회
     */
    
    public List<KprTargetGroupColumnListResDto> getTargetGroupColumnList(KprTargetGroupColumnListReqDto tgclr) {
        LogUtil.param(this.getClass(), tgclr);

        return kprTargetGroupMapper.selectTargetGroupColumnList(tgclr);
    }

    /**
     * @programId : ANL_TGT_P01
     * @name : getTargetGroupColumnAllList
     * @date : 2016. 7. 25.
     * @author : 류동균
     * @table : anl.anl_tgt_group, anl.anl_tgt_group_column
     * @return :
     * @description : 타겟그룹 컬럼 목록 모두 조회
     */
    
    public List<KprTargetGroupColumnListResDto> getTargetGroupColumnAllList(KprTargetGroupColumnListReqDto tgclr) {
        LogUtil.param(this.getClass(), tgclr);

        return kprTargetGroupMapper.selectTargetGroupColumnAllList(tgclr);
    }

    /**
     * @programId : ANL_TGT_P01
     * @name : saveTargetGroupColumn
     * @date : 2016. 7. 25.
     * @author : 류동균
     * @table : anl.anl_tgt_group_column
     * @return :
     * @description : 타겟그룹 컬럼 저장
     */
    
    public StatusResDto saveTargetGroupColumn(KprSetTargetGroupColumnReqDto stgcr) {
        LogUtil.param( this.getClass() , stgcr );

        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(true);

        for (KprSetTargetGroupColumnReqDto col : stgcr.getTargetGroupColList()) {
           // col.setAppServiceId(stgcr.getAppServiceId());
           // col.setCountry(stgcr.getCountry());
            col.setLang(stgcr.getLang());
           // col.setAccountId(stgcr.getAccountId());
            col.setCreateBy(stgcr.getCreateBy());
            col.setModifyBy(stgcr.getModifyBy());

            if (ObjectUtil.isNotEmpty(col.getTargetGroupColId()) && "0".equals(col.getTargetGroupColUseFlag())) {
                 kprTargetGroupMapper.deleteTargetGroupColumn(col);
                 rtnValue.setSuccess(true);
            }

            if (ObjectUtil.isEmpty(col.getTargetGroupColId()) && "1".equals(col.getTargetGroupColUseFlag())) {
              //  rtnValue = kprTragetGroupMapper.addTargetGroupColumn(col);
            	  String id =CommonUtil.newRid();
            	  col.setTargetGroupColId(id);
                  if(kprTargetGroupMapper.insertTargetGroupColumn(col) > 0){
                      rtnValue.setSuccess(true);
                      rtnValue.setMessage(id);
                  }
            }
        }

        return rtnValue;
    }

    /**
     * @programId :
     * @name : removeTargetGroup
     * @date : 2016. 9. 13.
     * @author : 류동균
     * @table : anl.anl_tgt_group, anl.anl_tgt_group_column, anl.anl_seg_mst, anl.anl_seg_filter, anl.anl_seg_filter_rel
     * @return :
     * @description : 타겟그룹 삭제
     */
    
    public StatusResDto removeTargetGroup(KprSetTargetGroupReqDto stgr) {
        LogUtil.param( this.getClass() , stgr );

        StatusResDto rtnValue = new StatusResDto();

        KprTargetGroupReqDto tgr = new KprTargetGroupReqDto();
        tgr.setTargetGroupId(stgr.getTargetGroupId());

        //캠페인 연결 확인 Count
        int flagCount = kprTargetGroupMapper.selectConnectCampaignCheckCount(tgr);

        //캠페인과 연결이 안되었을 경우만 삭제
        if (flagCount == 0) {
            //타겟그룹 삭제
            kprTargetGroupMapper.deleteTargetGroupByTargetGroupId(stgr);
            rtnValue.setSuccess(true);

            KprSetTargetGroupColumnReqDto stgrc = new KprSetTargetGroupColumnReqDto();
            stgrc.setModifyBy(stgr.getModifyBy());
            //stgrc.setAccountId(stgr.getAccountId());
            stgrc.setTargetGroupId(stgr.getTargetGroupId());

            //타겟그룹 컬럼 삭제
            kprTargetGroupMapper.deleteTargetGroupColumnByTargetGroupId(stgrc);
            rtnValue.setSuccess(true);
            if (rtnValue.getSuccess()) {
                KprSetSegmentReqDto ssr = new KprSetSegmentReqDto();
                ssr.setModifyBy(stgr.getModifyBy());
                //ssr.setAccountId(stgr.getAccountId());
                ssr.setSegmentId(stgr.getSegmentId());

                //타겟그룹 연결 세그먼트 삭제
                rtnValue = iKPRSegmentService.removeSegment(ssr);
            }
            
            //심플 타겟팅 삭제
            kprTargetGroupMapper.deleteSimpleTargeting(stgr);
            rtnValue.setSuccess(true);
        } else {
            rtnValue.setSuccess(false);
            rtnValue.setMessage(IFVMErrorHelper.MSG_T0001);
        }

        return rtnValue;
    }
    
    /**
     * @programId :
     * @name : getTargetGroupLcDBInfo
     * @date : 2016. 7. 25.
     * @author : 류동균
     * @table : anl.anl_db_inform
     * @return :
     * @description : 타겟그룹 LC DB 정보 조회
     */
    
    public KprTargetGroupDBInfoResDto getTargetGroupLcDBInfo(KprTargetGroupDBInfoReqDto tgdir) {
        LogUtil.param(this.getClass(), tgdir);
        
        KprTargetGroupDBInfoResDto dbInfo = kprTargetGroupMapper.selectTargetGroupLcDBInfo(tgdir);
        
        if(ObjectUtil.isNotEmpty(dbInfo.getSecretNm())) {
			try {
				Map<String, Object> dbInfoJSON =  new SecretsManager(BeansUtil.getAWSCredentials(), 
						 BeansUtil.getAwsRegion()
						 ).getSecretMap(dbInfo.getSecretNm());		
				
				dbInfo.setConUrl(dbInfoJSON.get("url").toString());
				dbInfo.setConId(dbInfoJSON.get("username").toString());
				dbInfo.setConPassword(dbInfoJSON.get("password").toString());
				dbInfo.setConIp(dbInfoJSON.get("ip").toString());
				dbInfo.setConPort(dbInfoJSON.get("port").toString());
				
			} catch(IllegalArgumentException e) {
				LogUtil.error(e.getMessage());
			}
		} else {
			dbInfo.setConPassword(encrypor.decrypt(dbInfo.getConPassword()));
		}
        
        return dbInfo;
    }
    /**
     * @programId :
     * @name : getTargetGroupDBInfo
     * @date : 2016. 7. 25.
     * @author : 류동균
     * @table : anl.anl_db_inform
     * @return :
     * @description : 타겟그룹 DB 정보 조회
     */
    public MKTDBInfoDTO getTargetGroupDBInfo(KprTargetGroupDBInfoReqDto tgdir) {
        LogUtil.param(this.getClass(), tgdir);
        KprTargetGroupDBInfoResDto tgDbInfo = new KprTargetGroupDBInfoResDto();

        //로지컬 컴포넌트 db 정보 조회
        tgDbInfo = kprTargetGroupMapper.selectTargetGroupDBInfo(tgdir);

        //접속 db 정보 설정
        MKTDBInfoDTO rtnValue = new MKTDBInfoDTO();
        rtnValue.setDriverClassName(tgDbInfo.getConDbClass());
        rtnValue.setConDbType(tgDbInfo.getConDbType());
        
        if(ObjectUtil.isNotEmpty(tgDbInfo.getSecretNm())) {
        	try {
				Map<String, Object> dbInfoJSON =  new SecretsManager(BeansUtil.getAWSCredentials(), 
						 BeansUtil.getAwsRegion()
						 ).getSecretMap(tgDbInfo.getSecretNm());		
        		
        		rtnValue.setUrl(dbInfoJSON.get("url").toString());
        		rtnValue.setUserName(dbInfoJSON.get("username").toString());
        		rtnValue.setPassword(dbInfoJSON.get("password").toString());
        		rtnValue.setConIp(dbInfoJSON.get("ip").toString());
        		rtnValue.setConPort(dbInfoJSON.get("port").toString());
				
        	}catch(IllegalArgumentException e){
        		LogUtil.error(e.getMessage());
        	}
        } else {
        	rtnValue.setConIp(tgDbInfo.getConIp());
        	rtnValue.setConPort(tgDbInfo.getConPort());
        	rtnValue.setUserName(tgDbInfo.getConId());
        	rtnValue.setPassword(encrypor.decrypt(tgDbInfo.getConPassword()));
        	rtnValue.setUrl(tgDbInfo.getConUrl());
        }

        return rtnValue;
    }
    /**
     * 타겟 대상자 MBR_NO 목록 조회
     *
     * @programId :
     * @name : selectTargetMemberNumListSql
     * @date : 2018. 2. 23.
     * @author : jh.kim
     * @table :
     * @param tgtlr
     * @return
     * @description :
     */
    @SuppressWarnings("unchecked")
	public List<String> selectTargetMemberNumListSql(KprTargetGroupTargetListReqDto tgtlr, String type) {
        LogUtil.param(this.getClass(), tgtlr);

        List<String> rtnValue = new ArrayList<>();
        StringBuilder sqlQuery = new StringBuilder();

        // 대상 목록 SQL 조회
        sqlQuery = new StringBuilder(kprTargetGroupMapper.selectTargetMemberNumListSql(tgtlr));

        tgtlr.setSVCAlias("");

        // 접속 db 정보 설정
        MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();

        //타겟쿼리 조회
        /*if ("SQL".equals(tgtlr.getType())) {
            KPRTargetSqlDBInfoRequestDTO req = new KPRTargetSqlDBInfoRequestDTO();
            req.setSystemColumn(tgtlr.getSystemColumn());
            req.setTargetGroupId(tgtlr.getTargetGroupId());

            KPRTargetSqlDBInfoResponseDTO tgDbInfo = ikprTargetSqlService.getTargetSqlDBInfo(req);

            // 접속 db 정보 설정
            dbInfo.setDriverClassName(tgDbInfo.getConDbClass());
            dbInfo.setConIp(tgDbInfo.getConIp());
            dbInfo.setConPort(tgDbInfo.getConPort());
            dbInfo.setUserName(tgDbInfo.getConId());
            dbInfo.setPassword(encrypor.decrypt(tgDbInfo.getConPassword()));
            dbInfo.setUrl(tgDbInfo.getConUrl());
            dbInfo.setConDbType(tgDbInfo.getConDbType());
        }
        else {*/
            //타겟그룹 조회
            KprTargetGroupDBInfoReqDto tgsfdr = new KprTargetGroupDBInfoReqDto();
            tgsfdr.setLang(tgtlr.getLang());
            tgsfdr.setTargetGroupId(tgtlr.getTargetGroupId());
            dbInfo = getTargetGroupDBInfo(tgsfdr);
        //}
        
        // 쿼리 실행
        if (ObjectUtil.isNotEmpty(dbInfo) && ObjectUtil.isNotEmpty(sqlQuery)) {
            //조회 유형이 전체가 아닐 경우만 페이징 조회
            if (!"ALL".equals(type)) {
    	        //페이징 설정
    			if (DB_TYPE.MYSQL.toString().equals(dbInfo.getConDbType())||DB_TYPE.MEMSQL.toString().equals(dbInfo.getConDbType())) {
    				sqlQuery.append(" limit " + tgtlr.getSkipCount() + ", " + tgtlr.getPageSize());
    			} 
    			else if (DB_TYPE.POSTGRESQL.toString().equals(dbInfo.getConDbType())) {
                    sqlQuery.append(" offset " + tgtlr.getSkipCount() + " limit " + tgtlr.getPageSize());
    			}
                else if (DB_TYPE.MSSQL.toString().equals(dbInfo.getConDbType())) {
                    StringBuilder rtnQuery = new StringBuilder();
//                    sqlQuery.insert(6," distinct ");

                    rtnQuery.append("select t.segkey from (\n" +
                            "select t.*\n" +
                            ", ROW_NUMBER() OVER (ORDER BY segkey DESC) as RowNumber\n" +
                            "from (" + sqlQuery
                            + ") t\n" +
                            ") t\n" +
                            "WHERE RowNumber > "+tgtlr.getSkipCount()+" and RowNumber <= "+tgtlr.getPageSize()*tgtlr.getPage());

                    sqlQuery = rtnQuery;
                }
    			else{
                    sqlQuery.append(" offset " + tgtlr.getSkipCount() + " rows fetch next " + tgtlr.getPageSize() + " rows only");
    			}
            }
        	
            rtnValue = mktCallQueryDao.callSelectForList("selexctTargetMemberNumListSql", sqlQuery.toString(), new ArrayList<>(), dbInfo, java.lang.String.class);
        }

        return rtnValue;
    }

    /**
     * @programId : ANL_TGT_002
     * @name : getMbrNoFromCust
     * @date : 2022. 1. 24.
     * @author : 정수지
     * @table :
     * @return :
     * @description : 멤버 rid 조회
     */
    public KprTargetGroupResDto getMbrNoFromCust(KprTargetGroupReqDto tgr) {
        LogUtil.param(this.getClass(), tgr);

        KprTargetGroupResDto rtnValue = new KprTargetGroupResDto();
        // rtnValue = kprTragetGroupMapper.getTargetGroup(tgr);

        // 타겟그룹 상세 조회
        rtnValue =kprTargetGroupMapper.getMbrNoFromCust(tgr);

        return rtnValue;
    }


}
