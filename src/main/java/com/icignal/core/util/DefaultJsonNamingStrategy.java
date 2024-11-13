package com.icignal.core.util;

import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.cfg.MapperConfig;
import com.fasterxml.jackson.databind.introspect.AnnotatedField;
import com.fasterxml.jackson.databind.introspect.AnnotatedMethod;


public class DefaultJsonNamingStrategy extends PropertyNamingStrategy
{
	   @Override
	   public String nameForField(MapperConfig config,
			   AnnotatedField field, String defaultName) {
		   return convert(defaultName);

	   }
	   @Override
	   public String nameForGetterMethod(MapperConfig config,
			   AnnotatedMethod method, String defaultName) {
		   return convert(defaultName);
	   }

	   @Override
	   public String nameForSetterMethod(MapperConfig config,
			   AnnotatedMethod method, String defaultName) {
		   String a = convert(defaultName); 
		   return a;
	   }

	   public String convert(String defaultName )
	   {
		   return defaultName;
	   }
 
 
}