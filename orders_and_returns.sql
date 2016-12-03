begin tran
go
create table dbo.[Order]
(
    Id int not null primary key,
    VenueOrderId varchar(128) not null,
    SellingVendorId int not null,
    /*
    ...
    */
    constraint UC_Order_OrderForVendor unique(VenueOrderId, SellingVendorId),
);

create table dbo.[OrderLine]
(
    Id int not null primary key,
    VenueOrderId varchar(128) not null,
    SellingVendorId int not null,
    VenueOrderLineId varchar(128) not null,
    /*
    ...
    */
    constraint UC_OrderLine_OrderLineForOrder unique(VenueOrderLineId, VenueOrderId),
    constraint UC_OrderLine_OrderLineForVendor unique(VenueOrderLineId, SellingVendorId),    
    constraint FK_OrderLine_Order foreign key (VenueOrderId, SellingVendorId)
                                  references dbo.[Order](VenueOrderId, SellingVendorId)                            
)

create table dbo.[OrderReturn]
(
    Id int not null primary key,
    VenueOrderReturnId varchar(128) not null,
    VenueOrderId varchar(128) not null,
    SellingVendorId int not null,
    /*
    ...
    */
    constraint UC_OrderReturn_ReturnForVendor unique(VenueOrderReturnId, SellingVendorId),
    constraint FK_OrderReturn_Order foreign key (VenueOrderId, SellingVendorId)
                                    references dbo.[Order](VenueOrderId, SellingVendorId)
)

create table dbo.[OrderReturnLine]
(
    Id int not null primary key,
    VenueOrderReturnId varchar(128) not null,
    VenueOrderLineId varchar(128) not null,
    SellingVendorId int not null,
    /*
    ...
    */
    constraint UC_OrderReturnLine_LineForReturn unique(VenueOrderLineId, VenueOrderReturnId),
    constraint FK_OrderReturnLine_OrderReturn foreign key (VenueOrderReturnId, SellingVendorId)
                                              references dbo.[OrderReturn](VenueOrderReturnId, SellingVendorId),
    constraint FK_OrderReturnLine_OrderLine foreign key (VenueOrderLineId, SellingVendorId)
                                              references dbo.[OrderLine](VenueOrderLineId, SellingVendorId)
)
go
rollback tran