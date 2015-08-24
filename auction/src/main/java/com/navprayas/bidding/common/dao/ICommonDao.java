package com.navprayas.bidding.common.dao;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import com.navprayas.bidding.common.dto.OnlineUserVO;
import com.navprayas.bidding.common.form.Auction;
import com.navprayas.bidding.common.form.Authorities;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidSequence;
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.form.Category;
import com.navprayas.bidding.common.form.FirmDetails;
import com.navprayas.bidding.common.form.ItemLot;
import com.navprayas.bidding.common.form.UserActivity;
import com.navprayas.bidding.common.form.UserDetails;
import com.navprayas.bidding.common.form.Users;

public interface ICommonDao {

	public String checkUserExistsAndSendPasswordMail(String userName, String secretAnswer);
	
	public String saveUser(Users users, Authorities authorities, UserDetails userDetails);
	
	public void saveUserActivity(UserActivity userActivity);
	
	public void updateUserActivity(String sessionId,Long auctionId);
	
	public List<UserActivity> getOnlineUserList(Long auctionid);
	
	public int saveVendor(FirmDetails firmDetails);
	
	public void updateUserPassword(String LoggerName, String Newpass);
	
	public boolean checkIfUserExists(String userName);
	
	public List<Category> getCategoryList();
	
	public List<BidderCategory> getCategoryList(String userName, long auctionId);
	
	public List<BidItem> getAllComingActiveBids();
	
	public void flushAllActiveBidItems(Collection<BidItem> bidItems);

	public BidItem getBidItem(long bidItemId);
	
	public Date getActualAuctionStartTime(long auctionid);
	
	//public Long getAuctionIdIfAny();
	public long getMaxBidId();
	
	public long getMaxAutoBidId();
	
	public List<BidSequence> getCurrentBidSequence(long auctionId);
	
	public List<ItemLot> getItemLots(long bidItemId);
	
	public Long getTimeExtension();
	
	public void updateBidItem(BidItem bidItem);
	
	public void cleanAuction();
	
	public void insertAuctionDetail();
	
	public void setActualAuctionStartTime(long auctionId, Date actualAuctionStartTime);
	
	public void setAuctionEndTime(long auctionId, Date auctionEndTime);
	
	//***********************Password Change**********************/
	public String ChangePassword(String LoggerName,String Oldpass,String Newpass);
	
	//***********************Password Change**********************/
	
	public Users getUserForUsername(String userName);
	
	public void closeAuction(Long auctionId);

	public boolean isValidAuction(Long auctionId);
	
	public List<Auction> getAuctionListForAction();
	
	public List<Users> getActiveBidders();
	
	public void setUserAuctionMap(Long selectedAuctionId, String selectedCategoryIdList, String selectedUserIdList);
}
