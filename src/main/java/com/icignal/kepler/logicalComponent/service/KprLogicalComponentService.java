package com.icignal.kepler.logicalComponent.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.component.Messages;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.core.exception.DataSQLException;
import com.icignal.external.aws.SecretsManager;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentAttributeGroupColumnReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentAttributeGroupLeftAccordionListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentAttributeGroupLeftAccordionTreeNodeListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentAttributeGroupReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentAttributeGroupTreeNodeListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentCheckAttributeCalFieldReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentDeleteIdListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentDetailReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentEngineDetailReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentGroupColumnReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentJoinAccordionListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentJoinAccordionTreeNodeListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentJoinColumnMasterListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentJoinColumnReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentJoinDbServiceComboListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentJoinTableRelReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentListReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentReqDto;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentSegRptUsedListReqDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentAttributeGroupColumnResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentAttributeGroupLeftAccordionListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentAttributeGroupLeftAccordionTreeNodeListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentAttributeGroupResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentAttributeGroupTreeNodeListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentDbServiceResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentDetailJoinColumnBaseResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentDetailJoinColumnResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentDetailJoinTableRelResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentDetailResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentGroupColumnResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentJoinAccordionListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentJoinAccordionTreeNodeListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentJoinColumnMasterListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentJoinColumnMasterPopupListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentJoinColumnResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentJoinDbServiceComboListResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentSegRptUsedResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentTableRelResDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentsResDto;
import com.icignal.kepler.logicalComponent.mapper.KprLogicalComponentMapper;

/*
 * 1. 클래스명	: KPRLogicalComponentService
 * 2. 파일명	: KPRLogicalComponentService.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.service
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		로지컬 컴포넌트 Service
 * </PRE>
 */ 
@Service("KprLogicalComponentService")
public class KprLogicalComponentService {

	@Autowired
	private KprLogicalComponentMapper kprLogicalComponentMapper;

	@Autowired
	private MKTCallQueryDao mktCallQueryDao;

	@Autowired
	private StandardPBEStringEncryptor encrypor;

//	@Autowired
//	private MKTBase iMKTBase;

	@Autowired
	private KprLogicalComponentEngineService kprLogicalComponentEngineService;

