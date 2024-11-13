package com.icignal.kepler.targetGroup.targetImport.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.request.GridPagingReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.AddBatchService;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.PersonalDataUtil;
import com.icignal.common.util.SecurityUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprSetTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupColumnListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupDBInfoReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupItemListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupItemReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupListReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.request.KprTargetGroupReqDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupColumnListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupDBInfoResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupItemListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupListResDto;
import com.icignal.kepler.targetGroup.targetGroup.dto.response.KprTargetGroupResDto;
import com.icignal.kepler.targetGroup.targetGroup.service.KprTargetGroupService;
import com.icignal.kepler.targetGroup.targetImport.mapper.KprTargetImportMapper;
import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.commcode.service.SystemCommCodeService;

/**
 * @name : infavor.kepler.targetGroup.service.impl
 * @date : 2019. 11. 11.
 * @author : dg.ryu
 * @description : 타겟 임포트
 */
@Service
public class KprTargetImportService {

    @Autowired
    private KprTargetImportMapper kprTargetImportMapper;
    
    @Autowired
    private CommonService commonService;
    
    @Autowired
    private AddBatchService addBatchService;
    
    @Autowired
    private KprTargetGroupService kprTargetGroupService;
    
    @Autowired
    private SystemCommCodeService systemCommCodeService;
    
    @Autowired
    private MKTCallQueryDao mktCallQueryDao;
    
	@Autowired
	LoggingHelper loggingService;
    
    
    /**
     * @programId :
     * @name : getTargetGroupDetail
     * @date : 2019. 11. 11.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 상세 조회
     */
    public KprTargetGroupResDto getTargetGroupDetail(KprTargetGroupReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);

