package com.icignal.common.helper;



import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Optional;

import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.dao.DataAccessException;

import com.icignal.common.base.dto.request.GridPagingReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.DB_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.handler.AnnotationHandler;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.annotation.handler.CommCodeHandler;
import com.icignal.core.annotation.handler.PersonalDataHandler;
import com.icignal.core.annotation.personaldata.PersonalData;
import com.icignal.core.exception.DataSQLException;


public class GridPagingResHelper<T> {
		
	private final GridPagingResDto<T> gridPaging;
	
	public GridPagingResHelper (){
		  gridPaging = new GridPagingResDto<>();
	}



	 /*
	  * 1. 메소드명: newGridPagingResDto
	  * 2. 클래스명: GridPagingResHelper
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *  * 1. 설명 : GridPagingResDto를 반환한다.
	 *	
	 * 2. 사용법
	 *    서비스 객체서어 사용함.
	 *   ex)   new GridPagingResHelper<LoyMbrResDto>()
	 *   		.newGridPagingResDto(	reqDto.init(Common.getInstance().getDBType()),
										loyMbrMapper.selectMbrList(reqDto));
	 *		
	 *		
	 * </PRE>
	 *   @param parameterObject
	 *   @param items
	 *   @return	
	 */
	public  GridPagingResDto<T> newGridPagingResDto( Object parameterObject , List<T> items ){
		
		return newGridPagingResDto(  parameterObject ,  items, AnnotationType.Nothing );
		
	}
	
	
	
	
	  /*
	  * 1. 메소드명: newGridPagingResDto
	  * 2. 클래스명: GridPagingResHelper
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명 : GridPagingResDto를 반환한다.
	 *		개인정보값이 있는 dto 처리의경우 AnnotationType.PersonalDatae 를 지정. 
	 *     공통코드갑값이 있는 dto 처리의경우 AnnotationType.CommCode 를 지정.
	 *     모두 처리의 경우  AnnotationType.ALL
	 * 2. 사용법:   서비스 객체서에서 사용함.
	 *   ex)   new GridPagingResHelper<LoyMbrResDto>()
	 *   		.newGridPagingResDto(
	 *   				reqDto.init(Common.getInstance().getDBType()),
	 *					loyMbrMapper.selectMbrList(reqDto), AnnotationType.ALL);
	 * </PRE>
	 *   @param parameterObject
	 *   @param items
	 *   @param checkAnnotation 어노테이션체크 유무 
	 *           AnnotationType.ALL -> CommCode, PersonalData 모두 체크, 
	 *           AnnotationType.PersonalData -> 개인정보만 체크 
	 *           AnnotationType.CommCode -> 공통코드만 체크 
	 *   
	 *   @return GridPagingResDto 객체
	 */
	public  GridPagingResDto<T> newGridPagingResDto( Object parameterObject , List<T> items , AnnotationType checkAnnotation ){
		
			LogUtil.param(this.getClass(), parameterObject);
			
			int totalCount = 0;
			
			try {				
					GridPagingReqDto parseParam = (GridPagingReqDto) parameterObject;
					int page = parseParam.getPage();

					
					int pageCount = 1;

					if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MYSQL)) {
						/// 구현해야 함.
						totalCount = items.size() == 0 ? 0 : (int) PropertyUtils.getProperty(items.get(0), "totalCount");
						
					} else if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.ORACLE) ) {
						
						totalCount = items.size() == 0 ? 0 : (int) PropertyUtils.getProperty(items.get(0), "totalCount");
						
					} else if (CommonUtil.getInstance().getDBType().equals(DB_TYPE.MSSQL) ) {
						
						totalCount = items.size() == 0 ? 0 : (int) PropertyUtils.getProperty(items.get(0), "totalCount");
						
					}
					
					if (parseParam.getRows() != 0) {
						if (totalCount % parseParam.getRows() == 0) {
							pageCount = totalCount / parseParam.getRows();
						} else {
							pageCount = totalCount / parseParam.getRows() + 1;
						}
					}

					gridPaging.setSuccess(true);
					gridPaging.setRows(items);
					gridPaging.setRecords(totalCount);
					gridPaging.setPage(page);
					gridPaging.setTotal(pageCount);
			} catch (DataAccessException e) {
				LogUtil.error(e.getMessage(),e);
				throw e;
			} catch (IllegalAccessException e) {
				LogUtil.error(e.getMessage(),e);
				throw new DataSQLException();
			} catch (InvocationTargetException e) {
				LogUtil.error(e.getMessage(),e);
				throw new DataSQLException();
			} catch (NoSuchMethodException e) {
				LogUtil.error(e.getMessage(),e);
				throw new DataSQLException();
			}
			
			
			if ( Optional.ofNullable(checkAnnotation).orElse( AnnotationType.Nothing) == AnnotationType.Nothing ) return gridPaging;
			
			
			 boolean isPersonDataType = false;
			 boolean isCommCodeType = false;
			 
			  if(items.size() == 0) return gridPaging;
		
              if( ( checkAnnotation == AnnotationType.ALL || checkAnnotation == AnnotationType.PersonalData)  && AnnotationHandler.isAnotationObject( items.get(0) , PersonalData.class) ) 
            	  isPersonDataType = true;		    	
              if( (checkAnnotation == AnnotationType.ALL || checkAnnotation == AnnotationType.CommCode ) && AnnotationHandler.isAnotationObject( items.get(0) , CommCode.class) ) 
            	  isCommCodeType = true;	
              
              
			   for(T item : items) {
				   //데상트용 마스킹 처리
				   //if(isPersonDataType)	 new PersonalDataDecodeHandler<>(item);
				   if(isPersonDataType)	 new PersonalDataHandler<>(item);
				   if(isCommCodeType)	 new CommCodeHandler(item);
				   
			   }
			
			   return gridPaging;
	
	 }

	/*
	 * 1. 메소드명: newGridPagingResDto
	 * 2. 클래스명: GridPagingResHelper
	 * 3. 작성자명: knlee
	 * 4. 작성일자: 2020. 2. 17.
	 */
	/**
	 * <PRE>
	 * 1. 설명 : GridPagingResDto를 반환한다.
	 *		개인정보값이 있는 dto 처리의경우 AnnotationType.PersonalDatae 를 지정.
	 *     공통코드갑값이 있는 dto 처리의경우 AnnotationType.CommCode 를 지정.
	 *     모두 처리의 경우  AnnotationType.ALL
	 * 2. 사용법:   서비스 객체서에서 사용함.
	 *   ex)   new GridPagingResHelper<LoyMbrResDto>()
	 *   		.newGridPagingResDto(
	 *   				reqDto.init(Common.getInstance().getDBType()),
	 *					loyMbrMapper.selectMbrList(reqDto), AnnotationType.ALL);
	 * </PRE>
	 *   @param parameterObject
	 *   @param items
	 *   @param checkAnnotation 어노테이션체크 유무
	 *           AnnotationType.ALL -> CommCode, PersonalData 모두 체크,
	 *           AnnotationType.PersonalData -> 개인정보만 체크
	 *           AnnotationType.CommCode -> 공통코드만 체크
	 *
	 *   @return GridPagingResDto 객체
	 */
	public  GridPagingResDto<T> newGridPagingResDto( Object parameterObject , List<T> items , AnnotationType checkAnnotation , Integer totalCountParam){

		LogUtil.param(this.getClass(), parameterObject);

		int totalCount = totalCountParam;

		try {
			GridPagingReqDto parseParam = (GridPagingReqDto) parameterObject;
			int page = parseParam.getPage();


			int pageCount = 1;

			if (parseParam.getRows() != 0) {
				if (totalCount % parseParam.getRows() == 0) {
					pageCount = totalCount / parseParam.getRows();
				} else {
					pageCount = totalCount / parseParam.getRows() + 1;
				}
			}

			gridPaging.setSuccess(true);
			gridPaging.setRows(items);
			gridPaging.setRecords(totalCount);
			gridPaging.setPage(page);
			gridPaging.setTotal(pageCount);
		} catch (DataAccessException e) {
			LogUtil.error(e.getMessage(),e);
			throw e;
		}


		if ( Optional.ofNullable(checkAnnotation).orElse( AnnotationType.Nothing) == AnnotationType.Nothing ) return gridPaging;


		boolean isPersonDataType = false;
		boolean isCommCodeType = false;

		if(items.size() == 0) return gridPaging;

		if( ( checkAnnotation == AnnotationType.ALL || checkAnnotation == AnnotationType.PersonalData)  && AnnotationHandler.isAnotationObject( items.get(0) , PersonalData.class) )
			isPersonDataType = true;
		if( (checkAnnotation == AnnotationType.ALL || checkAnnotation == AnnotationType.CommCode ) && AnnotationHandler.isAnotationObject( items.get(0) , CommCode.class) )
			isCommCodeType = true;


		for(T item : items) {
			//데상트용 마스킹 처리
			//if(isPersonDataType)	 new PersonalDataDecodeHandler<>(item);
			if(isPersonDataType)	 new PersonalDataHandler<>(item);
			if(isCommCodeType)	 new CommCodeHandler(item);

		}

		return gridPaging;

	}

	
}
