USE `auction_db`;

SELECT MAX(auctionId) + 1 INTO @auctionId FROM auction;
SELECT MAX(bidItemId) INTO @bidItemId FROM biditem;
SELECT MAX(lotId) INTO @lotid FROM ITEMLOT;
insert  into `auction`(`auctionId`,`status`,`isApproved`,`name`,`createdTime`,`lastupDateTime`) values (@auctionId,'Start','1',CONCAT('TEST AUCTION - ', @auctionId),NOW(),NOW());

insert  into `biditem`(`serialNumber`, `bidItemId`,`auctionId`,`name`,`location`,`city`,`zone`,`minBidPrice`,`minBidIncrement`,`bidStartTime`,`bidEndTime`,`timeExtn`,`statusCode`,`categoryId`,`marketId`,`currency`,`lastUpdateTime`,`createdTime`)
 
values ('1', @bidItemId + 1,@auctionId,'8" TO 20" X MIX ALL CATEGORY','noida','noida', '',22000.00, 500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('2', @bidItemId + 2,@auctionId,'8" TO 20" X MIX ALL CATEGORY', 'noida','noida','',22000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('3', @bidItemId + 3,@auctionId,'8" TO 20" X MIX ALL CATEGORY', 'noida','noida','',22000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('4', @bidItemId + 4,@auctionId,'8" X 6.4 - 10 CROSS WELD & WINDO', 'noida','noida','',25000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('5', @bidItemId + 5,@auctionId,'8" X 6.4 - 10 CROSS WELD & WINDO', 'noida','noida','',25000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('6', @bidItemId + 6,@auctionId,'8" X 6.4 - 10 CROSS WELD & WINDO', 'noida','noida','',25000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('7', @bidItemId + 7,@auctionId,'8" X 6.4 - 10 CROSS WELD & WINDO', 'noida','noida','',24000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('8', @bidItemId + 8,@auctionId,'8" X 6.4 - 11 CROSS WELD & WINDO', 'noida','noida','',25000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('9', @bidItemId + 9,@auctionId,'9-5/8" X 8 - 10 CROSS WELD & WIN', 'noida','noida','',24000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('10', @bidItemId + 10,@auctionId,'10" X 6.4 - 10 CROSS WELD & WIND', 'noida','noida','',23000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('11', @bidItemId + 11,@auctionId,'12" X 6.4 - 10 CROSS WELD & WIND', 'noida','noida','',23000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('12', @bidItemId + 12,@auctionId,'16" X 4.6 - 6.35 CROSS WELD & WI', 'noida','noida','',24000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('13', @bidItemId + 13,@auctionId,'16" X 6.4 - 12.7 CROSS WELD & WI', 'noida','noida','18',24000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('14', @bidItemId + 14,@auctionId,'16" X 6.4 - 12.7 CROSS WELD & WI', 'noida','noida','CG',24000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('15', @bidItemId + 15,@auctionId,'18" X 6.4 - 10 CROSS WELD & WIND', 'noida','noida','CG',25000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('16', @bidItemId + 16,@auctionId,'18" X 6.4 - 11 CROSS WELD & WIND', 'noida','noida','CG',24000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('17', @bidItemId + 17,@auctionId,'18" X 4.6 - 6.35 CROSS WELD & WI', 'noida','noida','CG',25000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('18', @bidItemId + 18,@auctionId,'20" X 6.4 - 10 CROSS WELD & WIND', 'noida','noida','CG',25000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('19', @bidItemId + 19,@auctionId,'20" X 4.6 - 12.7 CROSS WELD & WI', 'noida','noida','CG',24000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('20', @bidItemId + 20,@auctionId,'20" X 4.6 - 6.35 CROSS WELD & WI', 'noida','noida','CG',25000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW()),

('21', @bidItemId + 21,@auctionId,'20" X 6.4 - 12.7 CROSS WELD & WI', 'noida','noida','CG',25000.00,500.00,NULL,NULL, 120,'START',2,1,'INR',NOW(),NOW());





INSERT  INTO `bidsequence`(`SEQUENCEID`,`AUCTIONID`,`BIDITEMID`,`BIDSPAN`) 
VALUES ('1', @auctionId, @bidItemId+1,'120' ),
('2', @auctionId, @bidItemId+2,'120' ),
('3', @auctionId, @bidItemId+3,'120' ),
('4', @auctionId, @bidItemId+4,'120' ),
('5', @auctionId, @bidItemId+5,'120' ),
('6', @auctionId, @bidItemId+6,'120' ),
('7', @auctionId, @bidItemId+7,'120' ),
('8', @auctionId, @bidItemId+8,'120' ),
('9', @auctionId, @bidItemId+9,'120' ),
('10', @auctionId, @bidItemId+10,'120' ),
('11', @auctionId, @bidItemId+11,'120' ),
('12', @auctionId, @bidItemId+12,'120' ),
('13', @auctionId, @bidItemId+13,'120' ),
('14', @auctionId, @bidItemId+14,'120' ),
('15', @auctionId, @bidItemId+15,'120' ),
('16', @auctionId, @bidItemId+16,'120' ),
('17', @auctionId, @bidItemId+17,'120' ),
('18', @auctionId, @bidItemId+18,'120' ),
('19', @auctionId, @bidItemId+19,'120' ),
('20', @auctionId, @bidItemId+20,'120' ),
('21', @auctionId, @bidItemId+21,'120' );




INSERT  INTO `itemlot`(`lotno`,`lotid`,`biditemid`,`name`,`LengthRange`,`ActualLength`,`QUANTITY`,`UNIT`,`CURRENCY`,`Remark`,`ZONE`)values (519, @lotId+1, @bidItemId+1, '8" TO 20" X MIX ALL CATEGORY','3\' - 7\' MTR','','20','MT','INR','',''),

('519a', @lotId+2, @bidItemId+2, '8" TO 20" X MIX ALL CATEGORY','3\' - 8\' MTR','','20','MT','INR','', ''),

('519b', @lotId+3, @bidItemId+3, '8" TO 20" X MIX ALL CATEGORY','1\' - 5\' MTR','','10','MT','INR','',''),

('501', @lotId+4, @bidItemId+4, '8" X 6.4 - 10 CROSS WELD & WINDO','13\' - 20\' MTR','','15','MT','INR','',''),

('502', @lotId+5, @bidItemId+5, '8" X 6.4 - 10 CROSS WELD & WINDO','13\' - 20\' MTR','','15','MT','INR','',''),

('503', @lotId+6, @bidItemId+6, '8" X 6.4 - 10 CROSS WELD & WINDO','13\' - 20\' MTR','','15','MT','INR','',''),

('514', @lotId+7, @bidItemId+7, '8" X 6.4 - 10 CROSS WELD & WINDO','8\' - 13\' MTR','','10','MT','INR','',''),

('504', @lotId+8, @bidItemId+8, '8" X 6.4 - 11 CROSS WELD & WINDO','13\' - 20\' MTR','','15','MT','INR','',''),

('505', @lotId+9, @bidItemId+9, '9-5/8" X 8 - 10 CROSS WELD & WIN','13\' - 20\' MTR','','15','MT','INR','',''),

('506', @lotId+10, @bidItemId+10, '10" X 6.4 - 10 CROSS WELD & WIND','13\' - 20\' MTR','','5','MT','INR','',''),
('515', @lotId+11, @bidItemId+11, '12" X 6.4 - 10 CROSS WELD & WIND','8\' - 13\'MTR','','4','MT','INR','',''),
('507', @lotId+12, @bidItemId+12, '16" X 4.6 - 6.35 CROSS WELD & WI','13\' - 20\' MTR','','3','MT','INR','',''),
('508', @lotId+13, @bidItemId+13, '16" X 6.4 - 12.7 CROSS WELD & WI','13\' - 20\' MTR','','5','MT','INR','',''),
('516', @lotId+14, @bidItemId+14, '16" X 6.4 - 12.7 CROSS WELD & WI','8\' - 13\' MTR','','10','MT','INR','',''),
('510', @lotId+15, @bidItemId+15, '18" X 6.4 - 10 CROSS WELD & WIND','13\' - 20\' MTR','','15','MT','INR','',''),
('517', @lotId+16, @bidItemId+16, '18" X 6.4 - 11 CROSS WELD & WIND','8\' - 13\' MTR','','5','MT','INR','',''),

('509', @lotId+17, @bidItemId+17, '18" X 4.6 - 6.35 CROSS WELD & WI','13\' - 20\' MTR','','5','MT','INR','',''),

('513', @lotId+18, @bidItemId+18, '20" X 6.4 - 10 CROSS WELD & WIND','13\' - 20\' MTR','','10','MT','INR','',''),

('518', @lotId+19, @bidItemId+19, '20" X 4.6 - 12.7 CROSS WELD & WI','8\' - 13\' MTR','','10','MT','INR','',''),

('511', @lotId+20, @bidItemId+20, '20" X 4.6 - 6.35 CROSS WELD & WI','13\' - 20\' MTR','','5','MT','INR','',''),

('512', @lotId+21, @bidItemId+21, '20" X 6.4 - 12.7 CROSS WELD & WI','13\' - 20\' MTR','','10','MT','INR','','');


update biditem set minbidincrement=200;
UPDATE biditem SET timeextn=60;


insert  into `biddercategory`(`auctionId`,`categoryid`,`userId`) values (@auctionId,2,85),(@auctionId,2,86),(@auctionId,2,87),(@auctionId,2,88),(@auctionId,2,89),(@auctionId,2,90),(@auctionId,2,91),(@auctionId,2,92),(@auctionId,2,93),(@auctionId,2,94);