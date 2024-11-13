package com.icignal.kepler.logicalComponent.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.kepler.analysis.common.util.KprAnalysisConstants;
import com.icignal.kepler.logicalComponent.dto.request.KprLogicalComponentEngineDetailReqDto;
import com.icignal.kepler.logicalComponent.dto.response.KprLogicalComponentEngineDetailResDto;
import com.icignal.kepler.logicalComponent.mapper.KprLogicalComponentEngineMapper;

/*
 * 1. 클래스명	: KPRLogicalComponentEngineService
 * 2. 파일명	: KPRLogicalComponentEngineService.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.service
 * 4. 작성자명	: 이기오
 * 5. 작성일자	: 2018. 4. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service("KprLogicalComponentEngineService")
public class KprLogicalComponentEngineService {

	@Autowired
	private KprLogicalComponentEngineMapper kprLogicalComponentEngineMapper;

	 /*
	  * 1. 메소드명: getLogicalComponentSQL
	  * 2. 클래스명: KPRLogicalComponentEngineService
	  * 3. 작성자명: 이기오
	  * 4. 작성일자: 2018. 4. 11.  
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 쿼리 생성
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public String getLogicalComponentSQL(KprLogicalComponentEngineDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		List<String> tblRelTmpList = new ArrayList<String>();
		StringBuilder sbLgcCompSQL = new StringBuilder();
		StringBuilder sbLgcCompColSQL = new StringBuilder("SELECT ");
		StringBuilder sbLgcCompFromSQL = new StringBuilder("FROM ");

		boolean apdColFlag = reqDto.getApdColFlag();
		if (apdColFlag) {
			List<KprLogicalComponentEngineDetailResDto> lgcCompColList = kprLogicalComponentEngineMapper.selectLgcCompColList(reqDto);
			if (ObjectUtil.isNotEmpty(lgcCompColList)) {

				boolean commaFlag = false;

				for (KprLogicalComponentEngineDetailResDto lgcCompColDtl : lgcCompColList) {
					if (commaFlag) {
						sbLgcCompColSQL.append(", ");
					} else {
						commaFlag = true;
					}

					sbLgcCompColSQL.append(lgcCompColDtl.getTblAliasColNm() + "\n");
				}
			} else {
				sbLgcCompColSQL.append("count(*) as cnt ");
			}
		}

		boolean fromFlag = true;

		// 로지컬 컴포넌트 테이블 리스트 조회
		List<KprLogicalComponentEngineDetailResDto> lgcCompTblList = kprLogicalComponentEngineMapper.selectLgcCompTblList(reqDto);
		if (ObjectUtil.isNotEmpty(lgcCompTblList)) {
			// 테이블 개수가 1개 이상 이라면, 루프를 돌면서 쿼리를 생성한다.
			if (lgcCompTblList.size() > 1) {
				for (KprLogicalComponentEngineDetailResDto lgcCompTblDetail : lgcCompTblList) {
					// String tblId = lgcCompTblDetail.getTblId();
					String tblRelId = lgcCompTblDetail.getTblRelId();

					LogUtil.error("TABLE ID : " + tblRelId);

					// 테이블 ID가 임시 테이블 리스트에 존재하지 않는다면 실행
					if (!tblRelTmpList.contains(tblRelId)) {
						String leftPrevTblRelId = null;
						String rightPrevTblRelId = null;

						// 조인 컬럼 조회
						KprLogicalComponentEngineDetailReqDto tblJoinColumnListReqDto = new KprLogicalComponentEngineDetailReqDto();
						tblJoinColumnListReqDto.setTblRelId(tblRelId);
						tblJoinColumnListReqDto.setLang(reqDto.getLang());

						List<KprLogicalComponentEngineDetailResDto> lgcCompTblJoinColumnList = kprLogicalComponentEngineMapper.selectLgcCompTblJoinColList(tblJoinColumnListReqDto);
						
						if (ObjectUtil.isNotEmpty(lgcCompTblJoinColumnList)) {
							for (KprLogicalComponentEngineDetailResDto lgcCompJoinColumnDetail : lgcCompTblJoinColumnList) {
								String leftTblRelId = lgcCompJoinColumnDetail.getLeftTblRelId();
								// String leftTblId =
								// lgcCompJoinColumnDetail.getLeftTblId();

								String rightTblRelId = lgcCompJoinColumnDetail.getRightTblRelId();
								// String rightTblId =
								// lgcCompJoinColumnDetail.getRightTblId();

								Integer leftGroupCnt = lgcCompJoinColumnDetail.getLeftGroupCnt();
								Integer rightGroupCnt = lgcCompJoinColumnDetail.getRightGroupCnt();

								LogUtil.error("LEFT TABLE ID : " + leftTblRelId);
								LogUtil.error("RIGHT TABLE ID : " + rightTblRelId);

								// 현재 테이블 ID 와 조회 결과의 좌측 테이블 ID 와 같다면 실행
								if (tblRelId.equals(leftTblRelId)) {
									if (fromFlag) { 
										if(!tblRelTmpList.contains(leftTblRelId) && !leftTblRelId.equals(leftPrevTblRelId)) {
											if (!fromFlag) {
												sbLgcCompFromSQL.append("\n" + lgcCompJoinColumnDetail.getJoinTypeCode() + " JOIN ");
											}

											if (leftGroupCnt > 0) {
												KprLogicalComponentEngineDetailReqDto lgcCompGrpDetail = new KprLogicalComponentEngineDetailReqDto();
												lgcCompGrpDetail.setLang(reqDto.getLang());
												lgcCompGrpDetail.setSchmaTblNm(lgcCompJoinColumnDetail.getLeftSchmaTblNm());
												lgcCompGrpDetail.setTblRelId(leftTblRelId);
	
												sbLgcCompFromSQL.append("(\n");
												sbLgcCompFromSQL.append(this.getLgcCompGrpSQL(lgcCompGrpDetail) + "\n");
												sbLgcCompFromSQL.append(")");
											} else {
												sbLgcCompFromSQL.append(lgcCompJoinColumnDetail.getLeftSchmaTblNm());
											}

											sbLgcCompFromSQL.append(" " + lgcCompJoinColumnDetail.getLeftTblAlias());

											fromFlag = false;
										}
									}

									if (!tblRelTmpList.contains(rightTblRelId)) {
										sbLgcCompFromSQL.append("\n" + lgcCompJoinColumnDetail.getJoinTypeCode() + " JOIN ");

										if (rightGroupCnt > 0) {
											KprLogicalComponentEngineDetailReqDto lgcCompGrpDetail = new KprLogicalComponentEngineDetailReqDto();
											lgcCompGrpDetail.setLang(reqDto.getLang());
											lgcCompGrpDetail.setSchmaTblNm(lgcCompJoinColumnDetail.getRightSchmaTblNm());
											lgcCompGrpDetail.setTblRelId(rightTblRelId);

											sbLgcCompFromSQL.append("(\n");
											sbLgcCompFromSQL.append(this.getLgcCompGrpSQL(lgcCompGrpDetail) + "\n");
											sbLgcCompFromSQL.append(")");
										} else {
											sbLgcCompFromSQL.append(lgcCompJoinColumnDetail.getRightSchmaTblNm());
										}

										sbLgcCompFromSQL.append(" " + lgcCompJoinColumnDetail.getRightTblAlias());
									}

									if (ObjectUtil.isNotEmpty(rightPrevTblRelId) && rightTblRelId.equals(rightPrevTblRelId)) {
										sbLgcCompFromSQL.append("\n AND ");
									} else {
										sbLgcCompFromSQL.append(" ON ");
									}

									sbLgcCompFromSQL.append(lgcCompJoinColumnDetail.getLeftTblAliasColNm() + " " + lgcCompJoinColumnDetail.getJoinOprtCodeName() + " " + lgcCompJoinColumnDetail.getRightTblAliasColNm());

									tblRelTmpList.add(rightTblRelId);
								}

								if (tblRelId.equals(rightTblRelId)) {
									if (fromFlag || !tblRelTmpList.contains(rightTblRelId) && !rightTblRelId.equals(rightPrevTblRelId)) {
										if (!fromFlag) {
											sbLgcCompFromSQL.append("\n" + lgcCompJoinColumnDetail.getJoinTypeCode() + " JOIN ");
										}

										if (rightGroupCnt > 0) {
											KprLogicalComponentEngineDetailReqDto lgcCompGrpDetail = new KprLogicalComponentEngineDetailReqDto();
											lgcCompGrpDetail.setLang(reqDto.getLang());
											lgcCompGrpDetail.setSchmaTblNm(lgcCompJoinColumnDetail.getRightSchmaTblNm());
											lgcCompGrpDetail.setTblRelId(rightTblRelId);

											sbLgcCompFromSQL.append("(\n");
											sbLgcCompFromSQL.append(this.getLgcCompGrpSQL(lgcCompGrpDetail) + "\n");
											sbLgcCompFromSQL.append(")");
										} else {
											sbLgcCompFromSQL.append(lgcCompJoinColumnDetail.getRightSchmaTblNm());
										}

										sbLgcCompFromSQL.append(" " + lgcCompJoinColumnDetail.getRightTblAlias());

										fromFlag = false;
									}

									if (!tblRelTmpList.contains(leftTblRelId)) {
										sbLgcCompFromSQL.append("\n" + lgcCompJoinColumnDetail.getJoinTypeCode() + " JOIN ");

										if (leftGroupCnt > 0) {
											KprLogicalComponentEngineDetailReqDto lgcCompGrpDetail = new KprLogicalComponentEngineDetailReqDto();
											lgcCompGrpDetail.setLang(reqDto.getLang());
											lgcCompGrpDetail.setSchmaTblNm(lgcCompJoinColumnDetail.getLeftSchmaTblNm());
											lgcCompGrpDetail.setTblRelId(leftTblRelId);

											sbLgcCompFromSQL.append("(\n");
											sbLgcCompFromSQL.append(this.getLgcCompGrpSQL(lgcCompGrpDetail) + "\n");
											sbLgcCompFromSQL.append(")");
										} else {
											sbLgcCompFromSQL.append(lgcCompJoinColumnDetail.getLeftSchmaTblNm());
										}

										sbLgcCompFromSQL.append(" " + lgcCompJoinColumnDetail.getLeftTblAlias());
									}

									if (ObjectUtil.isNotEmpty(leftPrevTblRelId) && leftTblRelId.equals(leftPrevTblRelId)) {
										sbLgcCompFromSQL.append("\n AND ");
									} else {
										sbLgcCompFromSQL.append(" ON ");
									}

									sbLgcCompFromSQL.append(lgcCompJoinColumnDetail.getLeftTblAliasColNm() + " " + lgcCompJoinColumnDetail.getJoinOprtCodeName() + " " + lgcCompJoinColumnDetail.getRightTblAliasColNm());

									tblRelTmpList.add(leftTblRelId);
								}

								leftPrevTblRelId = leftTblRelId;
								rightPrevTblRelId = rightTblRelId;
							}
						}

						tblRelTmpList.add(tblRelId);
					}
				}
			} else {
				// 1개 라면 0번째 데이터를 꺼내와서 From 절 생성
				KprLogicalComponentEngineDetailResDto lgcCompTblDetail = lgcCompTblList.get(0);
				if (sbLgcCompColSQL.indexOf("AS") < 0) {
					sbLgcCompColSQL.append(" * ");
				}
				sbLgcCompFromSQL.append(lgcCompTblDetail.getSchmaTblNm() + " " + lgcCompTblDetail.getTblAlias());
			}
		}

		sbLgcCompSQL.append(sbLgcCompColSQL)
					.append(sbLgcCompFromSQL);

		return sbLgcCompSQL.toString();
	}

	 /*
	  * 1. 메소드명: getLgcCompGrpSQL
	  * 2. 클래스명: KPRLogicalComponentEngineService
	  * 3. 작성자명: 이기오
	  * 4. 작성일자: 2018. 4. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로지컬 컴포넌트 내, Group 처리 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	private String getLgcCompGrpSQL(KprLogicalComponentEngineDetailReqDto reqDto) {
		List<KprLogicalComponentEngineDetailResDto> lgcCompGrpColList = this.kprLogicalComponentEngineMapper.selectLgcCompGrpColList(reqDto);
		List<KprLogicalComponentEngineDetailResDto> lgcCompGrpByColList = this.kprLogicalComponentEngineMapper.selectLgcCompGrpByColList(reqDto);

		StringBuilder sbSelectSQL = new StringBuilder();
		StringBuilder sbGroupBySQL = new StringBuilder();

		if (ObjectUtil.isNotEmpty(lgcCompGrpByColList)) {
			for (KprLogicalComponentEngineDetailResDto lgcCompGrpByColDetail : lgcCompGrpByColList) {
				if (sbSelectSQL.length() == 0) {
					sbSelectSQL.append("SELECT ");
				} else {
					sbSelectSQL.append("     , ");
				}

				if (sbGroupBySQL.length() == 0) {
					sbGroupBySQL.append("GROUP BY ");
				} else {
					sbGroupBySQL.append("       , ");
				}

				sbSelectSQL.append(lgcCompGrpByColDetail.getColNm() + " AS " + lgcCompGrpByColDetail.getColNm() + "\n");
				sbGroupBySQL.append(lgcCompGrpByColDetail.getColNm() + "\n");
			}
		}

		if (ObjectUtil.isNotEmpty(lgcCompGrpColList)) {
			for (KprLogicalComponentEngineDetailResDto lgcCompGrpColDetail : lgcCompGrpColList) {
				if (sbSelectSQL.length() == 0) {
					sbSelectSQL.append("SELECT ");
				} else {
					sbSelectSQL.append("     , ");
				}

				sbSelectSQL.append(KprAnalysisConstants.convertGroupFunction(lgcCompGrpColDetail.getGrpFuncTypeCode(), lgcCompGrpColDetail.getColNm()) + " AS " + lgcCompGrpColDetail.getColNm() + "\n");
			}
		}

		StringBuilder sbRstSQL = new StringBuilder();
		sbRstSQL.append(sbSelectSQL.toString())
				.append("  FROM " + reqDto.getSchmaTblNm() + "\n")
				.append(sbGroupBySQL.toString());

		return sbRstSQL.toString();
	}
}