        return kprTargetImportMapper.selectTargetGroupDetail(reqDto);
    }
    
    /**
     * @programId :
     * @name : saveTargetGroupImport
     * @date : 2019. 11. 11.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 저장
     */
    public StatusResDto saveTargetGroup(KprSetTargetGroupReqDto reqDto) {
    	LogUtil.param(this.getClass(), reqDto);
    	
    	StatusResDto rtnValue = new StatusResDto(false, "");
    	
    	if (ObjectUtil.isEmpty(reqDto.getTargetGroupId())) {
    		String id = commonService.getRowID();
    		reqDto.setTargetGroupId(id);
    		reqDto.setType("IMP");
    		
    		kprTargetImportMapper.insertTargetGroup(reqDto);
    	} else {
    		kprTargetImportMapper.updateTargetGroup(reqDto);
    	}
    	   	
    	rtnValue.setSuccess(true);
    	rtnValue.setMessage(reqDto.getTargetGroupId());
    	
    	return rtnValue;
    }
    
    /**
     * @programId :
     * @name : addTargetGroupItem
     * @date : 2019. 11. 11.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 아이템 등록
     */
    public StatusResDto addTargetGroupItem(KprTargetGroupItemReqDto reqDto) {
    	LogUtil.param(this.getClass(), "");
    	
    	        
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(false);
        
        try {
			        if (ObjectUtil.isNotEmpty(reqDto.getItemList())) {
				        // 타겟그룹 아이템 등록
				        StringBuffer sql = new StringBuffer();
				        sql.append(" insert into anl.anl_tgt_group_item")
					        .append(" (")
					        .append(" id, ")
					        .append(" create_by, ")
					        .append(" modify_by, ")
					        .append(" create_date, ")
					        .append(" modify_date, ")
					        .append(" flag, ")
					        .append(" tgt_group_id, ")
					    	.append(" mem_id, ")
					    	.append(" attrib01, ")
					    	.append(" attrib02, ")
					    	.append(" attrib03, ")
					    	.append(" attrib04, ")
					    	.append(" attrib05, ")
					    	.append(" seq ")
					    	.append(" ) values ( ")
					    	.append(" ? ")
					    	.append(" , ? ")
					    	.append(" , ? ")
					    	.append(" , getdate() ")
					    	.append(" , getdate() ")
					    	.append(" , 1 ")
					    	.append(" , ? ")
					    	.append(" , ? ")
					    	.append(" , ? ")
					    	.append(" , ? ")
					    	.append(" , ? ")
					    	.append(" , ? ")
					    	.append(" , ? ")
					    	.append(" , ? ")
					    	.append(" ) ");
				    	
				    	List<Map<Integer, Object>> params = new ArrayList<Map<Integer, Object>>();
				    	
				    	String dataKey = BeansUtil.getDbEncryptDataKey();
				    	
				    	int itemSeq = 1;
				        for (KprTargetGroupItemReqDto item : reqDto.getItemList()) {
					    	int sIdx = 1;
							Map<Integer, Object> param = new HashMap<Integer, Object>();
							param.put(sIdx++, UUID.randomUUID().toString().replace("-",""));
							param.put(sIdx++, reqDto.getCreateBy());
							param.put(sIdx++, reqDto.getModifyBy());
							param.put(sIdx++, reqDto.getTargetGroupId());
							
							if(StringUtil.isEmpty(item.getMemId())) {
								throw new Exception();
							}
							
							param.put(sIdx++, item.getMemId());
							String attr1 = item.getAttrib01();
							String attr2 = item.getAttrib02();
							String attr3 = item.getAttrib03();
							
							
							param.put(sIdx++, attr1); //고객명
							param.put(sIdx++, attr2); //전화번호
							param.put(sIdx++, attr3); //이메일
							param.put(sIdx++, item.getAttrib04());
							param.put(sIdx++, item.getAttrib05());
							param.put(sIdx++, itemSeq++);
							
							params.add(param);
				        }
				        
				        // 타겟그룹 아이템 삭제
				        kprTargetImportMapper.deleteTargetGroupItemByTargetGroupId(reqDto);
				        
				        addBatchService.addBatch(sql.toString(), params);
				        
				        // 대상자수 업데이트
				        KprSetTargetGroupReqDto setReqDto = new KprSetTargetGroupReqDto();
				        setReqDto.setSystemColumn(reqDto.getSystemColumn());
				        setReqDto.setTargetGroupId(reqDto.getTargetGroupId());
				        setReqDto.setCnt(reqDto.getItemList().size());
				        setReqDto.setImpFileNm(reqDto.getFileName());
				        
				        kprTargetImportMapper.updateTagetGroupCount(setReqDto);
				        
				        rtnValue.setMessage(Integer.toString(reqDto.getItemList().size()));
				        rtnValue.setSuccess(true);
			        }
        } catch (Exception e) {
	        rtnValue.setSuccess(false);
	        rtnValue.setMessage("정상적으로 처리되지 않았습니다. 엑셀 파일을 확인해주세요.");
		}

        return rtnValue;
    }
    
    /**
     * @programId :
     * @name : getTargetGroupColumnList
     * @date : 2019. 11. 11.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 컬럼 목록 조회
     */
    
    public List<KprTargetGroupColumnListResDto> getTargetGroupColumnList(KprTargetGroupColumnListReqDto tgclr) {
        LogUtil.param(KprTargetGroupService.class, tgclr);
        
        List<KprTargetGroupColumnListResDto> rtnValue = new ArrayList<KprTargetGroupColumnListResDto>();
        
        // 기본 컬럼 설정
        String[] persnalValColNames = {"사용자ID", "이름", "휴대전화", "이메일"};
        String[] persnalValColModel = {"memId", "attrib01", "attrib02", "attrib03"};
    	//String[] persnalValColNames = { "회원번호" };
        //String[] persnalValColModel = { "memId" };

        for (int i = 0; i < persnalValColModel.length; i++) {
        	KprTargetGroupColumnListResDto col = new KprTargetGroupColumnListResDto();
        	col.setDisplayName(persnalValColNames[i]);
        	col.setColumnName(persnalValColModel[i]);
        	col.setAliasColumnName(persnalValColModel[i]);
        	
        	rtnValue.add(col);
        }
        
        // 타겟그룹 컬럼 조회
        List<KprTargetGroupColumnListResDto> colList = kprTargetGroupService.getTargetGroupColumnList(tgclr);
        
        if (ObjectUtil.isNotEmpty(colList)) {
        	rtnValue.addAll(colList);
        }

        return rtnValue;
    }
    
    /**
     * @programId :
     * @name : getTargetGroupTargetList
     * @date : 2019. 11. 11.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 대상자 목록 조회
     */
    public GridPagingResDto getTargetGroupTargetList(KprTargetGroupItemListReqDto reqDto) {
        LogUtil.param(KprTargetGroupService.class, reqDto);

        ((GridPagingReqDto) reqDto).init(CommonUtil.getInstance().getDBType());

        GridPagingResDto rtnValue = new GridPagingResDto();
        
        String dataKey = BeansUtil.getDbEncryptDataKey();
        
        List<LinkedHashMap<String, Object>> rtnList = new ArrayList<LinkedHashMap<String, Object>>();
        
        
        List<KprTargetGroupItemListResDto> itemList = new ArrayList<KprTargetGroupItemListResDto>(); 
        
        if ("EXCEL".equals(reqDto.getGridType())) {
        	itemList = kprTargetImportMapper.selectAllTargetGroupItemList(reqDto);
        } else {
        	itemList = kprTargetImportMapper.selectTargetGroupItemList(reqDto);
        }

        if (ObjectUtil.isNotEmpty(itemList) && itemList.size() > 0) {
        	String lgcCompId = "";

            // 공통코드 테이블에서 회원정보 공통LC RID 조회
            MKTCommonCodeRequestDTO commCodeReq = new MKTCommonCodeRequestDTO();
            commCodeReq.setGroupCode("TGT_MBR_BASIC_LC");
            GridPagingResDto commCodeGrid = systemCommCodeService.getCommCodeList(commCodeReq);
            if (ObjectUtil.isNotEmpty(commCodeGrid.getRows())) {
                List<Object> mccr = commCodeGrid.getRows();

                for (Object obj : mccr) {
                	MKTCommonCodeResponseDTO mccgrd = (MKTCommonCodeResponseDTO) obj;
                    lgcCompId = mccgrd.getAttrib02();
                }
            }
            
            KprTargetGroupDBInfoReqDto tgdir = new KprTargetGroupDBInfoReqDto();
            tgdir.setSystemColumn(reqDto.getSystemColumn());
            tgdir.setLgcCompId(lgcCompId);
            
            //LC DB 정보 조회
            KprTargetGroupDBInfoResDto lcDBInfo = kprTargetGroupService.getTargetGroupLcDBInfo(tgdir);
            
            if (ObjectUtil.isNotEmpty(lcDBInfo)) {
	
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
	            query.append(lcDBInfo.getLgcSql().replaceFirst("SELECT", "SELECT " + lcDBInfo.getSegKeyCol() + " AS segKeyCol, " ))
	            	 .append(" where " + lcDBInfo.getSegKeyCol() + " in ");
	
	            int idx = 1;
				int size = itemList.size();
				String inStr = "";
				
	            List<KprTargetGroupItemListResDto> setItemList = new ArrayList<KprTargetGroupItemListResDto>();
	            
	            
	            for (KprTargetGroupItemListResDto item : itemList) {
	            	setItemList.add(item);
	            	
					//in 절 값 생성
					if (idx % 1000 == 0 || idx == size) {
						inStr += "'" + item.getMemId() + "'";
					} else {
						inStr += "'" + item.getMemId() + "',";
					}
					
					//1000단위로 나누어 실행 또는 마지막
					if (idx % 1000 == 0 || idx == size) {
						String sql = query.toString() + "(" + inStr + ")";
						
						//쿼리 실행
						List<LinkedHashMap<String, Object>> lcList = mktCallQueryDao.callSelectForListMap("getTargetGroupTargetList", sql, new ArrayList<>(), reqDbInfoDto);
					
						//결과를 대상자 매핑 처리
						for(KprTargetGroupItemListResDto setItem : setItemList) {
							
							LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
							map.put("memId", setItem.getMemId());

			                String attr1 = setItem.getAttrib01();
			                String attr2 = setItem.getAttrib02();
			                String attr3 = setItem.getAttrib03();
							
							
							if(!reqDto.getExcelFlag()) {
								map.put("attrib01", PersonalDataUtil.maskedCustNm(attr1));
								map.put("attrib02", PersonalDataUtil.maskedTelephone(attr2));
								map.put("attrib03", PersonalDataUtil.maskedEmail(attr3));
							}else {
								map.put("attrib01", attr1);
								map.put("attrib02", attr2);
								map.put("attrib03", attr3);
							}


							for (LinkedHashMap<String, Object> lc : lcList) {
								String segKeyColVal = (String) lc.get("segKeyCol");
								String memId = setItem.getMemId();

								if (memId.equals(segKeyColVal)) {
									map.putAll(lc);

									break;
								}
							}

							rtnList.add(map);
						}
						
						//대상자 List 초기화
						setItemList = new ArrayList<KprTargetGroupItemListResDto>();
						
						//in str 초기화
						inStr = "";
					}
					
					idx++;
	            }
            } else {
            	
            
				// LC가 없을 경우 결과를 대상자 매핑 처리
				for(KprTargetGroupItemListResDto setItem : itemList) {
	            	LinkedHashMap<String, Object> map = new LinkedHashMap<String, Object>();
	            	map.put("memId", setItem.getMemId());
	            	//복호화, 마스킹
                    String attr1 = SecurityUtil.decodeDbAES256(dataKey, setItem.getAttrib01());
                    String attr2 = SecurityUtil.decodeDbAES256(dataKey, setItem.getAttrib02());
                    String attr3 = SecurityUtil.decodeDbAES256(dataKey, setItem.getAttrib03());
                    
                	if(!reqDto.getExcelFlag()) {
						map.put("attrib01", PersonalDataUtil.maskedCustNm(attr1));
						map.put("attrib02", PersonalDataUtil.maskedTelephone(attr2));
						map.put("attrib03", PersonalDataUtil.maskedEmail(attr3));
					}else {
						map.put("attrib01", attr1);
						map.put("attrib02", attr2);
						map.put("attrib03", attr3);
					}
	            	rtnList.add(map);
				}
            }
            
            rtnValue = ObjectUtil.ConvertListToGrid(reqDto, rtnList, itemList.get(0).getTotalCount(), "");
        }
        
        return rtnValue;
    }
    
    /**
     * @programId :
     * @name : selectTargetGroupItemList
     * @date : 2019. 11. 11.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 아이템 목록 조회
     */
    @SuppressWarnings("unchecked")
    
    public List<KprTargetGroupItemListResDto> selectTargetGroupItemList(KprTargetGroupItemListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        
        return kprTargetImportMapper.selectTargetGroupItemList(reqDto);
    }
	//워크플로우 조건추출 목록 조회
    public GridPagingResDto<KprTargetGroupListResDto> selectImportList(KprTargetGroupListReqDto tglr) {
        LogUtil.param(this.getClass(), tglr);
        tglr.setSVCAlias("tg");
         
        return new GridPagingResHelper<KprTargetGroupListResDto>().newGridPagingResDto(
        				 tglr.init(CommonUtil.getInstance().getDBType()),
        				 kprTargetImportMapper.selectImportList(tglr));
    }

    
    
    /**
     * @programId : ANL_TGT_002
     * @name : clearMaskImportTgtList
     * @date : 2021. 02. 03.
     * @author : yj.choi
     * @table :
     * @return :
     * @description : 마스킹 해제 
     */
	public KprTargetGroupItemListResDto clearMaskImportTgtList(KprTargetGroupItemListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		KprTargetGroupItemListResDto resDto = kprTargetImportMapper.clearMaskImportTgtList(reqDto);
		
		return new AnnotationHelper<KprTargetGroupItemListResDto>(AnnotationType.PersonalData,resDto).getItem();
		}

 
}
