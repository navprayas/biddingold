package com.navprayas.bidding.common.email;

import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.apache.velocity.app.VelocityEngine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.navprayas.bidding.common.bean.EmailTemplate;

public class EmailSender {

	private final static Logger logger = LoggerFactory.getLogger(EmailSender.class);
	private static String from="ashish.kumar.katiyar16@gmail.com";
	private static String path="templates/";
	private String templateName="genericemailtemplate.vm";
	
	JavaMailSenderImpl mailSender;
	VelocityEngine velocityEngine;

	public EmailSender(JavaMailSenderImpl mailSender,VelocityEngine velocityEngine) {
		this.mailSender = mailSender;
		this.velocityEngine = velocityEngine;
	}

	public boolean sendEmail(final EmailTemplate emailTemplate) {
		boolean emailSent = false;
		try {
		
			MimeMessagePreparator preparator = new MimeMessagePreparator() {
				public void prepare(MimeMessage mimeMessage) throws Exception {
					
					MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
					message.setTo(emailTemplate.getTo());
					if(emailTemplate.getCc() != null){
						message.setCc(emailTemplate.getCc());
					}
					message.setFrom(from); 
					message.setSubject(emailTemplate.getSubject());										
					Map model = new HashMap();
					model.put("emailTemplateBean", emailTemplate);
					String text = "";
					if(emailTemplate.getTemplateName() != null && !"".equals(emailTemplate.getTemplateName())){
						text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, path+emailTemplate.getTemplateName(),model);
					}else{
						text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, path + templateName,model);
					}
					
					message.setText(text, true);
					logger.debug("Email Text ::" + text);
				}
			};
			this.mailSender.send(preparator);
			logger.debug("EMail sending successful");
			emailSent = true;
		} catch (Exception e) {
			logger.error("Email not sent", e);		
		}
		return emailSent;
	}

	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

}