	 /*
	  * 1. 메소드명: getLogicalComponentList
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 6. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 목록 > 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst
	 *   @return GridPagingResDto
	 */
	public GridPagingResDto<KprLogicalComponentsResDto> getLogicalComponentList(KprLogicalComponentListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lgc");
		return new GridPagingResHelper<KprLogicalComponentsResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), kprLogicalComponentMapper.selectLogicalComponentList(reqDto));
	}

	 /*
	  * 1. 메소드명: getLogicalComponentDetail
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 7. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 상세조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column
	 *   @return KPRLogicalComponentDetailResponseDTO
	 */
	public KprLogicalComponentDetailResDto getLogicalComponentDetail(KprLogicalComponentDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		reqDto.setSVCAlias("alcm");
		KprLogicalComponentDetailResDto resDto = kprLogicalComponentMapper.selectLogicalComponentDetail(reqDto);

		// 분석 및 세그먼트 조회
		KprLogicalComponentReqDto chkReqDto = new KprLogicalComponentReqDto();
		chkReqDto.setLgcCompId(reqDto.getLgcCompId());
		/*
		 * kj.kang 수정을 위해 추석처리 int chkUsing =
		 * kprLogicalComponentMapper.selectCheckUsingOnSegmentAndReport(chkReqDto);
		 * 
		 * // 분석 및 세그먼트 사용여부 확인 if(chkUsing != 0){
		 * resDto.setAnalysisSegmentUsed(true); } else {
		 * resDto.setAnalysisSegmentUsed(false); }
		 */
		/******************************************
		 * kj.kang 추가 ***************************************************** 수정
		 * 사유 :: 2016.09.19 회의 결과, LC를 사용하고 있어도 일부 항목에 대한 제한을 풀기로 함 DESCRIPTION
		 * :: LC가 사용 중일 경우에도 어트리뷰트를 삭제할 수는 없어도 추가는 가능해야 한다함. 1. LC 수정에 한하여,
		 * 어트리뷰트 삭제 기능을 제공하지 않는다. 2. LC 수정 시, 어트리뷰트 추가는 가능하다. 3. LC 수정 시, 세그먼트에서
		 * 사용 중일 경우 - 세그먼트 키를 변경할 수 없다. 4. LC 수정 시, 분석에서 사용 중일 경우 - 데이트 키를 변경할 수
		 * 없다.
		 */
		reqDto.setSVCAlias("");
		// 1. 사용할 변수 :: analysisUsingCnt - 분석 사용 건 수, segmentUsingCnt - 세그먼트 사용
		// 건수, analysisUsed - 분석 사용 중 여부, segmentUsed - 세그먼트 사용 중 여부
		Integer analysisUsingCnt = kprLogicalComponentMapper.selectCheckUsingOnAnalysis(chkReqDto);
		Integer segmentUsingCnt = kprLogicalComponentMapper.selectCheckUsingOnSegment(chkReqDto);
		boolean analysisUsed;
		boolean segmentUsed;

		// 2. 조건에 따른 사용 중 여부 값 설정
		if (analysisUsingCnt != 0) {
			analysisUsed = true;
		} else {
			analysisUsed = false;
		}

		if (segmentUsingCnt != 0) {
			segmentUsed = true;
		} else {
			segmentUsed = false;
		}

		// 3. (2) 항목으로 도출된 값으로 화면에 해당 값 전달
		resDto.setAnalysisSegmentUsed(analysisUsed || segmentUsed);
		resDto.setAnalysisUsed(analysisUsed);
		resDto.setSegmentUsed(segmentUsed);
		/*********************************************************************************************************/
		reqDto.setSVCAlias("alctr");
		// 테이블 관계 노드 리스트 조회
		List<KprLogicalComponentDetailJoinTableRelResDto> tblRelNodeList = kprLogicalComponentMapper.selectLogicalComponentDetailJoinTableRelNodeList(reqDto);
		reqDto.setSVCAlias("aljc");
		// 조인 컬럼 기본 데이터 리스트 조회
		List<KprLogicalComponentDetailJoinColumnBaseResDto> joinColumnBase = kprLogicalComponentMapper.selectLogicalComponentDetailJoinColumnBaseInfo(reqDto);
		for (KprLogicalComponentDetailJoinColumnBaseResDto item : joinColumnBase) {

			// 조인 컬럼 기본 데이터별 조인 컬럼 리스트 조회를 위한 Request 설정
			reqDto.setLeftLgcCompTblRelId(item.getLeftLgcCompTblRelId());
			reqDto.setRightLgcCompTblRelId(item.getRightLgcCompTblRelId());
			reqDto.setSVCAlias("aljc");
			// 조인 컬럼 기본 데이터별 조인 컬럼 리스트 조회
			List<KprLogicalComponentDetailJoinColumnResDto> resJoinColList = kprLogicalComponentMapper.selectLogicalComponentDetailJoinColumn(reqDto);

			// 조인 컬럼 기본 데이터에 조인 컬럼 리스트 세팅
			item.setJoinColumnList(resJoinColList);
		}

		// 최종 Response DTO에 값 설정
		resDto.setJoinTableRelList(tblRelNodeList);
		resDto.setJoinColumnList(joinColumnBase);

		return resDto;
	}

	 /*
	  * 1. 메소드명: addLogicalComponent
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 6. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > (최초)저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column
	 *   @return StatusResDto
	 */
	public StatusResDto addLogicalComponent(KprLogicalComponentReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");
		StatusResDto resDto = new StatusResDto();

		// 로지컬컴포넌트명 조회
		int rtnChkLgcNm = kprLogicalComponentMapper.selectCheckLogicalComponentName(reqDto);

		// 로지컬컴포넌트명 중복 체크
		if (rtnChkLgcNm != 0) {
			resDto.setSuccess(false);
			resDto.setMessage(Messages.getMessage("M01433", reqDto.getLang()));
			return resDto;
		}

		// 기본정보 저장
		reqDto.setCmpltYn("0");
		reqDto.setLgcSql("");
		reqDto.setSVCAlias("");
		StatusResDto insertedLgcCompRes = new StatusResDto();
		if( kprLogicalComponentMapper.insertLogicalComponent(reqDto) > 0){
			insertedLgcCompRes.setSuccess(true);
		} else {
			insertedLgcCompRes.setSuccess(false);
		}
		if (!insertedLgcCompRes.getSuccess()) {
			resDto.setSuccess(false);
			resDto.setMessage(Messages.getMessage("M01510", reqDto.getLang()));
			return resDto;
		}

		// 조인설정이 아닐 때,
		if (reqDto.getJoinTableRelList() != null && !reqDto.getJoinTableRelList().isEmpty()) {
			// 조인설정일 때, 테이블 관계 처리
			for (KprLogicalComponentJoinTableRelReqDto joinTblRelItem : reqDto.getJoinTableRelList()) {
				// 추가 Req 처리
				joinTblRelItem.setCreateBy(reqDto.getCreateBy());
				joinTblRelItem.setModifyBy(reqDto.getModifyBy());
				//joinTblRelItem.setCountry(reqDto.getCountry());
				//joinTblRelItem.setAccountId(reqDto.getAccountId());
				joinTblRelItem.setTblRelId(joinTblRelItem.getTempTblRelId());

				// 저장 실행
				kprLogicalComponentMapper.insertJoinTableRel(joinTblRelItem);
			}

			// 조인설정일 때, 조인 컬럼 처리
			for (KprLogicalComponentJoinColumnReqDto joinColumnItem : reqDto.getJoinColumnList()) {
				// 추가 Req 처리
				joinColumnItem.setCreateBy(reqDto.getCreateBy());
				joinColumnItem.setModifyBy(reqDto.getModifyBy());
				joinColumnItem.setCountry(reqDto.getCountry());
				joinColumnItem.setAccountId(reqDto.getAccountId());
				joinColumnItem.setJoinColumnId(joinColumnItem.getTempJoinColumnId());

				// 저장 실행
				kprLogicalComponentMapper.insertJoinColumn(joinColumnItem);
			}

			// *** NHIS 관련 추가 ***/
			List<KprLogicalComponentGroupColumnReqDto> joinColumnGrpList = reqDto.getJoinColumnGrpList();
			if (ObjectUtil.isNotEmpty(joinColumnGrpList)) {
				for (KprLogicalComponentGroupColumnReqDto joinColumnGrpDtl : joinColumnGrpList) {
					joinColumnGrpDtl.setCreateBy(reqDto.getCreateBy());
					joinColumnGrpDtl.setModifyBy(reqDto.getModifyBy());
					
					this.kprLogicalComponentMapper.insertLgcCompGrpColDtl(joinColumnGrpDtl);
				}
			}
		}

		// 최종 저장 성공 시 메시지 설정
		resDto.setSuccess(true);
		resDto.setMessage(Messages.getMessage("M00015", reqDto.getLang()));
		return resDto;
	}

	 /*
	  * 1. 메소드명: addLogicalComponentSaveAs
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 8. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 다른이름으로 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column, anl.anl_atrib_group, anl_anl_atrib_group_column
	 *   @return StatusResDto
	 */
	public StatusResDto addLogicalComponentSaveAs(KprLogicalComponentReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		// 로지컬컴포넌트명 조회
		String baseLgcSql = reqDto.getLgcCompId();
		String newLgcCompId = reqDto.getTempLgcCompId();
		reqDto.setLgcCompId(newLgcCompId);
		int rtnChkLgcNm = kprLogicalComponentMapper.selectCheckLogicalComponentName(reqDto);

		// 로지컬컴포넌트명 중복 체크
		StatusResDto resDto = new StatusResDto();
		if (rtnChkLgcNm != 0) {
			resDto.setSuccess(false);
			resDto.setMessage(Messages.getMessage("M01433", reqDto.getLang()));
			return resDto;
		}

		// 로지컬 컴포넌트 전체 데이터 조회
		reqDto.setLgcCompId(baseLgcSql);
		reqDto.setSVCAlias("lgc");
		KprLogicalComponentResDto stdLgcCompObj = kprLogicalComponentMapper.selectLogicalComponent(reqDto);
		reqDto.setSVCAlias("");
		List<KprLogicalComponentTableRelResDto> stdTblRelList = kprLogicalComponentMapper.selectJoinTableRelList(reqDto);
		reqDto.setSVCAlias("aljc");
		List<KprLogicalComponentJoinColumnResDto> stdJoinColList = kprLogicalComponentMapper.selectJoinColumnList(reqDto);
		reqDto.setSVCAlias("");
		List<KprLogicalComponentAttributeGroupResDto> stdAtribGroupList = kprLogicalComponentMapper.selectAttributeGroupList(reqDto);
		reqDto.setSVCAlias("");
		List<KprLogicalComponentAttributeGroupColumnResDto> stdAtribGroupColList = kprLogicalComponentMapper.selectAttributeGroupColumnList(reqDto);

		// 로지컬 컴포넌트 복사
		KprLogicalComponentReqDto reqLgcCompDto = new KprLogicalComponentReqDto();
		reqLgcCompDto.setLgcCompId(newLgcCompId);
		reqLgcCompDto.setCreateBy(reqDto.getCreateBy());
		reqLgcCompDto.setModifyBy(reqDto.getModifyBy());
		reqLgcCompDto.setCountry(reqDto.getCountry());
		reqLgcCompDto.setCurrency(reqDto.getCurrency());
		reqLgcCompDto.setAccountId(reqDto.getAccountId());
		reqLgcCompDto.setType(reqDto.getType());
		reqLgcCompDto.setStoreId(reqDto.getStoreId());
		reqLgcCompDto.setLgcCompNm(reqDto.getLgcCompNm());
		reqLgcCompDto.setLgcDesc(reqDto.getLgcDesc());
		reqLgcCompDto.setLgcSql(stdLgcCompObj.getLgcSql());
		reqLgcCompDto.setCmpltYn(stdLgcCompObj.getCmpltYn());
		reqLgcCompDto.setDbInformId(stdLgcCompObj.getDbInformId());

		// 저장
		kprLogicalComponentMapper.insertLogicalComponent(reqLgcCompDto);

		// 테이블 관계 복사
		Map<String, String> tblRelNewKeyMap = new HashMap<>();
		List<KprLogicalComponentJoinTableRelReqDto> reqTblRelList = new ArrayList<>();
		for (KprLogicalComponentTableRelResDto curItem : stdTblRelList) {
			String newTblId = CommonUtil.newRid();
			tblRelNewKeyMap.put(curItem.getTableRelId(), newTblId);

			KprLogicalComponentJoinTableRelReqDto curReqDto = new KprLogicalComponentJoinTableRelReqDto();
			curReqDto.setTblRelId(newTblId);
			curReqDto.setCreateBy(reqDto.getCreateBy());
			curReqDto.setModifyBy(reqDto.getModifyBy());
			curReqDto.setType(reqDto.getType());
			curReqDto.setStoreId(reqDto.getStoreId());
			curReqDto.setLgcCompId(newLgcCompId);
			curReqDto.setTblId(curItem.getTblId());
			curReqDto.setSchmaTblNm(curItem.getSchmaTblNm());
			curReqDto.setTblNm(curItem.getTblNm());
			curReqDto.setTblAlias(curItem.getTblAlias());
			curReqDto.setOffSetX(curItem.getOffSetX());
			curReqDto.setOffSetY(curItem.getOffSetY());

			reqTblRelList.add(curReqDto);
			
			/** NHIS 관련 추가 */
			KprLogicalComponentGroupColumnReqDto curGrpColDto = new KprLogicalComponentGroupColumnReqDto();
			curGrpColDto.setTblRelId(curItem.getTableRelId());
			curGrpColDto.setTblRelId_New(newTblId);
			curGrpColDto.setCreateBy(reqDto.getCreateBy());
			curGrpColDto.setModifyBy(reqDto.getModifyBy());
			
			this.kprLogicalComponentMapper.insertLgcCompGrpColListSaveAs(curGrpColDto);
		}

		// 조인 설정 복사
		List<KprLogicalComponentJoinColumnReqDto> reqJoinColumnList = new ArrayList<>();
		for (KprLogicalComponentJoinColumnResDto curItem : stdJoinColList) {
			KprLogicalComponentJoinColumnReqDto curReqDto = new KprLogicalComponentJoinColumnReqDto();
			curReqDto.setJoinColumnId(CommonUtil.newRid());
			curReqDto.setCreateBy(reqDto.getCreateBy());
			curReqDto.setModifyBy(reqDto.getModifyBy());
			curReqDto.setType(reqDto.getType());
			curReqDto.setStoreId(reqDto.getStoreId());
			curReqDto.setSeq(curItem.getSeq());
			curReqDto.setJoinTypeCd(curItem.getJoinTypeCd());
			curReqDto.setLeftLgcCompTblRelId(tblRelNewKeyMap.get(curItem.getLeftLgcCompTblRelId()));
			curReqDto.setLeftColId(curItem.getLeftColId());
			curReqDto.setLeftTblAliasColNm(curItem.getLeftTblAliasColNm());
			curReqDto.setJoinOprtCd(curItem.getJoinOprtCd());
			curReqDto.setRightLgcCompTblRelId(tblRelNewKeyMap.get(curItem.getRightLgcCompTblRelId()));
			curReqDto.setRightColId(curItem.getRightColId());
			curReqDto.setRightTblAliasColNm(curItem.getRightTblAliasColNm());

			reqJoinColumnList.add(curReqDto);
		}

		// 어트리뷰트 그룹 복사
		Map<String, String> atribGroupIdMap = new HashMap<>();
//		List<KprLogicalComponentAttributeGroupReqDto> reqAtribGroupList = new ArrayList<>();
		for (KprLogicalComponentAttributeGroupResDto curItem : stdAtribGroupList) {

			String newAtribGroupId = CommonUtil.newRid();
			atribGroupIdMap.put(curItem.getAttributeGroupId(), newAtribGroupId);

			KprLogicalComponentAttributeGroupReqDto curReqDto = new KprLogicalComponentAttributeGroupReqDto();
			curReqDto.setAttributeGroupId(newAtribGroupId);
			curReqDto.setCreateBy(reqDto.getCreateBy());
			curReqDto.setModifyBy(reqDto.getModifyBy());
			curReqDto.setType(reqDto.getType());
			curReqDto.setStoreId(reqDto.getStoreId());
			curReqDto.setAtribGroupNm(curItem.getAtribGroupNm());
			curReqDto.setSeq(curItem.getSeq());
			curReqDto.setLgcCompId(newLgcCompId);

//			reqAtribGroupList.add(curReqDto);
			curReqDto.setSVCAlias("");
			kprLogicalComponentMapper.insertAttributeGroupByList(curReqDto);
		}

		// 어트리뷰트 그룹 칼럼 복사
//		List<KprLogicalComponentAttributeGroupColumnReqDto> reqAtribGroupColList = new ArrayList<>();
		for (KprLogicalComponentAttributeGroupColumnResDto curItem : stdAtribGroupColList) {

			KprLogicalComponentAttributeGroupColumnReqDto curReqDto = new KprLogicalComponentAttributeGroupColumnReqDto();
			curReqDto.setAttributeGroupColumnId(CommonUtil.newRid());
			curReqDto.setCreateBy(reqDto.getCreateBy());
			curReqDto.setModifyBy(reqDto.getModifyBy());
			curReqDto.setType(reqDto.getType());
			curReqDto.setStoreId(reqDto.getStoreId());
			curReqDto.setSeq(curItem.getSeq());
			curReqDto.setLgcCompTblRelId(tblRelNewKeyMap.get(curItem.getLgcCompTblRelId()));
			curReqDto.setColId(curItem.getColId());
			curReqDto.setDpNm(curItem.getDpNm());
			curReqDto.setDimColId(curItem.getDimColId());
			curReqDto.setCalDtl(curItem.getCalDtl());
			curReqDto.setCalDtlHis(curItem.getCalDtlHis());
			curReqDto.setTblAliasColNm(curItem.getTblAliasColNm());
			curReqDto.setCalColYn(curItem.getCalColYn());
			curReqDto.setAtribGroupId(atribGroupIdMap.get(curItem.getAtribGroupId()));
			curReqDto.setSegKeyYn(curItem.getSegKeyYn());
			curReqDto.setDateKeyYn(curItem.getDateKeyYn());
			curReqDto.setEvtTriggerKeyYn(curItem.getEvtTriggerKeyYn());
			curReqDto.setLgcCompId(newLgcCompId);
			curReqDto.setSqlValue(curItem.getValSql());

//			reqAtribGroupColList.add(curReqDto);
			kprLogicalComponentMapper.insertAttributeGroupColumn(curReqDto);
		}

		// 복사 데이터 담기
		reqLgcCompDto.setJoinTableRelList(reqTblRelList);
		reqLgcCompDto.setJoinColumnList(reqJoinColumnList);
//		reqLgcCompDto.setAtribGroupList(reqAtribGroupList);
//		reqLgcCompDto.setAtribGroupColumnList(reqAtribGroupColList);

		if (reqLgcCompDto.getJoinTableRelList() != null && !reqLgcCompDto.getJoinTableRelList().isEmpty()) {
			reqLgcCompDto.setSVCAlias("");
			kprLogicalComponentMapper.insertJoinTableRelByList(reqLgcCompDto);
		}
		if (reqLgcCompDto.getJoinColumnList() != null && !reqLgcCompDto.getJoinColumnList().isEmpty()) {
			reqLgcCompDto.setSVCAlias("");
			kprLogicalComponentMapper.insertJoinColumnByList(reqLgcCompDto);
		}
//		if (reqLgcCompDto.getAtribGroupList() != null && !reqLgcCompDto.getAtribGroupList().isEmpty()) {
//			kprLogicalComponentMapper.insertAttributeGroupByList(reqLgcCompDto);
//		}
//		if (reqLgcCompDto.getAtribGroupColumnList() != null && !reqLgcCompDto.getAtribGroupColumnList().isEmpty()) {
//			kprLogicalComponentMapper.insertAttributeGroupColumnByList(reqLgcCompDto);
//		}

		// 반환값 설정
		resDto.setSuccess(true);
		resDto.setMessage(Messages.getMessage("M00015", reqDto.getLang()));

		return resDto;
	}

	 /*
	  * 1. 메소드명: newUUID
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 8. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		신규 UUID 생성
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return String
	 */
	@SuppressWarnings("unused")
	private String newUUID() {
		return UUID.randomUUID().toString().replaceAll("-", "").substring(0, 24);
	}

	 /*
	  * 1. 메소드명: editLogicalComponent
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 6. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column, anl.anl_atrib_group, anl_anl_atrib_group_column
	 *   @return	
	 */
	public KprLogicalComponentResDto editLogicalComponent(KprLogicalComponentReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");
		KprLogicalComponentResDto resDto = new KprLogicalComponentResDto();

		/*
		 * kj.kang // 분석 및 세그먼트 조회 int chkUsing =
		 * kprLogicalComponentMapper.selectCheckUsingOnSegmentAndReport(reqDto);
		 * 
		 * // 분석 및 세그먼트 사용여부 확인 if(chkUsing != 0){ // 분석 및 세그먼트 사용 시 메시지 설정
		 * resDto.setAnalysisSegmentUsed(true); resDto.setSuccess(false);
		 * resDto.setMessage(Messages.getMessage("M01439", reqDto.getLang()));
		 * 
		 * return resDto; }
		 */

		// 로지컬컴포넌트명 조회 //0
		int rtnChkLgcNm = kprLogicalComponentMapper.selectCheckLogicalComponentName(reqDto);

		// 로지컬컴포넌트명 중복 체크 //0 이므로 진입하지 않음
		if (rtnChkLgcNm != 0) {
			resDto.setSuccess(false);
			resDto.setMessage(Messages.getMessage("M01433", reqDto.getLang()));
			return resDto;
		}

		// 기본정보 저장 //값이 비어있으면 값을 채워줌
		StatusResDto resLgcUpdDto =  new StatusResDto();
		kprLogicalComponentMapper.updateLogicalComponent(reqDto);
		resLgcUpdDto.setSuccess(true);
		
		if (!resLgcUpdDto.getSuccess()) {
			resDto.setSuccess(false);
			resDto.setMessage(Messages.getMessage("M01511", reqDto.getLang()));
			return resDto;
		}

		// 수정, 저장 되지 않은 ID를 찾아 삭제 할 로직에서 사용할 ID 리스트
		KprLogicalComponentDeleteIdListReqDto delReqDto = new KprLogicalComponentDeleteIdListReqDto();
		delReqDto.setLgcCompId(reqDto.getLgcCompId());
		delReqDto.setModifyBy(reqDto.getModifyBy());
		List<String> isrtUpdIdList;

		// 조인설정이 아닐 때,
		if (reqDto.getJoinTableRelList() != null && !reqDto.getJoinTableRelList().isEmpty()) {

			// 조인설정일 때, 테이블 관계 처리
			isrtUpdIdList = new ArrayList<>();
			for (KprLogicalComponentJoinTableRelReqDto joinTblRelItem : reqDto.getJoinTableRelList()) {

				joinTblRelItem.setCreateBy(reqDto.getCreateBy());
				joinTblRelItem.setModifyBy(reqDto.getModifyBy());

				// 조인설정일 때, 테이블 관계 반복 저장
				if (joinTblRelItem.getTempTblRelId() != null && !joinTblRelItem.getTempTblRelId().equals("")) {
					joinTblRelItem.setTblRelId(joinTblRelItem.getTempTblRelId());

					kprLogicalComponentMapper.insertJoinTableRel(joinTblRelItem);

					isrtUpdIdList.add(joinTblRelItem.getTempTblRelId());
				}
				// 조인설정일 때, 테이블 관계 반복 수정
				else {
					joinTblRelItem.setSVCAlias("");
					kprLogicalComponentMapper.updateJoinTableRel(joinTblRelItem);
					isrtUpdIdList.add(joinTblRelItem.getTblRelId());
				}
			}
			// 저장, 수정 되지 않은 테이블 관계는 삭제
			delReqDto.setRemoveIdList(isrtUpdIdList);
			kprLogicalComponentMapper.deleteJoinTableRel(delReqDto);

			// 조인설정일 때, 조인 컬럼 처리
			isrtUpdIdList = new ArrayList<>();
			for (KprLogicalComponentJoinColumnReqDto joinColumnItem : reqDto.getJoinColumnList()) {

				joinColumnItem.setCreateBy(reqDto.getCreateBy());
				joinColumnItem.setModifyBy(reqDto.getModifyBy());

				// 조인설정일 때, 칼럼 반복 저장
				if (joinColumnItem.getTempJoinColumnId() != null && !joinColumnItem.getTempJoinColumnId().equals("")) {
					joinColumnItem.setJoinColumnId(joinColumnItem.getTempJoinColumnId());
					joinColumnItem.setModifyBy(reqDto.getModifyBy());
					joinColumnItem.setSVCAlias("");
					kprLogicalComponentMapper.insertJoinColumn(joinColumnItem);

					isrtUpdIdList.add(joinColumnItem.getTempJoinColumnId());
				}
				// 조인설정일 때, 칼럼 반복 수정 또는 삭제
				else {
					joinColumnItem.setSVCAlias("");
					kprLogicalComponentMapper.updateJoinColumn(joinColumnItem);
					isrtUpdIdList.add(joinColumnItem.getJoinColumnId());
				}
			}
			// 저장, 수정 되지 않은 테이블 관계는 삭제
			delReqDto.setRemoveIdList(isrtUpdIdList);
			kprLogicalComponentMapper.deleteJoinColumn(delReqDto);

			// *** NHIS 관련 추가 ***/
			List<String> tblRelIdList = new ArrayList<String>();
			List<KprLogicalComponentGroupColumnReqDto> joinColumnGrpList = reqDto.getJoinColumnGrpList();
			if (ObjectUtil.isNotEmpty(joinColumnGrpList)) {
				for (KprLogicalComponentGroupColumnReqDto joinColumnGrpDtl : joinColumnGrpList) {
					joinColumnGrpDtl.setCreateBy(reqDto.getCreateBy());
					joinColumnGrpDtl.setModifyBy(reqDto.getModifyBy());
					
					String grpColId = joinColumnGrpDtl.getGrpColId();
					if (ObjectUtil.isEmpty(grpColId)) {
						this.kprLogicalComponentMapper.insertLgcCompGrpColDtl(joinColumnGrpDtl);						
					} else {
						this.kprLogicalComponentMapper.updateLgcCompGrpColDtl(joinColumnGrpDtl);
					}
					
					if (!tblRelIdList.contains(joinColumnGrpDtl.getTblRelId())) {
						tblRelIdList.add(joinColumnGrpDtl.getTblRelId());
					}
				}
			}
			KprLogicalComponentGroupColumnReqDto joinColumnGrpDtl = new KprLogicalComponentGroupColumnReqDto();
			joinColumnGrpDtl.setModifyBy(reqDto.getModifyBy());
			joinColumnGrpDtl.setLgcCompId(reqDto.getLgcCompId());
			joinColumnGrpDtl.setTblRelIdList(tblRelIdList);
			this.kprLogicalComponentMapper.deleteLgcCompGrpColDtl(joinColumnGrpDtl);

			// DB 서비스 정보가 바뀐 경우 모든 AttributeGroup 정보를 제거
			isrtUpdIdList = new ArrayList<>();
			delReqDto.setRemoveIdList(isrtUpdIdList);

			if (reqDto.isDbInformIdChange()) {
				kprLogicalComponentMapper.deleteAttributeGroup(delReqDto);
				kprLogicalComponentMapper.deleteAttributeGroupColumn(delReqDto);
			}
		} else {
			// Attribute Group 처리
			isrtUpdIdList = new ArrayList<>();
			for (KprLogicalComponentAttributeGroupReqDto atribGrpItem : reqDto.getAtribGroupList()) {

				atribGrpItem.setCreateBy(reqDto.getCreateBy());
				atribGrpItem.setModifyBy(reqDto.getModifyBy());
				atribGrpItem.setCountry(reqDto.getCountry());

				// 어트리뷰트 그룹 설정일 때, 어트리뷰트 그룹 저장
				if (atribGrpItem.getTempAttributeGroupId() != null && !atribGrpItem.getTempAttributeGroupId().equals("")) {
					atribGrpItem.setAttributeGroupId(atribGrpItem.getTempAttributeGroupId());

					kprLogicalComponentMapper.insertAttributeGroup(atribGrpItem);
					isrtUpdIdList.add(atribGrpItem.getTempAttributeGroupId());
				}
				// 어트리뷰트 그룹 설정일 때, 어트리뷰트 그룹 수정
				else {
					kprLogicalComponentMapper.updateAttributeGroup(atribGrpItem);
					isrtUpdIdList.add(atribGrpItem.getAttributeGroupId());
				}
			}
			// 저장, 수정 되지 않은 어트리뷰트 그룹은 삭제
			delReqDto.setRemoveIdList(isrtUpdIdList);
			kprLogicalComponentMapper.deleteAttributeGroup(delReqDto);

			// Attribute Group Column 처리
			isrtUpdIdList = new ArrayList<>();
			for (KprLogicalComponentAttributeGroupColumnReqDto atribGrpColItem : reqDto.getAtribGroupColumnList()) {

				atribGrpColItem.setCreateBy(reqDto.getCreateBy());
				atribGrpColItem.setModifyBy(reqDto.getModifyBy());
				atribGrpColItem.setCountry(reqDto.getCountry());

				// 어트리뷰트 그룹 설정일 때, 어트리뷰트 그룹 칼럼 저장
				if (atribGrpColItem.getTempAttributeGroupColumnId() != null && !atribGrpColItem.getTempAttributeGroupColumnId().equals("")) {
					atribGrpColItem.setAttributeGroupColumnId(atribGrpColItem.getTempAttributeGroupColumnId());

					kprLogicalComponentMapper.insertAttributeGroupColumn(atribGrpColItem);
					isrtUpdIdList.add(atribGrpColItem.getTempAttributeGroupColumnId());
				}
				// 어트리뷰트 그룹 설정일 때, 어트리뷰트 그룹 칼럼 수정
				else {
					kprLogicalComponentMapper.updateAttributeGroupColumn(atribGrpColItem);
					isrtUpdIdList.add(atribGrpColItem.getAttributeGroupColumnId());
				}
			}
			// 저장, 수정 되지 않은 어트리뷰트 그룹 칼럼은 삭제
			delReqDto.setRemoveIdList(isrtUpdIdList);
			kprLogicalComponentMapper.deleteAttributeGroupColumn(delReqDto);
		}

		// 연결관계가 없어진 어트리뷰트 그룹 칼럼 삭제
		kprLogicalComponentMapper.deleteAttributeGroupColumnOnNoneTableRel(reqDto);

		// 디멘젼 어트리뷰트 그룹 칼럼 중, 삭제 대상 조회 및 삭제
		kprLogicalComponentMapper.deleteAttributeGroupDimensionColumnAll(reqDto);
		reqDto.setSVCAlias("");
		// 디멘젼 어트리뷰트 그룹 칼럼 중, Insert 필요 값 조회
		List<KprLogicalComponentAttributeGroupColumnResDto> dimenAtribGroupColList = kprLogicalComponentMapper.selectAttributeGroupDimensionColumn(reqDto);
		// 저장할 디멘전 어트리뷰트 그룹 컬럼 저장 없는 경우는 Pass
		if (dimenAtribGroupColList != null && !dimenAtribGroupColList.isEmpty()) {
			// 디멘젼 어트리뷰트 그룹 칼럼 Insert Request 값 세팅

			int seq = 1;
			// List<KPRLogicalComponentAttributeGroupColumnRequestDTO>
			// reqAtribGroupColList = new ArrayList<>();
			for (KprLogicalComponentAttributeGroupColumnResDto curItem : dimenAtribGroupColList) {

				KprLogicalComponentAttributeGroupColumnReqDto curReqDto = new KprLogicalComponentAttributeGroupColumnReqDto();
				curReqDto.setAttributeGroupColumnId(CommonUtil.newRid());
				curReqDto.setCreateBy(reqDto.getCreateBy());
				curReqDto.setModifyBy(reqDto.getModifyBy());
				curReqDto.setCountry(reqDto.getCountry());
				curReqDto.setCurrency(reqDto.getCurrency());
				curReqDto.setAccountId(reqDto.getAccountId());
				curReqDto.setType(reqDto.getType());
				curReqDto.setStoreId(reqDto.getStoreId());
				curReqDto.setSeq(Integer.toString(seq++));
				curReqDto.setLgcCompTblRelId(curItem.getLgcCompTblRelId());
				curReqDto.setColId(curItem.getColId());
				curReqDto.setDpNm(curItem.getDpNm());
				curReqDto.setDimColId(curItem.getDimColId());
				curReqDto.setCalDtl(curItem.getCalDtl());
				curReqDto.setCalDtlHis(curItem.getCalDtlHis());
				curReqDto.setTblAliasColNm(curItem.getTblAliasColNm());
				curReqDto.setCalColYn(curItem.getCalColYn());
				curReqDto.setAtribGroupId(curItem.getAtribGroupId());
				curReqDto.setSegKeyYn(curItem.getSegKeyYn());
				curReqDto.setDateKeyYn(curItem.getDateKeyYn());
				curReqDto.setEvtTriggerKeyYn(curItem.getEvtTriggerKeyYn());
				curReqDto.setLgcCompId(reqDto.getLgcCompId());

				kprLogicalComponentMapper.insertAttributeGroupColumn(curReqDto);
				/* reqAtribGroupColList.add(curReqDto); */
			}
			/*
			 * KPRLogicalComponentRequestDTO dimenReqDto = reqDto;
			 * dimenReqDto.setAtribGroupColumnList(reqAtribGroupColList);
			 * kprLogicalComponentMapper.insertAttributeGroupColumnByList(dimenReqDto);
			 */
		}

		// 로지컬 컴포넌트 쿼리 생성
//		KPRLogicalComponentResponseDTO resSqlDto = new KPRLogicalComponentResponseDTO();
		String lgcSQL = null;
		try {
			KprLogicalComponentEngineDetailReqDto lgcCompEngineRequestDTO = new KprLogicalComponentEngineDetailReqDto();
			lgcCompEngineRequestDTO.setLang(reqDto.getLang());
			lgcCompEngineRequestDTO.setApdColFlag(true);
			lgcCompEngineRequestDTO.setLgcCompId(reqDto.getLgcCompId());

			lgcSQL = kprLogicalComponentEngineService.getLogicalComponentSQL(lgcCompEngineRequestDTO);

		} catch (Exception e) {
			LogUtil.error(e);

			reqDto.setLgcSql(lgcSQL);
			reqDto.setCmpltYn("0");
			kprLogicalComponentMapper.updateLogicalComponent(reqDto);

			// 쿼리 생성 실패 시 메시지 설정
			resDto.setSuccess(true);
			resDto.setMessage(Messages.getMessage("M01512", reqDto.getLang()));
			return resDto;
		}

		resDto.setLgcCompId(reqDto.getLgcCompId());
		resDto.setLgcCompNm(reqDto.getLgcCompNm());
		resDto.setLgcDesc(reqDto.getLgcDesc());
		resDto.setDbInformId(reqDto.getDbInformId());
		resDto.setLgcSql(lgcSQL);

		// 로지컬컴포넌트 쿼리 생성 확인
		if (lgcSQL == null || "".equals(lgcSQL)) {
			reqDto.setLgcSql(lgcSQL);
			reqDto.setCmpltYn("0");
			kprLogicalComponentMapper.updateLogicalComponent(reqDto);

			// 쿼리 생성 실패 시 메시지 설정
			resDto.setSuccess(true);
			resDto.setMessage(Messages.getMessage("M01512", reqDto.getLang()));
			return resDto;
		}

		// SQL Count로 쿼리 실행 체크만 함.
//		String lgcSql = resSqlDto.getLgcSql();
		StringBuffer lgcSqlBuffer = new StringBuffer();
		lgcSqlBuffer.append(" select count(1) as cnt from ( ")
					.append(lgcSQL)
					.append(" ) test where 1=0 ");

		reqDto.setLgcSql(lgcSqlBuffer.toString());
		reqDto.setCmpltYn("0");
		kprLogicalComponentMapper.updateLogicalComponent(reqDto);

		// 타시스템에 쿼리 실행
		StatusResDto exeRsrtQuery = executeQuery(reqDto);
		if (!exeRsrtQuery.getSuccess()) {
			// 타시스템에 쿼리 실행 실패 시 메시지 설정
			resDto.setSuccess(true);
			resDto.setMessage(Messages.getMessage("M01546", reqDto.getLang()));

			reqDto.setLgcSql(lgcSQL);
			reqDto.setCmpltYn("0");
			kprLogicalComponentMapper.updateLogicalComponent(reqDto);

			return resDto;
		}

		// 쿼리 생성 및 실행 완료시 사용가능 플래그 및 SQL 업데이트
		reqDto.setLgcSql(lgcSQL);
		reqDto.setCmpltYn("1");
		kprLogicalComponentMapper.updateLogicalComponent(reqDto);

		// 최종 저장 성공 시 메시지 설정
		resDto.setSuccess(true);
		resDto.setMessage(Messages.getMessage("M00015", reqDto.getLang()));
		return resDto;
	}

	 /*
	  * 1. 메소드명: editLogicalComponentAttributeGroupColumnName
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 6. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 어트리뷰트 그룹 칼럼명만 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column, anl.anl_atrib_group, anl_anl_atrib_group_column
	 *   @return KPRLogicalComponentResponseDTO
	 */
	public KprLogicalComponentResDto editLogicalComponentAttributeGroupColumnName(KprLogicalComponentReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		KprLogicalComponentResDto resDto = new KprLogicalComponentResDto();

		for (KprLogicalComponentAttributeGroupColumnReqDto atribGrpItem : reqDto.getAtribGroupColumnList()) {

			atribGrpItem.setCreateBy(reqDto.getCreateBy());
			atribGrpItem.setModifyBy(reqDto.getModifyBy());
			atribGrpItem.setCountry(reqDto.getCountry());

			kprLogicalComponentMapper.updateAttributeGroupColumnName(atribGrpItem);
		}

		// 최종 저장 성공 시 메시지 설정
		resDto.setSuccess(true);
		resDto.setMessage(Messages.getMessage("M00015", reqDto.getLang()));
		return resDto;
	}

	 /*
	  * 1. 메소드명: removeLogicalComponent
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 6. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column, anl.anl_atrib_group, anl_anl_atrib_group_column
	 *   @return StatusResDto
	 */
	public StatusResDto removeLogicalComponent(KprLogicalComponentReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");
		StatusResDto resDto = new StatusResDto();

		// 분석 및 세그먼트 조회
		int chkUsing = kprLogicalComponentMapper.selectCheckUsingOnSegmentAndReport(reqDto);

		// 분석 및 세그먼트 사용여부 확인
		if (chkUsing != 0) {
			// 분석 및 세그먼트 사용 시 메시지 설정
			resDto.setSuccess(false);
			resDto.setMessage(Messages.getMessage("M01439", reqDto.getLang()));

			return resDto;
		}

		// 모든 조인 관계 삭제
		kprLogicalComponentMapper.deleteJoinColumnAll(reqDto);

		reqDto.setSVCAlias("");
		// 모든 테이블 관계 삭제
		kprLogicalComponentMapper.deleteJoinTableRelAll(reqDto);
		
		KprLogicalComponentGroupColumnReqDto joinColumnGrpDtl = new KprLogicalComponentGroupColumnReqDto();
		joinColumnGrpDtl.setModifyBy(reqDto.getModifyBy());
		joinColumnGrpDtl.setLgcCompId(reqDto.getLgcCompId());
		this.kprLogicalComponentMapper.deleteLgcCompGrpColDtl(joinColumnGrpDtl);

		// 모든 Attribute Group 삭제
		kprLogicalComponentMapper.deleteAttributeGroupColumnAll(reqDto);

		// 모든 Attribute Group 칼럼 삭제
		kprLogicalComponentMapper.deleteAttributeGroupAll(reqDto);

		// 로지컬 컴포넌트 삭제
		kprLogicalComponentMapper.deleteLogicalComponent(reqDto);

		// 로지컬 컴포넌트 삭제 완료시 메시지 설정
		resDto.setSuccess(true);
		resDto.setMessage(Messages.getMessage("M00003", reqDto.getLang()));

		return resDto;
	}

	 /*
	  * 1. 메소드명: executeQuery
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 8. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 대상 시스템 DBMS에 쿼리 실행
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return StatusResDto
	 */
	@SuppressWarnings("unchecked")
	public StatusResDto executeQuery(KprLogicalComponentReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");
		// DB Information 가져오기
		KprLogicalComponentDbServiceResDto dbServiceDto = getDbServiceInfo(reqDto);

		// ReqDto Setting
		MKTDBInfoDTO reqDbInfoDto = new MKTDBInfoDTO();
		reqDbInfoDto.setDriverClassName(dbServiceDto.getConDbClass());
		reqDbInfoDto.setConIp(dbServiceDto.getConIp());
		reqDbInfoDto.setConPort(dbServiceDto.getConPort());
		reqDbInfoDto.setUserName(dbServiceDto.getConId());
		reqDbInfoDto.setPassword(dbServiceDto.getConPw());
		reqDbInfoDto.setUrl(dbServiceDto.getConUrl());
		reqDbInfoDto.setConDbType(dbServiceDto.getConDbType());

		// 쿼리 실행
		StatusResDto resDto = new StatusResDto(false, "");
		List<String> resQuery;
		try {
			resQuery = mktCallQueryDao.callSelectForListMap("executeQuery", reqDto.getLgcSql(), new ArrayList<String>(), reqDbInfoDto);
			if (resQuery == null || resQuery.isEmpty()) {
				resDto.setMessage("NONE_DATA");
			}
			resDto.setSuccess(true);

		} catch (DataSQLException e) {
			resDto.setMessage("QUERY_ERROR");
		} catch (Exception e) {
			resDto.setMessage("NONE_CONNECTION");
 		}

		return resDto;
	}
	
	public KprLogicalComponentDbServiceResDto getDbServiceInfo(KprLogicalComponentReqDto reqDto){
		reqDto.setSVCAlias("");
		LogUtil.param(this.getClass(), reqDto);

		KprLogicalComponentDbServiceResDto resDto = kprLogicalComponentMapper.selectDbServiceInfo(reqDto);
		
		if(ObjectUtil.isNotEmpty(resDto.getSecretNm())) {
			//AWS Secrets Manager db 정보 조회
			Map<String, Object> dbInfoJSON = new SecretsManager(BeansUtil.getAWSCredentials(),
					BeansUtil.getAwsRegion()).getSecretMap(resDto.getSecretNm());

				//dbInfoJSON = AWSSecretsManagerConfig.getSecretValueResult(resDto.getSecretNm());
				
				resDto.setConUrl(dbInfoJSON.get("url").toString());
				resDto.setConId(dbInfoJSON.get("username").toString());
				//resDto.setConPw(encrypor.decrypt(dbInfoJSON.get("password").toString()));
				resDto.setConPw(dbInfoJSON.get("password").toString());
				resDto.setConIp(dbInfoJSON.get("ip").toString());
				resDto.setConPort(dbInfoJSON.get("port").toString());
				
		} else {
			if(ObjectUtil.isNotEmpty(resDto.getConPw())) {
				resDto.setConPw(encrypor.decrypt(resDto.getConPw()));
			}
		}
		
		return resDto;
	}

	 /*
	  * 1. 메소드명: getJoinAccordionList
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 7. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 조인 설정 > 왼족 어코디언 트리 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column, anl.anl_atrib_group, anl_anl_atrib_group_column
	 *   @return List<KPRLogicalComponentJoinAccordionListResponseDTO>
	 */
	public List<KprLogicalComponentJoinAccordionListResDto> getJoinAccordionList(KprLogicalComponentJoinAccordionListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");
		// 어코디언 조회
		List<KprLogicalComponentJoinAccordionListResDto> stdAccordionDto = kprLogicalComponentMapper.selectJoinAccordionList(reqDto);
		
		// NHIS 수정
		// 조회 대상 테이블 ID List
		List<String> tblIdList = ObjectUtil.isNotEmpty(reqDto.getTblIdList()) ? reqDto.getTblIdList() : new ArrayList<String>();
		List<String> lgcCompTblIdList = this.kprLogicalComponentMapper.selectLgcCompTblList(reqDto);
		List<String> totalTblIdList = new ArrayList<String>();
		totalTblIdList.addAll(tblIdList);
		totalTblIdList.addAll(lgcCompTblIdList);
		
		// 반환 어코디언 데이터 생성
		List<KprLogicalComponentJoinAccordionListResDto> resAccordionDto = new ArrayList<>();
		for (KprLogicalComponentJoinAccordionListResDto item : stdAccordionDto) {

			// 트리 조회 DTO 설정
			KprLogicalComponentJoinAccordionTreeNodeListReqDto treeReqDto = new KprLogicalComponentJoinAccordionTreeNodeListReqDto();
			treeReqDto.setDbInformId(reqDto.getDbInformId());
			treeReqDto.setTblTypeCdId(item.getId());
			treeReqDto.setTblIdList(totalTblIdList);
			reqDto.setSVCAlias("");
			// 트리 조회
			List<KprLogicalComponentJoinAccordionTreeNodeListResDto> resTreeList = kprLogicalComponentMapper.selectJoinAccordionTreeNodeList(treeReqDto);

			// 트리가 존재 시, 반환 어코디언에 추가
			if (resTreeList != null && !resTreeList.isEmpty()) {
				item.setTreeList(resTreeList);
				resAccordionDto.add(item);
			}

		}

		return resAccordionDto;
	}

	 /*
	  * 1. 메소드명: getJoinDbServiceComboList
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 조인 설정 > DB 서비스 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column, anl.anl_atrib_group,  anl_anl_atrib_group_column
	 *   @return List<KPRLogicalComponentJoinDbServiceComboListResponseDTO>
	 */
	public List<KprLogicalComponentJoinDbServiceComboListResDto> getJoinDbServiceComboList(KprLogicalComponentJoinDbServiceComboListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("adi");
		return kprLogicalComponentMapper.selectJoinDbServiceComboList(reqDto);
	}

	 /*
	  * 1. 메소드명: getJoinColumnMasterList
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 조인 설정 > 다이어그램 > 테이블 노드 칼럼 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_column_mst
	 *   @return List<KPRLogicalComponentJoinColumnMasterListResponseDTO>
	 */
	public List<KprLogicalComponentJoinColumnMasterListResDto> getJoinColumnMasterList(KprLogicalComponentJoinColumnMasterListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");
		List<KprLogicalComponentJoinColumnMasterListResDto> resDto = kprLogicalComponentMapper.selectJoinColumnMasterList(reqDto);

		if (resDto == null) {
			resDto = new ArrayList<>();
		} else {
			for (KprLogicalComponentJoinColumnMasterListResDto item : resDto) {
				item.setColumn(item.getCol());
			}
		}

		return resDto;
	}

	 /*
	  * 1. 메소드명: getJoinColumnMasterPopupList
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 조인 설정 > 다이어그램 > 테이블 노드 칼럼 팝업 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_column_mst
	 *   @return GridPagingResDto
	 */
	@SuppressWarnings("unchecked")
	public GridPagingResDto<KprLogicalComponentJoinColumnMasterPopupListResDto> getJoinColumnMasterPopupList(KprLogicalComponentJoinColumnMasterListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("acm");
		return new GridPagingResHelper<KprLogicalComponentJoinColumnMasterPopupListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), kprLogicalComponentMapper.selectJoinColumnMasterPopupList(reqDto));
	}

	 /*
	  * 1. 메소드명: getLeftAttributeGroupAccordionList
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호 
	  * 4. 작성일자: 2016. 7. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 어트리뷰트 그룹 설정 > 왼쪽 어코디언 트리 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column, anl.anl_atrib_group, anl_anl_atrib_group_column
	 *   @return List<KPRLogicalComponentAttributeGroupLeftAccordionListResponseDTO>
	 */
	public List<KprLogicalComponentAttributeGroupLeftAccordionListResDto> getLeftAttributeGroupAccordionList(KprLogicalComponentAttributeGroupLeftAccordionListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");
		// 어코디언 조회
		List<KprLogicalComponentAttributeGroupLeftAccordionListResDto> stdAccodionDto = kprLogicalComponentMapper.selectAttributeGroupLeftAccordionList(reqDto);
		/*
		 * List<KPRLogicalComponentAttributeGroupLeftAccordionListResponseDTO> rtnList =
		 * new ArrayList<>(); rtnList = this.queryForList(KPR_LGC +
		 * "selectAttributeGroupLeftAccordionList", reqDto);
		 */
		
		
		List<KprLogicalComponentAttributeGroupLeftAccordionListResDto> resAccodionDto = new ArrayList<>();

		for (KprLogicalComponentAttributeGroupLeftAccordionListResDto item : stdAccodionDto) {

			// 트리 조회 DTO 설정
			KprLogicalComponentAttributeGroupLeftAccordionTreeNodeListReqDto treeReqDto = new KprLogicalComponentAttributeGroupLeftAccordionTreeNodeListReqDto();
			treeReqDto.setLgcCompTblRelId(item.getLgcCompTblRelId());
			treeReqDto.setTblAlias(item.getTblAlias());
			treeReqDto.setTblMstId(item.getTblMstId());
			treeReqDto.setLgcCompId(reqDto.getLgcCompId());
			treeReqDto.setGrpFlag(false);
			
			String tblTypeCd = item.getTblTypeCd();
			if ("FACT".equals(tblTypeCd) || "AGG".equals(tblTypeCd)) {
				int grpCnt = this.kprLogicalComponentMapper.selectLgcCompTblGrpCnt(treeReqDto);
				
				if (grpCnt > 0) {
					treeReqDto.setGrpFlag(true);
				}
			}

			// 트리 조회
			List<KprLogicalComponentAttributeGroupLeftAccordionTreeNodeListResDto> resTreeList = kprLogicalComponentMapper.selectAttributeGroupLeftAccordionTreeNodeList(treeReqDto);

			/*
			 * List<KPRLogicalComponentAttributeGroupLeftAccordionTreeNodeListResponseDTO>
			 * rtnList = new ArrayList<>(); rtnList = this.queryForList(KPR_LGC +
			 * "selectAttributeGroupLeftAccordionTreeNodeList", reqDto);
			 */
			
			
			// 트리가 없을 시 반환 어코디언을 제외
			if (resTreeList != null && !resTreeList.isEmpty()) {
				item.setTreeList(resTreeList);
				resAccodionDto.add(item);
			}
		}

		return resAccodionDto;
	}

	 /*
	  * 1. 메소드명: getAttributeGroupTreeNodeList
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 7. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 어트리뷰트 그룹 설정 > 어트리뷰트 그룹 트리 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column, anl.anl_atrib_group, anl_anl_atrib_group_column
	 *   @return List<KPRLogicalComponentAttributeGroupTreeNodeListResponseDTO>
	 */
	public List<KprLogicalComponentAttributeGroupTreeNodeListResDto> getAttributeGroupTreeNodeList(KprLogicalComponentAttributeGroupTreeNodeListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("aag");
		return kprLogicalComponentMapper.selectAttributeGroupTreeNodeList(reqDto);
	}

	 /*
	  * 1. 메소드명: checkAttributeCalField
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 8. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 어트리뷰트 그룹 설정 > 변환 필드 신규/수정 > 저장 시, 변환 필드 작동 확인
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_lgc_comp_mst, anl.anl_lgc_table_rel, anl.anl_lgc_join_column, anl.anl_atrib_group, anl_anl_atrib_group_column
	 *   @return StatusResDto
	 */
	public StatusResDto checkAttributeCalField(KprLogicalComponentCheckAttributeCalFieldReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		// Query 생성
		String calDtl = reqDto.getCalDtl();

		StringBuffer query = new StringBuffer();
		query.append(" select " + calDtl)
			 .append(" from ");

		List<String> tblNmAliasList = reqDto.getTblNmAliasList();
		if (tblNmAliasList != null && !tblNmAliasList.isEmpty()) {
			for (int i = 0; i < tblNmAliasList.size(); i++) {
				String curTblNmAlias = tblNmAliasList.get(i);
				if (i == 0) {
					query.append(" " + curTblNmAlias);
				} else {
					query.append(", " + curTblNmAlias);
				}
			}
			query.append(" where 1 = 2 ");
		} else {
			return new StatusResDto(false, Messages.getMessage("M01465", reqDto.getLang()));
		}

		KprLogicalComponentReqDto execReqDto = new KprLogicalComponentReqDto();
		execReqDto.setLgcCompId(reqDto.getLgcCompId());
		execReqDto.setLgcSql(query.toString());
		execReqDto.setDbInformId(reqDto.getDbInformId());

		StatusResDto resDto = executeQuery(execReqDto);
		if (resDto.getSuccess()) {
			resDto.setSuccess(true);
		} else {
			resDto.setMessage(Messages.getMessage("M01465", reqDto.getLang()));
		}

		return resDto;
	}

	 /*
	  * 1. 메소드명: getSegRptUsedList
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 8. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 상세 > 분석/세그먼트 적용 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.anl_seg_mst, anl.anl_rpt_mst
	 *   @return GridPagingResDto
	 */
	@SuppressWarnings("unchecked")
	public GridPagingResDto<KprLogicalComponentSegRptUsedResDto> getSegRptUsedList(KprLogicalComponentSegRptUsedListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("obj");
		return new GridPagingResHelper<KprLogicalComponentSegRptUsedResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), kprLogicalComponentMapper.selectSegRptUsedList(reqDto));
	}

	 /*
	  * 1. 메소드명: getLgcCompGrpColMstList
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 이기오
	  * 4. 작성일자: 2018. 4. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public List<KprLogicalComponentGroupColumnResDto> getLgcCompGrpColMstList(KprLogicalComponentGroupColumnReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return this.kprLogicalComponentMapper.selectLgcCompGrpColMstList(reqDto);
	}

	 /*
	  * 1. 메소드명: selectLogicalComponentSqlQuery
	  * 2. 클래스명: KPRLogicalComponentService
	  * 3. 작성자명: 예준호
	  * 4. 작성일자: 2016. 8. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 쿼리 생성
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @table : anl.procLgcsqlGen
	 *   @return KPRLogicalComponentResponseDTO
	 */
	public KprLogicalComponentResDto selectLogicalComponentSqlQuery(KprLogicalComponentReqDto reqDto){

		reqDto.setSVCAlias("");
		LogUtil.param(this.getClass(), reqDto);


		HashMap<String, String> reqMap = new HashMap<>();
		reqMap.put("lgcCompId", reqDto.getLgcCompId());
		reqMap.put("lang", reqDto.getLang());
		// 2016. 11. 03. 이기오 - Account ID 파라메터 추가
		reqMap.put("accntId", reqDto.getAccountId());
		reqMap.put("lgcSql", "");

		kprLogicalComponentMapper.selectLogicalComponentSqlQuery(reqMap);

		KprLogicalComponentResDto resDto = new KprLogicalComponentResDto();
		resDto.setLgcCompId(reqDto.getLgcCompId());
		resDto.setLgcSql(reqMap.get("lgcSql").toString());

		return resDto;

	}

}