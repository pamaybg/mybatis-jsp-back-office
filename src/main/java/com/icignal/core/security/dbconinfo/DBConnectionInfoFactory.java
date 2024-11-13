package com.icignal.core.security.dbconinfo;

import com.icignal.core.Factory;

public  class DBConnectionInfoFactory extends Factory {
	
	public final static String DBCONNECTIONINFO_PACAKGE_PATH = "com.icignal.core.security.dbconinfo.impl.";

	/*
	 * 1. 메소드명: createObject
	 * 2. 클래스명: Factory<T>
	 * 3. 작성자명: knlee
	 * 4. 작성일자: 2020. 1. 31.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * </PRE>
	 *   @param objType
	 *   @return
	 *   @throws InstantiationException
	 *   @throws IllegalAccessException
	 *   @throws ClassNotFoundException	
	 */
	
	@Override
	protected  DBConnectionInfo createObject(String objType)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException {
		return   (DBConnectionInfo) Class.forName( DBCONNECTIONINFO_PACAKGE_PATH + objType + "DBConnectionInfo").newInstance();
		
	}




/*	@Override
	protected <T> T createObject(String objType) throws InstantiationException, IllegalAccessException, ClassNotFoundException {
		return   Class.forName( DBCONNECTIONINFO_PACAKGE_PATH + objType + "DBConnectionInfo").newInstance();
		
	}

	*/
}
 