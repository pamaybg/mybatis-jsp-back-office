package com.icignal.loyalty.operationpolicymgt.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.common.dto.request.LoyCommonReqDto;
import com.icignal.loyalty.operationpolicymgt.dto.request.OperationPolicyDetailReqDto;
import com.icignal.loyalty.operationpolicymgt.dto.request.OperationPolicyReqDto;
import com.icignal.loyalty.operationpolicymgt.dto.response.OperationPolicyDetailResDto;
import com.icignal.loyalty.operationpolicymgt.dto.response.OperationPolicyResDto;
import com.icignal.loyalty.operationpolicymgt.mapper.OperationPolicyMgtMapper;
import com.icignal.loyalty.product.dto.response.LoyPgmListResDto;

@Service
public class OperationPolicyMgtService {

	@Autowired
	private OperationPolicyMgtMapper operationPolicyMgtMapper;
	
	
	 /*
	  * 1. 메소드명: getOperationPolicyList
	  * 2. 클래스명: OperationPolicyMgtService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2020.12.18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *  : 운영정책들을 조회하는 메소드
	 *   - DB의 테이블 LOY.LOY_OPR_PLCY 안에 있는 운영정책 내용들을 조회해 리스트로 가져온다.
	 *   
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  opDto
	 *   @return resDto
	 */
	public GridPagingResDto<OperationPolicyResDto> getOperationPolicyList(OperationPolicyReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		
		GridPagingResDto<OperationPolicyResDto> resDto = new GridPagingResDto<OperationPolicyResDto>();
		resDto = new GridPagingResHelper<OperationPolicyResDto>().newGridPagingResDto(
				opDto.init(CommonUtil.getInstance().getDBType()),
				operationPolicyMgtMapper.getOperationPolicyList(opDto), AnnotationType.CommCode);

		return resDto;
	}
	

	 /*
	  * 1. 메소드명: getOperationPolicyDetailList
	  * 2. 클래스명: OperationPolicyMgtService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2020.12.18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *  : 운영정책들의 상세를 조회하는 메소드
	 *   - DB의 테이블 LOY.LOY_OPR_PLCY_DTL 안에 있는 운영정책 상세내용들을 조회해 리스트로 가져온다.
	 *   
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  opdDto
	 *   @return resDto
	 */
	public GridPagingResDto<OperationPolicyDetailResDto> getOperationPolicyDetail1(OperationPolicyDetailReqDto opdDto) {
		LogUtil.param(this.getClass(), opdDto);
		/*
		String testStr = operationPolicyMgtMapper.getOperationPolicyDetail1(opdDto).get(0).getDataValMarkNm();
		System.out.println("testStr: "+testStr);
		*/
		GridPagingResDto<OperationPolicyDetailResDto> resDto = new GridPagingResDto<OperationPolicyDetailResDto>();
		resDto = new GridPagingResHelper<OperationPolicyDetailResDto>().newGridPagingResDto(
				opdDto.init(CommonUtil.getInstance().getDBType()),
				operationPolicyMgtMapper.getOperationPolicyDetail1(opdDto), AnnotationType.CommCode);
		
		return resDto;
	}
	
