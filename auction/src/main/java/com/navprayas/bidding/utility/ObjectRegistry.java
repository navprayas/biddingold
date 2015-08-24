package com.navprayas.bidding.utility;

import java.util.HashMap;
import java.util.Map;

public class ObjectRegistry {

	private static Map<String, Object> objectMap = new HashMap<String, Object>();
	public static ObjectRegistry objectRegistry = new ObjectRegistry();
	public static ObjectRegistry getInstance()
	{
		return objectRegistry;
	}
	public void putObject(String className, Object classObject)
	{
		objectMap.put(className, classObject);
	}
	public Object getObject(String className)
	{
		return objectMap.get(className);
	}
}
