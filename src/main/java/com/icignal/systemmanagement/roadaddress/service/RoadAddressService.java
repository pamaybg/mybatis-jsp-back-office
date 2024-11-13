package com.icignal.systemmanagement.roadaddress.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.AddBatchService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.chnlgrp.dto.request.LoyChnlGrpListReqDto;
import com.icignal.loyalty.chnlgrp.mapper.LoyChnlGrpMapper;
import com.icignal.systemmanagement.responseinfo.dto.response.SystemResponseInfoResDto;
import com.icignal.systemmanagement.roadaddress.dto.request.RoadAddressReqDto;
import com.icignal.systemmanagement.roadaddress.dto.response.RoadAddressResDto;
import com.icignal.systemmanagement.roadaddress.mapper.RoadAddressMapper;

@Service
public class RoadAddressService {
	
	@Autowired
	private RoadAddressMapper roadAddressMapper;
	@Autowired
	private AddBatchService addBatchService;
	
	@Autowired
	@Resource(name="transactionManager-batch")
	private DataSourceTransactionManager transactionManager;
	
	

	 /*
	  * 1. 메소드명: getRoadAddressList
	  * 2. 클래스명: RoadAddressService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2020. 12. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *  : 도로명 주소 데이터 조회 메소드
	 *   - DB의 테이블 com.B_CODE안에 저장된 주소 내용을 리스트로 화면에 출력하기 위해 조회해온다.
	 *   
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  raDto
	 *   @return resDto
	 */
	public GridPagingResDto<RoadAddressResDto> getRoadAddressList(RoadAddressReqDto raDto) {
		LogUtil.param(this.getClass(), raDto);
		
		GridPagingResDto<RoadAddressResDto> resDto = new GridPagingResDto<RoadAddressResDto>();
		resDto = new GridPagingResHelper<RoadAddressResDto>().newGridPagingResDto(
				raDto.init(CommonUtil.getInstance().getDBType()),
				roadAddressMapper.getRoadAddressList(raDto), AnnotationType.CommCode);
	
		return resDto;  
	}
	
	
	
	 /*
	  * 1. 메소드명: insertRoadAddressList
	  * 2. 클래스명: RoadAddressService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2020. 12. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *  : '시스템 운영 - 도로명주소관리 - 주소 업로드 버튼 클릭' 시 업로드할 엑셀파일을 선택해 업로드하면, 엑셀 안의 데이터를 DB 테이블 com.B_CODE 안으로 저장한다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  raDto
	 *   @return rtnValue
	 */
	public StatusResDto insertRoadAddressList(RoadAddressReqDto raDto) {
		
		StatusResDto rtnValue = new StatusResDto(); // '상태응답객체 StatusResDto'
		rtnValue.setSuccess(false);
		List<RoadAddressReqDto> array = raDto.getArray(); // 파라미터 raDto안에서 내용들이 담겨있는 array객체를 가져온다
		
		StringBuffer truncateSql = new StringBuffer();// 스트링버퍼 생성
		StringBuffer insertSql = new StringBuffer();// 스트링버퍼 생성
				
		// DELETE sql문
		truncateSql.append("TRUNCATE TABLE COM.B_CODE");
				
		// INSERT sql문
		insertSql.append("INSERT INTO COM.B_CODE")
		.append("(")
		.append("  RID")
		.append(", SIDO")
		.append(", SIGUNGU")
		.append(", CODE_NM")
		.append(", CODE")
		.append(", DEL_FLAG")
		.append(", CREATE_BY")
		.append(", MODIFY_BY")
		.append(") VALUES (") 
		.append("  ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(")");
		
		
		// insert 작업 전 기존데이터 delete를 위한 deleteBeforeInsert() 를 호출
		addBatchService.truncateBeforeInsert(truncateSql.toString());
	
		
		int cntUpload = array.size(); // 배열에 반복돌려야 할 횟수 카운트 cntUpload
		int uploadcnt = 0; // 업로드건에 대한 카운트
		List<Map<Integer,Object>> params = new ArrayList<Map<Integer,Object>>(); // 가변배열 params 객체

		// insert sql을 위한 처리(데이터 매핑 및 초기화)
		for(RoadAddressReqDto arr : array) {
				int idx = 1;			
				Map<Integer,Object> param = new HashMap<Integer,Object>();
								
				param.put(idx++, StringUtil.convertNull(CommonUtil.newRid()));
				param.put(idx++, StringUtil.convertNull(arr.getSido(),""));
				param.put(idx++, StringUtil.convertNull(arr.getSigungu(),""));
				param.put(idx++, StringUtil.convertNull(arr.getCode_nm(),""));
				param.put(idx++, StringUtil.convertNull(arr.getCode(),""));
				param.put(idx++, StringUtil.convertNull(arr.getDel_flag(),""));
				param.put(idx++, StringUtil.convertNull(raDto.getCreateBy(),"")); // loginfo에 관한 데이터는 현재 raDto안에 담겨있으므로
				param.put(idx++, StringUtil.convertNull(raDto.getModifyBy(),""));
				params.add(param);
				uploadcnt++;
			}

		int duplCnt = cntUpload - uploadcnt;
		
		addBatchService.addBatch(insertSql.toString(), params);
		
		rtnValue.setSuccess(true);
		rtnValue.setMessage("총 : "+cntUpload+"건, 정상입력 : "+uploadcnt+", 중복제외 : "+duplCnt+"건");

		return rtnValue;
	}// end insertRoadAddressList
	

}