	public GridPagingResDto<OperationPolicyDetailResDto> getOperationPolicyDetail2(OperationPolicyDetailReqDto opdDto) {
		LogUtil.param(this.getClass(), opdDto);
		
		GridPagingResDto<OperationPolicyDetailResDto> resDto = new GridPagingResDto<OperationPolicyDetailResDto>();
		resDto = new GridPagingResHelper<OperationPolicyDetailResDto>().newGridPagingResDto(
				opdDto.init(CommonUtil.getInstance().getDBType()),
				operationPolicyMgtMapper.getOperationPolicyDetail2(opdDto), AnnotationType.CommCode);
		
		return resDto;
	}
	
	
	// 운영정책 항목 추가
	public StatusResDto addOperationPolicy(OperationPolicyReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		// rid로 들어가게 될 rid값을 랜덤으로 생성
		String rid = CommonUtil.newRid();
		opDto.setRid(rid); // opDto 에 rid 초기화
		// 상태 객체 생성
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		operationPolicyMgtMapper.addOperationPolicy(opDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	// 운영정책 항목 수정
	public StatusResDto updateOperationPolicy(OperationPolicyReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		// 상태 객체 생성
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		operationPolicyMgtMapper.updateOperationPolicy(opDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	// 수정 클릭 시 수정할 데이터 로드
	public OperationPolicyResDto getOperationPolicyPop(OperationPolicyReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);

		OperationPolicyResDto rtnValue = operationPolicyMgtMapper.getOperationPolicyPop(opDto);
		
		return rtnValue;
	}
	
	
	// 운영정책 항목 삭제
	public StatusResDto deleteOperationPolicy(OperationPolicyReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		// 상태 객체 생성
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		operationPolicyMgtMapper.deleteOperationPolicy(opDto);
		int DtlCount = operationPolicyMgtMapper.checkOperationPolicyDtl(opDto);
		if(DtlCount > 0) {
			operationPolicyMgtMapper.deleteOperationPolicyDtl(opDto);
		}
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: getOprDtlHist
	  * 2. 클래스명: OperationPolicyMgtService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 12. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param opdDto
	 *   @return	
	 */
	
	public GridPagingResDto<OperationPolicyDetailResDto> getOprDtlHist(OperationPolicyDetailReqDto opdDto) {
		LogUtil.param(this.getClass(), opdDto);
		
		GridPagingResDto<OperationPolicyDetailResDto> resDto = new GridPagingResDto<OperationPolicyDetailResDto>();
		resDto = new GridPagingResHelper<OperationPolicyDetailResDto>().newGridPagingResDto(
				opdDto.init(CommonUtil.getInstance().getDBType()),
				operationPolicyMgtMapper.selectOprDtlHist(opdDto), AnnotationType.CommCode);
		
		return resDto;
	}
	
	
	/*
	  * 1. 메소드명: addOperationPolicyDetail
	  * 2. 클래스명: OperationPolicyMgtService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2020.12.29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *  : 정책속성값 데이터 / 세부사항 데이터 insert 메소드
         + LOY.LOY_OPR_PLCY_DTL 테이블에 매 데이터 insert가 있을 시,
                        해당 처리건에 대한 history데이터를 LOY.LOY_OPR_PLCY_DTL_HIST에 저장 
	 * </PRE>
	 *   @param  opDto
	 *   @return rtnValue
	 */
	public StatusResDto addOperationPolicyDetail(OperationPolicyDetailReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		// rid로 들어가게 될 rid값을 랜덤으로 생성
		String rid = CommonUtil.newRid();
		opDto.setRid(rid); // opDto 에 rid 초기화
		// 상태 객체 생성
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		// 해당 insert 처리건 시작
		operationPolicyMgtMapper.addOperationPolicyDetail(opDto);
		// 히스토리 저장을 위해 기존 rid값은 rid_opr_dtl 쪽으로 옮겨주고, 히스토리 용 rid를 새로 만들어 초기화한다
		opDto.setOprDtlRid(opDto.getRid());
		opDto.setRid(CommonUtil.newRid());
		operationPolicyMgtMapper.addOperationPolicyDetailHist(opDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}//end addOperationPolicyDetail
	
	
	// 정책속성값 항목 수정 클릭 시 기존데이터 불러와 화면에 뿌리는 메소드
	public OperationPolicyDetailResDto getOprPlcyDetailBeforeUpdate(OperationPolicyDetailReqDto opdDto) {
		LogUtil.param(this.getClass(), opdDto);
		OperationPolicyDetailResDto resDto = new OperationPolicyDetailResDto();
		resDto = operationPolicyMgtMapper.getOprPlcyDetailBeforeUpdate(opdDto);
		
		return resDto;
	}
	
	// 운영정책 항목 수정
	public StatusResDto updateOperationPolicyDetail(OperationPolicyDetailReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		// 상태 객체 생성
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		// 해당 update 처리건 시작
		operationPolicyMgtMapper.updateOperationPolicyDetail(opDto);
		// 히스토리 저장을 위해 기존 rid값은 rid_opr_dtl 쪽으로 옮겨주고, 히스토리 용 rid를 새로 만들어 초기화한다
		opDto.setOprDtlRid(opDto.getRid());
		opDto.setRid(CommonUtil.newRid());
		operationPolicyMgtMapper.addOperationPolicyDetailHist(opDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}// end updateOperationPolicyDetail
	
	
	// 정책속성값 항목 삭제 / 또는 세부속성 항목 삭제(논리삭졔)
	public StatusResDto deleteOperationPolicyDetail(OperationPolicyDetailReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		// 상태 객체 생성
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		operationPolicyMgtMapper.deleteOperationPolicyDetail(opDto);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: checkAttrCdSingleValYnForInsert
	  * 2. 클래스명: OperationPolicyMgtService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021.01.06
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *  : 운영정책관리 - 정책속성값그리드/세부사항그리드의 신규팝업에서 네용 저장 시에 사용
	 *   [신규추가] 
	 *    넣어주려는 데이터가 LOY_OPR_PLCY_DTL테이블 안에서 "해당 속성명이 단일값상태로 존재하는게 있는지 미리 체크함으로써, 단일값 속성에 위배될지 미리 알려준다"
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param  opDto
	 *   @return rtnValue
	 */
	public StatusResDto checkAttrCdSingleValYnForInsert(OperationPolicyDetailReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);

		StatusResDto rtnValue = new StatusResDto();
		int countSameAttrCd;     // 동일한 ATTR_CD 존재 여부
		int countSameAttrCdYes;  // 동일한 ATTR_CD를 지닌 데이터들 중 SINGLE_VAL_YN가 "Y"인 것의 존재여부
		
		// ***신규 insert 시, 단일값여부 검사 로직*** 
		countSameAttrCd = operationPolicyMgtMapper.countSameAttrCd(opDto);
		//(1) 동일한 attrCd값이 있는가?
		if(countSameAttrCd == 0) {  // 동일한 attrCd가 없는 상태인 경우 => 바로 저장가능
			rtnValue.setSuccess(true);
		} else { // 동일한 attrCd가 존재하고 있다
			countSameAttrCdYes = operationPolicyMgtMapper.countSameAttrCdYes(opDto);
			//(2)동일한 attrCd값이 있다면 그 중  Y인 것이 있는가?
			if(countSameAttrCdYes == 0) { // Y인 것이 없다 
				String myYesFlag = opDto.getSingleValYn();
				//(3)insert할 데이터의 단일값여부가 Y인가? 
				if(myYesFlag.equals("Y")) { // Y이다 => 추가 저장 불가(단일값속성 규칙 위배)
					rtnValue.setSuccess(false);
					rtnValue.setMessage("[단일값 규칙 위배] 해당 속성은 이미 기존데이터 안에 존재하고 있기 때문애, 단일값 설정으로서 신규추가할 수 없습니다.");
				} else { // "N"이다 => 추가 저장 가능
					rtnValue.setSuccess(true);
				}//end (3)
				
			} else { // Y인 것이 있다 => 추가 불가
				rtnValue.setSuccess(false);
				rtnValue.setMessage("[단일값 규칙 위배] 해당 속성은 이미 기존데이터 상에 단일값속성으로 존재하고 있어, 신규추가할 수 없습니다.");
			}//end (2)
		}//end (1)
		
		return rtnValue;
	}//end checkAttrCdSingleValYnForInsert
	
	/*
	  * 1. 메소드명: checkAttrCdSingleValYnForUpdate
	  * 2. 클래스명: OperationPolicyMgtService
	  * 3. 작성자명: jb.kim
	  * 4. 작성일자: 2021.01.06
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *  : 운영정책관리 - 정책속성값그리드/세부사항그리드의 수정팝업에서 수정내용 저장 시에 사용
	 *   [수정 처리] 
	 *    수정 처리 시 넣어주려는 데이터가 LOY_OPR_PLCY_DTL테이블 안에서 "해당 속성명이 단일값 상태로 존재하는게 있는지 미리 체크함으로써, 단일값 속성에 위배될지 미리 알려준다"
	 * </PRE>
	 *   @param  opDto
	 *   @return rtnValue
	 */
	public StatusResDto checkAttrCdSingleValYnForUpdate(OperationPolicyDetailReqDto opDto) {
		LogUtil.param(this.getClass(), opDto);
		StatusResDto rtnValue = new StatusResDto();
		int countSameAttrCd;     // 동일한 ATTR_CD 존재 여부
		int countSameAttrCdYes;  // 동일한 ATTR_CD를 지닌 데이터들 중 SINGLE_VAL_YN가 "Y"인 것의 존재여부
		String myRid;
		String theRecordRid;
			
		// ***수정 update 시, 단일값여부 검사 로직*** 
		countSameAttrCd = operationPolicyMgtMapper.countSameAttrCd(opDto);
		//(1) 동일한 attrCd값이 있는가?
		if(countSameAttrCd == 0) {  // 동일한 attrCd가 없는 상태인 경우
			// => 수정 저장 가능
			rtnValue.setSuccess(true);
		} else { // 동일한 attrCd가 존재하고 있다 (속성값이 동일한 데이터 갯수가 1개이상)
			countSameAttrCdYes = operationPolicyMgtMapper.countSameAttrCdYes(opDto);
			//(2)동일한 attrCd값이 있다면 그 중  Y인 것이 있는가?
			if(countSameAttrCdYes != 0) { // 단일값여부가 Y인 것이 존재함. (Y이므로 있다면 무조건 1개만 있는 상태일것)
				myRid = opDto.getRid();
				theRecordRid = operationPolicyMgtMapper.getTheRecordRid(opDto);
				// 1개면 혹시 그 데이터가 나 자신인가?
				if(theRecordRid.equals(myRid)) { // 동일한 레코드였을 경우
					// 수정 ok
					rtnValue.setSuccess(true);
				} else { // 동일한 레코드 아님
					// 수정불가
					rtnValue.setSuccess(false);
					rtnValue.setMessage("[단일값 규칙 위배] 해당 속성은 이미 기존 데이터 상에 단일값속성으로 존재하고 있습니다.");
				}
			} else { // 단일값여부가 Y인 것이 없는 경우 (전부 'N이란 것)
				// 혹시 그 record값이 1개인가?
				if(countSameAttrCd == 1) { // 레코드가 한개일 경우
					String myYesFlag = opDto.getSingleValYn();
					// 나 자신의 단일여부가 Y인가?
					if(myYesFlag.equals("Y")) { // 내 단일여부가 Yes일 경우
						// 그게 나 자신인 건지 확인해본다
						myRid = opDto.getRid();
						theRecordRid = operationPolicyMgtMapper.getTheRecordRid(opDto);
						// 1개면 혹시 그 데이터가 나자신인가?
						if(theRecordRid.equals(myRid)) { // 동일하다.
							// 수정가능
							rtnValue.setSuccess(true);
						} else { // 동일한 것이 아니다.
							//수정불가						
							rtnValue.setSuccess(false);
							rtnValue.setMessage("[단일값 규칙 위배] 해당 속성으로 기존 데이터 상에 레코드가 이미 존재하고 있습니다.");
						}
						
					} else { // 나 자신의 단일여부가 N일 경우
						// 수정ok
						rtnValue.setSuccess(true);
					}
				} else { // 레코드가 여러 개 일 경우
					String myYesFlag = opDto.getSingleValYn();
					// 나 자신의 단일여부가 Y인가?
					if(myYesFlag.equals("Y")) {
						//수정불가						
						rtnValue.setSuccess(false);
						rtnValue.setMessage("[단일값 규칙 위배] 해당 속성으로 기존 데이터 상에 레코드가 이미 여러개 존재하고 있습니다.");
					} else { // 나 자신의 단일여부가 N이었다
						// 수정ok
						rtnValue.setSuccess(true);
					}
				}
			}
		}//end if
		
		return rtnValue;
	}//end checkAttrCdSingleValYnForUpdate
	
	
	
	
}//end Class OperationPolicyMgtService
	
