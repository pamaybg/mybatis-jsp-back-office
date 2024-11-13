package com.icignal.core;




public abstract class Factory {

			
	/*
	public final DBConnectionInfo create(String objType) throws InstantiationException, IllegalAccessException, ClassNotFoundException {
		DBConnectionInfo dbConInfo = createDBConnectionInfo(objType);
		return dbConInfo;
		
	}
	
	
	protected abstract DBConnectionInfo createDBConnectionInfo(String objType) throws InstantiationException, IllegalAccessException, ClassNotFoundException;
	
	*/
	
	public final Object create(String objType) throws InstantiationException, IllegalAccessException, ClassNotFoundException {
		return createObject(objType);
		
		
	}
	
	
	protected abstract Object createObject(String objType) throws InstantiationException, IllegalAccessException, ClassNotFoundException;
	
	
	
	
}
