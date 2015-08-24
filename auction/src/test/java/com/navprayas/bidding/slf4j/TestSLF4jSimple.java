package com.navprayas.bidding.slf4j;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 
 * @author Vikas
 * TestSLF4jSimple is an example class 
 * to provide logging to any method in any class.
 * Please go through this class and import the 
 * classes (see import of this class) in your class 
 * Then use debug, info, warn and error method appropriately.
 */
public class TestSLF4jSimple {

	  public static void main(String[] args) {    
		  Logger logger = LoggerFactory.getLogger(TestSLF4jSimple.class);
		 
		  //All types of logging - just for example - start
		  //Usually the log.debug is used by the developers to debug methods, and they are switched off in production scenarios so they are just skipped. 
 		  logger.debug("Debug --- Hello World");
		  //Use log.info about things you would consider important enough to warrant logging but not enough for any more than that.
		  logger.info("Info --- Hello World");
		  //Use log.warn to note unusual things - preferably in detail - that might warrant a second glance from a system operator.
		  logger.warn("Warn --- Hello World");
		  //Use log.error for those things that require immediate attention. Like waking up people at 03:00...
		  logger.error("Error --- Hello World");
		  //All types of logging - just for example - stop
		  
		  int i = 10;
		  
		  try
		  {
			  //logging with parameter
			  logger.debug("integer value is {}", i);
			  i = i/0;
		  }
		  catch(Exception e)
		  {
			  logger.error("Exception occured ", e);
		  }
		  
	  }
}
