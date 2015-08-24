package com.navprayas.bidding.common.util;

import java.util.Random;

public class CommonUtil {
	
	static final String passwordChars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	static Random rnd = new Random();

	public static String randomString( int len ) 
	{
	   StringBuilder password = new StringBuilder( len );
	   for( int i = 0; i < len; i++ ) 
	      password.append( passwordChars.charAt( rnd.nextInt(passwordChars.length()) ) );
	   return password.toString();
	}
	
}
