USE [master]
GO
/****** Object:  Database [Bayan2]    Script Date: 2/27/2021 2:01:19 AM ******/
CREATE DATABASE [Bayan2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Bayan2', FILENAME = N'E:\ElMrkt\DataBase\Source\Bayan2.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Bayan2_log', FILENAME = N'E:\ElMrkt\DataBase\Source\Bayan2_log.ldf' , SIZE = 139264KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Bayan2] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Bayan2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Bayan2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Bayan2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Bayan2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Bayan2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Bayan2] SET ARITHABORT OFF 
GO
ALTER DATABASE [Bayan2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Bayan2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Bayan2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Bayan2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Bayan2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Bayan2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Bayan2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Bayan2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Bayan2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Bayan2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Bayan2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Bayan2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Bayan2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Bayan2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Bayan2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Bayan2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Bayan2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Bayan2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Bayan2] SET  MULTI_USER 
GO
ALTER DATABASE [Bayan2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Bayan2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Bayan2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Bayan2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Bayan2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Bayan2] SET QUERY_STORE = OFF
GO
USE [Bayan2]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Bayan2]
GO
/****** Object:  Schema [Error]    Script Date: 2/27/2021 2:01:20 AM ******/
CREATE SCHEMA [Error]
GO
/****** Object:  UserDefinedFunction [dbo].[Fun_Get_Receipt_Data]    Script Date: 2/27/2021 2:01:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Fun_Get_Receipt_Data] (@invoiceNo varchar(50))
RETURNS 
@Data table ( 
 seq int, day_id int null,  day_date datetime null, station_id int null,  user_id int null, invoice_no varchar(50)
 ,invoice_date datetime null, invoice_time time(7) null, product_id int , bar_code varchar(50) , product_na nvarchar(500) 
 ,qty decimal(18, 3) , unit_price decimal(18, 2) , sub_total decimal(18, 2) , line_discount_id int null
 ,line_discount_rate decimal(18,2) null, line_discount_reason_id int null, line_discount_value decimal(18,2) null
 ,invoice_discount_id int null, invoice_discount_reason_id int null, invoice_discount_value decimal(18,2) null
 ,grand_total decimal(18,2) null, service_id int null, service_value decimal(18,2) null, tax_id int null, tax_rate decimal(18,2) null
 ,tax_value decimal(18,2) null, net_value decimal(18,2) null, invoice_net_value decimal(18,2) null, void_reason_id int null, void_by_id int null
 ,void_date_time datetime null, pay1_id int null, currency1_id int null, card1_no varchar(50) null, paid1_amount decimal(18,2) null
 ,pay2_id int null, currency2_id int null, card2_no varchar(50) null, paid2_amount decimal(18,2) null
 ,pay3_id int null, currency3_id int null, card3_no varchar(50) null, paid3_amount decimal(18,2) null
 ,change_amount decimal(18,2) null, partner_id varchar(50), partner_na nvarchar(100), PartnerPhone varchar(50), Adress nvarchar(100)
 ,seller_id int null, seller_na nvarchar(100), invoice_notes nvarchar(500), items_count int, store_na nvarchar(50), line_type int
 ,line_ref varchar(50), status_id int, pay1_na nvarchar(50), pay2_na nvarchar(50), pay3_na nvarchar(50), company_id nvarchar(50)
 ,store_id varchar (50), updated int, DeleveryServiceValue decimal(18,2) null, IsPospond bit null, DeliveryMan nvarchar(100) )
AS
BEGIN
insert into @Data 
 select  dtl.Seq, total.DayId, total.DayDate, total.StationId,
total.UserId,  '*' + UPPER(dtl.InvoiceNo) + '*', total.InvoiceDate,
total.InvoiceTime, dtl.ProductId, dtl.BarCode, product.ProductNa,
dtl.Qty, dtl.UnitPrice,  dtl.SubTotal, dtl.LineDiscountId, dtl.LineDiscountRate,
dtl.LineDiscountReason, dtl.LineDiscountValue, dtl.InvoiceDiscountId,
dtl.InvoiceDiscountReason, dtl.InvoiceDiscountValue, dtl.GrandTotal,
dtl.ServiceId, dtl.ServiceValue, dtl.TaxId, dtl.TaxRate, dtl.TaxValue, dtl.NetValue,
dtl.InvoiceNetValue, dtl.VoidReasonId, dtl.VoidById, dtl.VoidDateTime, dtl.Pay1Id,
dtl.Currency1Id,  dtl.Card1No, dtl.Paid1Amount, dtl.Pay2Id, dtl.Currency2Id, dtl.Card2No, dtl.Paid2Amount,
dtl.Pay3Id, dtl.Currency3Id, dtl.Card3No, dtl.Paid3Amount, dtl.ChangeAmount, total.PartnerCode,
partner.Partner_Na, partner.Mobile, partner.Address,
total.SellerCode SellerId, seller.Name, dtl.InvoiceNotes, dtl.ItemsCount, store.SubWHNa,
dtl.LineType,  dtl.LineRef, dtl.StatusId, dtl.Pay1Na,dtl.Pay2Na,dtl.Pay3Na,dtl.CompanyId,
total.StoreId,dtl.Updated,dtl.DeleveryServiceValue,dtl.IsPostpond,deliveryman.Partner_Na
 from SalesDetail dtl inner join  SalesTotal total on (total.InvoiceNo = @invoiceNo and dtl.InvoiceNo = @invoiceNo)
 inner join MdProductsAttribute attr  on (attr.Barcode = dtl.BarCode)
 inner join MdProduct product on (attr.ProductId = product.ProductId)
 inner join  MdSeller seller on ( seller.SellerCode = total.SellerCode ) 
 inner join Partner partner on ( partner.Partner_Code = total.PartnerCode ) 
 inner join Storewarehouse store on ( store.SubWHId = total.StoreId )
 left join Partner deliveryman on ( deliveryman.Partner_Code = total.DeliveryManCode)
return
End

GO
/****** Object:  UserDefinedFunction [dbo].[GetSummeryReturnOnlyPerDay]    Script Date: 2/27/2021 2:01:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION  [dbo].[GetSummeryReturnOnlyPerDay]
(
@DateFrom date ,
@DateTo date
)
RETURNS 
@Data table ( 
 DayId int, ShiftId int ,StartDate varchar(50),  StartTime varchar(5), EndDate varchar(50),  EndTime varchar(5) ,
 RetrnCash decimal(18, 2) , RetrnCredit decimal(18, 2) , RetrnRemaining decimal(18, 2) , RetrnDiscount decimal(18, 2) , 
 RetrnServiceValue decimal(18, 2) , RetrnDeleveryValue decimal(18, 2) , RetrnIncoiceCount decimal(18, 2) , RetrnItemsCount decimal(18, 0) 
 )
AS
BEGIN

insert into @Data
SELECT ST.DayId,ST.ShiftID, p.StartDate, CONVERT(VARCHAR(5), p.StartTime,108) as StartTime,
p.EndDate,CONVERT(VARCHAR(5), p.EndTime,108) as EndTime , 
 SUM(ST.Pay1Amt) as RetrnCash,
SUM(ST.Pay2Amt) AS RetrnCredit, 
sum(ST.Remain) as RetrnRemaining, 
SUM(ST.LineDiscounts + ST.InvoiceDiscount)AS RetrnDiscount,
SUM(ST.ServiceValue) RetrnServiceValue,
Sum(ST.DeleveryServiceValue)  RetrnDeleveryValue,
Count(*) RetrnIncoiceCount,
Sum(ST.ItemCount) RetrnItemsCount
FROM SalesTotal ST INNER JOIN PosBussinessDay p ON ST.DayId=p.DayId
WHERE ST.InvoiceType is not null and St.InvoiceType = 2 and ST.InvoiceDate>@DateFrom AND ST.InvoiceDate<@DateTo  
GROUP BY ST.DayId,ST.ShiftID,p.StartDate,p.StartTime, p.EndDate, p.EndTime;
 
 RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSummerySales]    Script Date: 2/27/2021 2:01:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION  [dbo].[GetSummerySales]
(
@DateFrom date ,
@DateTo date
)
RETURNS 
@Data table ( 
 DayId int, StartDate varchar(50),  StartTime varchar(5), EndDate varchar(50),  EndTime varchar(5) ,
 SalesCash decimal, SalesCredit decimal, SalesRemaining decimal, SalesDiscount decimal, 
 SalesServiceValue decimal, SalesDeleveryValue decimal, SalesIncoiceCount decimal, SalesItemsCount decimal
 )
AS
BEGIN

insert into @Data
SELECT ST.DayId, p.StartDate, CONVERT(VARCHAR(5), p.StartTime,108) as StartTime,
p.EndDate,CONVERT(VARCHAR(5), p.EndTime,108) as EndTime , 
 SUM(ST.Pay1Amt) as SalesCash,
SUM(ST.Pay2Amt) AS SalesCredit, 
sum(ST.Remain) as SalesRemaining, 
SUM(ST.LineDiscounts + ST.InvoiceDiscount)AS SalesDiscount,
SUM(ST.ServiceValue) SalesServiceValue,
Sum(ST.DeleveryServiceValue)  SalesDeleveryValue,
Count(*) SalesIncoiceCount,
Sum(ST.ItemCount) SalesItemsCount
FROM SalesTotal ST INNER JOIN PosBussinessDay p ON ST.DayId=p.DayId
WHERE ST.InvoiceType is not null and St.InvoiceType != 2 and ST.InvoiceDate>=@DateFrom AND ST.InvoiceDate<=@DateTo  
GROUP BY ST.DayId,p.StartDate,p.StartTime, p.EndDate, p.EndTime;

RETURN
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetSummerySalesOnlyPerDay]    Script Date: 2/27/2021 2:01:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION  [dbo].[GetSummerySalesOnlyPerDay]
(
@DateFrom date ,
@DateTo date
)
RETURNS 
@Data table ( 
 DayId int,ShiftId int, StartDate varchar(50),  StartTime varchar(5), EndDate varchar(50),  EndTime varchar(5) ,
 SalesCash decimal(18, 2), SalesCredit   decimal(18, 2), SalesRemaining   decimal(18, 2), SalesDiscount   decimal(18, 2), 
 SalesServiceValue   decimal(18, 2), SalesDeleveryValue   decimal(18, 2), SalesIncoiceCount   decimal(18, 2), SalesItemsCount decimal(18,0)
 )
AS
BEGIN

insert into @Data
SELECT ST.DayId, ST.ShiftID,p.StartDate, CONVERT(VARCHAR(5), p.StartTime,108) as StartTime,
p.EndDate,CONVERT(VARCHAR(5), p.EndTime,108) as EndTime , 
 SUM(ST.Pay1Amt) as SalesCash,
SUM(ST.Pay2Amt) AS SalesCredit, 
sum(ST.Remain) as SalesRemaining, 
SUM(ST.LineDiscounts + ST.InvoiceDiscount)AS SalesDiscount,
SUM(ST.ServiceValue) SalesServiceValue,
Sum(ST.DeleveryServiceValue)  SalesDeleveryValue,
Count(*) SalesIncoiceCount,
Sum(ST.ItemCount) SalesItemsCount
FROM SalesTotal ST INNER JOIN PosBussinessDay p ON ST.DayId=p.DayId
WHERE ST.InvoiceType is not null and St.InvoiceType != 2 and ST.InvoiceDate>@DateFrom AND ST.InvoiceDate<@DateTo  
GROUP BY ST.DayId,ST.ShiftID,p.StartDate,p.StartTime, p.EndDate, p.EndTime;
 
 RETURN
END
GO
/****** Object:  Table [dbo].[Warehousestock]    Script Date: 2/27/2021 2:01:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehousestock](
	[WareHouseStockId] [int] IDENTITY(1,1) NOT NULL,
	[ProductAttrId] [int] NULL,
	[OpeningBalance] [decimal](18, 2) NULL,
	[CurrentQuantity] [decimal](18, 2) NULL,
	[Reserved] [int] NULL,
	[Transit] [decimal](18, 2) NULL,
	[MainWHId] [varchar](50) NULL,
	[Updated] [int] NULL,
	[CompanyId] [varchar](50) NULL,
	[StoreID] [varchar](50) NULL,
	[SoldQty] [decimal](18, 3) NULL,
	[PocRecieved] [decimal](18, 3) NULL,
	[PocReturn] [decimal](18, 3) NULL,
 CONSTRAINT [PK_Warehousestock] PRIMARY KEY CLUSTERED 
(
	[WareHouseStockId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MdProductsAttribute]    Script Date: 2/27/2021 2:01:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MdProductsAttribute](
	[Seq] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[ColorId] [int] NULL,
	[CompanyId] [varchar](50) NOT NULL,
	[SizeId] [int] NULL,
	[BrandId] [int] NULL,
	[Model] [int] NULL,
	[Replenishment] [decimal](18, 3) NULL,
	[Barcode] [varchar](50) NULL,
	[Mappingbarcode] [int] NULL,
	[Updated] [int] NOT NULL,
	[Active] [int] NOT NULL,
	[Lastupdate] [datetime] NULL,
	[UOM] [int] NULL,
	[ChildernId] [numeric](10, 0) NULL,
 CONSTRAINT [PK_MdProductsAttribute] PRIMARY KEY CLUSTERED 
(
	[Seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MdProduct]    Script Date: 2/27/2021 2:01:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MdProduct](
	[ProductId] [int] NOT NULL,
	[ProductNa] [nvarchar](max) NULL,
	[Barcode] [varchar](50) NULL,
	[PosNa] [nvarchar](max) NULL,
	[ReceiptNa] [nvarchar](max) NULL,
	[MainGrpId] [int] NULL,
	[SubCatId] [numeric](10, 0) NULL,
	[CatTypeId] [numeric](10, 0) NULL,
	[TaxId] [varchar](50) NULL,
	[TaxValue] [decimal](18, 3) NULL,
	[PhotoNa] [nvarchar](50) NULL,
	[ProductionDate] [varchar](50) NULL,
	[ExpiryDate] [varchar](50) NULL,
	[SellUomId] [varchar](50) NULL,
	[StockUomId] [varchar](50) NULL,
	[PurchaseUomId] [varchar](50) NULL,
	[CostPrice] [decimal](18, 3) NULL,
	[LeadTime] [decimal](18, 3) NULL,
	[SaftyStockLimit] [decimal](18, 3) NULL,
	[MinimumStockLimit] [decimal](18, 3) NULL,
	[ReorderPoint] [decimal](18, 3) NULL,
	[LotSize] [decimal](18, 3) NULL,
	[ReplenishmentQty] [decimal](18, 3) NULL,
	[DimensionId] [int] NULL,
	[PdtType] [int] NULL,
	[CurrencyId] [int] NULL,
	[Price1] [decimal](18, 3) NULL,
	[SessionId] [int] NULL,
	[FabricGrpId] [int] NULL,
	[FabricTypeId] [int] NULL,
	[Year] [int] NULL,
	[TreatmentType] [int] NULL,
	[CompanyId] [varchar](50) NULL,
	[StoreId] [varchar](50) NULL,
	[PriceListId] [int] NULL,
	[DiscountListId] [int] NULL,
	[Updated] [int] NULL,
	[Active] [int] NULL,
	[PicesInCarton] [decimal](18, 3) NULL,
	[CartonInBox] [decimal](18, 3) NULL,
	[IsWeight] [bit] NULL,
	[Lastupdate] [datetime] NULL,
	[NumOfUnitsPieces] [decimal](18, 0) NULL,
	[RreferenceCode] [int] NULL,
	[IsSupplierOffer] [bit] NULL,
	[IsNegativeSales] [bit] NULL,
 CONSTRAINT [PK_MdProducts] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_Get_Balance]    Script Date: 2/27/2021 2:01:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create View [dbo].[V_Get_Balance] as
select p.ProductId , p.Barcode ProductBarcode , pa.Barcode AttrBarcode , w.CurrentQuantity , p.ProductNa from Warehousestock w 
join   MdProductsAttribute pa on w.ProductAttrId = pa.Seq
join   mdproduct p on pa.ProductId = p.ProductId
group by p.ProductId, p.Barcode, pa.Barcode , w.CurrentQuantity ,p.ProductNa 
GO
/****** Object:  Table [dbo].[Price]    Script Date: 2/27/2021 2:01:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Price](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Productid] [int] NULL,
	[Costwithoutoverhead] [decimal](18, 3) NULL,
	[Costwithoverhead] [decimal](18, 3) NULL,
	[Directcost] [decimal](18, 3) NULL,
	[Taxid] [int] NULL,
	[Pricewithouttax] [decimal](18, 3) NULL,
	[Pricewithtax] [decimal](18, 3) NULL,
	[WholesalePrice] [decimal](18, 3) NULL,
	[HalfwholesalePrice] [decimal](18, 3) NULL,
	[CompanyId] [varchar](50) NULL,
	[Updated] [int] NULL,
	[Active] [int] NULL,
	[Lastupdate] [datetime] NULL,
 CONSTRAINT [PK_Price] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_GetProducts]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_GetProducts]
AS
SELECT        ProdAttrib.Seq, ProdAttrib.Barcode, Prod.Barcode AS MainCode, price.Pricewithtax AS Price, Prod.ProductNa AS ProductName, ProdAttrib.ChildernId AS ParentId, stock.CurrentQuantity AS CurrentQty
FROM            dbo.MdProduct AS Prod INNER JOIN
                         dbo.MdProductsAttribute AS ProdAttrib ON Prod.ProductId = ProdAttrib.ProductId INNER JOIN
                         dbo.Price AS price ON ProdAttrib.Seq = price.Productid LEFT OUTER JOIN
                         dbo.Warehousestock AS stock ON ProdAttrib.Seq = stock.ProductAttrId
WHERE        (Prod.Active = 1) AND (ProdAttrib.Active = 1)


GO
/****** Object:  Table [dbo].[Storetransaction]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Storetransaction](
	[Transaction_Id] [int] NOT NULL,
	[Transaction_Type] [varchar](50) NULL,
	[RefrenceDocument] [varchar](50) NULL,
	[Document_Num] [varchar](50) NULL,
	[Transaction_Date] [datetime] NULL,
	[Post] [int] NULL,
	[HallOrder] [varchar](50) NULL,
	[CO] [varchar](50) NULL,
	[POC] [varchar](50) NULL,
	[Mo] [varchar](50) NULL,
	[Po] [varchar](50) NULL,
	[CompanyID] [varchar](50) NULL,
	[Updated] [int] NULL,
	[Active] [int] NULL,
	[Main_WH_Id] [varchar](50) NULL,
	[StoreId] [varchar](50) NULL,
	[PartnerDocument] [varchar](50) NULL,
 CONSTRAINT [PK_Storetransaction] PRIMARY KEY CLUSTERED 
(
	[Transaction_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Storetransactiondetail]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Storetransactiondetail](
	[Transaction_Det_Id] [int] NOT NULL,
	[Document_Num] [varchar](50) NULL,
	[Transaction_Id] [int] NULL,
	[ProductAttr_Id] [int] NULL,
	[PurchaseUomId] [int] NULL,
	[Qty] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[Taxes] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[Notes] [varchar](100) NULL,
	[Updated] [int] NOT NULL,
	[Active] [int] NOT NULL,
	[StoreId] [nvarchar](50) NULL,
	[Storeseq] [int] NULL,
 CONSTRAINT [PK_Storetransactiondetail] PRIMARY KEY CLUSTERED 
(
	[Transaction_Det_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Moveordermaster]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Moveordermaster](
	[ID] [int] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[DocumentNumber] [varchar](50) NOT NULL,
	[Date] [date] NOT NULL,
	[TransferType] [int] NULL,
	[ExecuteFrom] [bit] NOT NULL,
	[Reason] [int] NULL,
	[CompanyID] [varchar](50) NULL,
	[IsUsed] [bit] NULL,
	[Updated] [int] NOT NULL,
	[Active] [int] NOT NULL,
	[SubWareHouseId] [varchar](50) NULL,
	[SubWareHouseIdFrom] [varchar](50) NULL,
	[ReciptInPos] [bit] NOT NULL,
	[IsRequest] [int] NULL,
	[RequestedMo] [int] NULL,
 CONSTRAINT [PK_Moveordermaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[GetTransactionItem]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[GetTransactionItem]
as
select sd.Qty,pa.Seq,p.Barcode,p.ProductNa,m.SubWareHouseId,m.SubWareHouseIdFrom,
st.Transaction_Date
from Storetransaction st inner join Moveordermaster m on st.Mo=m.DocumentNumber
inner join Storetransactiondetail sd on st.Transaction_Id=sd.Transaction_Id
inner join MdProductsAttribute pa on pa.Seq=sd.ProductAttr_Id
inner join MdProduct p on p.ProductId=pa.ProductId
where Mo is not null
GO
/****** Object:  Table [dbo].[DiscountForCustomer]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountForCustomer](
	[ID] [numeric](18, 0) NOT NULL,
	[DiscountMasterId] [numeric](18, 0) NULL,
	[CustomerCode] [varchar](50) NULL,
	[Percentage] [numeric](6, 3) NULL,
	[Active] [int] NULL,
	[Lastupdate] [datetime] NULL,
	[IsAll] [bit] NULL,
	[ProductId] [numeric](18, 0) NULL,
 CONSTRAINT [PK_DiscountForCustomer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiscountMaster]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountMaster](
	[ID] [numeric](18, 0) NOT NULL,
	[Describtion] [nvarchar](200) NULL,
	[DateFrom] [datetime] NULL,
	[DateTo] [datetime] NULL,
	[CompanyID] [varchar](50) NULL,
	[Updated] [int] NULL,
	[Active] [int] NULL,
	[Type] [int] NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_DiscountPrice] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partner]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partner](
	[POS_Partner_Id] [int] IDENTITY(1,1) NOT NULL,
	[Partner_Code] [nvarchar](50) NULL,
	[Partner_Na] [nvarchar](100) NULL,
	[City_Id] [int] NULL,
	[Address] [nvarchar](100) NULL,
	[Email] [varchar](50) NULL,
	[Mobile] [varchar](50) NULL,
	[Phone1] [varchar](50) NULL,
	[Price_List_Id] [numeric](10, 0) NULL,
	[City] [nvarchar](50) NULL,
	[Area] [nvarchar](100) NULL,
	[Street] [nvarchar](50) NULL,
	[BuildingNumber] [nvarchar](50) NULL,
	[FlatNumber] [nvarchar](50) NULL,
	[CompanyId] [varchar](50) NULL,
	[IsPostpond] [bit] NULL,
	[Updated] [int] NULL,
	[Active] [int] NULL,
	[Lastupdate] [datetime] NULL,
	[PartenerTypeID] [decimal](18, 0) NULL,
	[CountryId] [int] NULL,
	[ProvinceId] [int] NULL,
	[DistrictId] [int] NULL,
	[TerritoryId] [int] NULL,
	[IsDeliveryMan] [bit] NULL,
	[Web_Partner_Id] [int] NULL,
 CONSTRAINT [PK_Partner] PRIMARY KEY CLUSTERED 
(
	[POS_Partner_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UC_Code] UNIQUE NONCLUSTERED 
(
	[Partner_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_GetValidCustomerDiscount]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_GetValidCustomerDiscount]
AS
SELECT        DisCust.ID AS DisID, Mstr.ID AS MstrID, Cust.Partner_Code, Cust.Partner_Na, DisCust.IsAll, DisCust.Percentage, DisCust.ProductId
FROM            dbo.DiscountMaster AS Mstr INNER JOIN
dbo.DiscountForCustomer AS DisCust ON DisCust.DiscountMasterId = Mstr.ID INNER JOIN
dbo.Partner AS Cust ON Cust.Partner_Code = DisCust.CustomerCode AND Cust.PartenerTypeID <> 4
WHERE        (Mstr.DateFrom <= CONVERT(date, GETDATE())) AND (Mstr.DateTo >= CONVERT(date, GETDATE()))
GO
/****** Object:  Table [dbo].[SalesTotal]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesTotal](
	[Seq] [int] NOT NULL,
	[DayId] [int] NULL,
	[StationId] [int] NULL,
	[UserId] [int] NULL,
	[InvoiceNo] [varchar](50) NULL,
	[ItemCount] [decimal](18, 3) NULL,
	[SubTotal] [decimal](18, 2) NULL,
	[LineDiscounts] [decimal](18, 2) NULL,
	[InvoiceDiscount] [decimal](18, 2) NULL,
	[GrandTotal] [decimal](18, 2) NULL,
	[ServiceId] [int] NULL,
	[ServiceValue] [decimal](18, 2) NULL,
	[TaxValue] [decimal](18, 2) NULL,
	[NetValue] [decimal](18, 2) NULL,
	[Pay1Amt] [decimal](18, 2) NULL,
	[Pay1Id] [int] NULL,
	[Pay2Amt] [decimal](18, 2) NULL,
	[Pay2Id] [int] NULL,
	[Pay3Amt] [decimal](18, 2) NULL,
	[Pay3Id] [int] NULL,
	[InvoiceDate] [date] NULL,
	[PartnerCode] [varchar](50) NULL,
	[SellerCode] [varchar](50) NULL,
	[StatusId] [int] NULL,
	[CompanyId] [varchar](50) NULL,
	[StoreId] [varchar](50) NULL,
	[Updated] [int] NULL,
	[ShiftID] [int] NULL,
	[InvoiceType] [int] NULL,
	[Payment] [decimal](18, 3) NULL,
	[Remain] [decimal](18, 3) NULL,
	[DeleveryServiceValue] [decimal](18, 2) NULL,
	[IsPostpond] [bit] NULL,
	[DeliveryManCode] [nvarchar](50) NULL,
	[LineRef] [varchar](50) NULL,
	[DayDate] [date] NULL,
	[InvoiceTime] [time](7) NULL,
 CONSTRAINT [PK_SalesTotal] PRIMARY KEY CLUSTERED 
(
	[Seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_SalesTotal] UNIQUE NONCLUSTERED 
(
	[InvoiceNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_DeliveryManRptData]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[V_DeliveryManRptData] as
SELECT totalsales.ShiftID
, totalsales.Seq
, deliveryMan.Partner_Na AS DeliveryManNam
, deliveryMan.Partner_Code AS DeliveryManCode 
, totalsales.InvoiceNo
, totalsales.NetValue
, totalsales.DeleveryServiceValue
, customer.Address
, totalsales.InvoiceDate
, totalsales.SubTotal InvoiceValue
FROM dbo.salesTotal AS totalsales INNER JOIN
     dbo.Partner AS deliveryMan ON totalsales.DeliveryManCode = deliveryMan.Partner_Code INNER JOIN
     dbo.Partner AS customer ON totalsales.PartnerCode = customer.Partner_Code
WHERE (totalsales.DeliveryManCode IS NOT NULL) AND (totalsales.DeleveryServiceValue IS NOT NULL) AND (totalsales.DeleveryServiceValue != 0)
GO
/****** Object:  Table [dbo].[Actives]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actives](
	[StoreId] [nvarchar](50) NOT NULL,
	[StoreNa] [nvarchar](50) NOT NULL,
	[TaxId] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[ActiveDate] [date] NULL,
	[DayId] [int] NULL,
	[ShiftId] [int] NULL,
	[ById] [varchar](50) NULL,
	[StoreType] [nchar](10) NULL,
	[PriceOrDiscountPrice] [int] NULL,
	[CurrencyId] [int] NULL,
	[industryId] [int] NULL,
	[CompanyId] [varchar](50) NULL,
	[DaysLimitation] [int] NULL,
	[VoucherApply] [int] NULL,
	[LogoPath] [varchar](50) NULL,
	[GrNow] [int] NULL,
	[GiNow] [int] NULL,
	[StoreTransfer] [int] NULL,
	[StorePrefix] [varchar](50) NULL,
	[PasswordAdmin] [nvarchar](50) NULL,
	[CompanyPhoto] [nvarchar](100) NULL,
 CONSTRAINT [PK_Actives] PRIMARY KEY CLUSTERED 
(
	[StoreId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[APIsConnections]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APIsConnections](
	[ApiURL] [varchar](500) NOT NULL,
	[CompanyName] [nvarchar](500) NULL,
	[CompanyID] [varchar](50) NULL,
 CONSTRAINT [PK_APIsConnections] PRIMARY KEY CLUSTERED 
(
	[ApiURL] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CentralizedLockUp]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CentralizedLockUp](
	[ID] [int] NOT NULL,
	[NameAr] [nvarchar](100) NULL,
	[NameEn] [nvarchar](100) NULL,
	[ParentId] [int] NULL,
	[Lastupdate] [datetime] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_CentralizedLockUp] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_CentralizedLockUp] UNIQUE NONCLUSTERED 
(
	[NameAr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_CentralizedLockUp_1] UNIQUE NONCLUSTERED 
(
	[NameEn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirectPoDetail]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectPoDetail](
	[ID] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[MasterID] [decimal](18, 0) NULL,
	[Barcode] [varchar](50) NULL,
	[SystemQty] [decimal](18, 3) NULL,
	[ApprovedQty] [decimal](18, 3) NULL,
	[ShippedQty] [decimal](18, 3) NULL,
	[ActualRecivedQty] [decimal](18, 3) NULL,
	[MarketUnitPrice] [decimal](18, 2) NULL,
	[VendorUnitPrice] [decimal](18, 2) NULL,
	[SubTotal] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[Taxes] [decimal](18, 2) NULL,
	[DifferanceValue] [decimal](18, 2) NULL,
	[DifferancePercent] [decimal](18, 2) NULL,
	[BonusQTY] [decimal](18, 3) NULL,
	[TotalBeforeDiscount] [decimal](18, 2) NULL,
	[TotalAfterDiscount] [decimal](18, 2) NULL,
	[TaxValue] [decimal](18, 2) NULL,
	[TotalAfterTax] [decimal](18, 2) NULL,
	[CommericalDiscount] [decimal](18, 2) NULL,
	[IsFree] [bit] NULL,
	[ExpiryDate] [date] NULL,
	[Lastupdate] [datetime] NULL,
	[JomlaDiscount] [decimal](18, 2) NULL,
	[SellPrice] [decimal](18, 2) NULL,
	[ReturnQty] [decimal](18, 3) NULL,
	[InternalCode] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[Updated] [int] NULL,
 CONSTRAINT [PK_DirectPoDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_DirectPoDetail] UNIQUE NONCLUSTERED 
(
	[MasterID] ASC,
	[Barcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DirectPoMaster]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectPoMaster](
	[ID] [decimal](18, 0) NOT NULL,
	[DocumentNumber] [varchar](50) NOT NULL,
	[CreationDate] [datetime] NULL,
	[SentDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[RecievedDate] [datetime] NULL,
	[PartnerId] [int] NULL,
	[ItemCount] [int] NULL,
	[SubTotal] [decimal](18, 3) NULL,
	[InvoiceDiscount] [decimal](18, 3) NULL,
	[Taxes] [decimal](18, 3) NULL,
	[Total] [decimal](18, 3) NULL,
	[Pay1amt] [decimal](18, 3) NULL,
	[Pay2amt] [decimal](18, 3) NULL,
	[Pay2Id] [int] NULL,
	[Card1No] [varchar](50) NULL,
	[StoreId] [varchar](50) NULL,
	[Status] [int] NULL,
	[CompanyID] [varchar](50) NULL,
	[Lastupdate] [datetime] NULL,
	[Active] [bit] NULL,
	[PaidAmount] [decimal](18, 3) NULL,
	[RemainAmount] [decimal](18, 3) NULL,
	[TotalBeforeDiscount] [decimal](18, 3) NULL,
	[TotalAfterDiscount] [decimal](18, 3) NULL,
	[TotalTax] [decimal](18, 3) NULL,
	[TotalAfterTax] [decimal](18, 3) NULL,
	[TotalDiscount] [decimal](18, 3) NULL,
	[BuyTotalBeforeDiscount] [decimal](18, 3) NULL,
	[BuyTotalAfterDiscount] [decimal](18, 3) NULL,
	[BuyTotalTax] [decimal](18, 3) NULL,
	[BuyTotalAfterTax] [decimal](18, 3) NULL,
	[BuyTotalDiscount] [decimal](18, 3) NULL,
	[BuyItemCount] [int] NULL,
	[FreeItemCount] [int] NULL,
	[RequestID] [decimal](18, 0) NULL,
	[PartnerCode] [nvarchar](50) NULL,
	[ReturnTotalBeforeDiscount] [decimal](18, 3) NULL,
	[ReturnTotalAfterDiscount] [decimal](18, 3) NULL,
	[ReturnTotalTax] [decimal](18, 3) NULL,
	[ReturnTotalAfterTax] [decimal](18, 3) NULL,
	[ReturnTotalDiscount] [decimal](18, 3) NULL,
	[ReturnItemCount] [decimal](18, 3) NULL,
	[ExpectedDeliveryDate] [date] NULL,
	[IsFromReplenishment] [bit] NULL,
	[VendorCompanyCode] [nvarchar](50) NULL,
	[Updated] [int] NULL,
 CONSTRAINT [PK_DirectPoMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_DirectPoMaster] UNIQUE NONCLUSTERED 
(
	[DocumentNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiscountByPieces_Free]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountByPieces_Free](
	[ID] [numeric](18, 0) NOT NULL,
	[FreeProductId] [numeric](18, 0) NULL,
	[FreeQty] [numeric](18, 2) NULL,
	[CompanyID] [varchar](50) NULL,
	[Updated] [int] NULL,
	[Active] [int] NULL,
	[DiscountMasterId] [numeric](18, 0) NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_DiscountByPiecesDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiscountByPieces_Purchase]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountByPieces_Purchase](
	[ID] [numeric](18, 0) NOT NULL,
	[PurchaseProductId] [numeric](18, 0) NULL,
	[PurchaseQty] [numeric](18, 2) NULL,
	[CompanyID] [varchar](50) NULL,
	[Updated] [int] NULL,
	[Active] [int] NULL,
	[DiscountMasterId] [numeric](18, 0) NULL,
	[AvilableItems] [int] NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_DiscountByPeciesMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiscountByPrice]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountByPrice](
	[ID] [numeric](18, 0) NOT NULL,
	[ProductId] [numeric](18, 0) NULL,
	[Percentage] [decimal](6, 2) NULL,
	[PriceWithDiscount] [numeric](18, 3) NULL,
	[CompanyID] [varchar](50) NULL,
	[Updated] [int] NULL,
	[Active] [int] NULL,
	[DiscountMasterId] [numeric](18, 0) NULL,
	[LastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_DiscountByValue] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiscountForEmployees]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountForEmployees](
	[ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DiscountMasterId] [numeric](18, 0) NULL,
	[CellingValue] [numeric](18, 2) NULL,
	[Percentage] [numeric](6, 3) NULL,
	[CompanyID] [varchar](50) NULL,
	[Updated] [decimal](18, 0) NULL,
	[Active] [decimal](18, 0) NULL,
	[Lastupdate] [datetime] NULL,
 CONSTRAINT [PK_DiscountForEmployees] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiscountSample]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountSample](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [varchar](50) NULL,
	[DiscountMasterID] [int] NULL,
	[LastUpdate] [datetime] NULL,
 CONSTRAINT [PK_DiscountSample] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HotKey]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HotKey](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HotKeyButton] [nvarchar](50) NULL,
	[Operation] [nvarchar](50) NULL,
 CONSTRAINT [PK_HotKey] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceCanceledItems]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceCanceledItems](
	[Seq] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNo] [varchar](50) NOT NULL,
	[BarCode] [varchar](50) NOT NULL,
	[Qty] [decimal](18, 3) NOT NULL,
	[ShiftID] [int] NOT NULL,
	[CompanyId] [varchar](50) NOT NULL,
	[Updated] [int] NOT NULL,
	[StoreId] [varchar](50) NULL,
 CONSTRAINT [PK_InvoiceCanceledItems] PRIMARY KEY CLUSTERED 
(
	[Seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceHoldCanceledItems]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceHoldCanceledItems](
	[Seq] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNo] [varchar](50) NOT NULL,
	[ProductId] [int] NOT NULL,
	[BarCode] [varchar](50) NOT NULL,
	[Qty] [decimal](18, 3) NOT NULL,
	[ShiftID] [int] NOT NULL,
	[CompanyId] [varchar](50) NOT NULL,
	[Updated] [int] NOT NULL,
	[StoreId] [varchar](50) NULL,
 CONSTRAINT [PK_InvoiceHoldCanceledItems] PRIMARY KEY CLUSTERED 
(
	[Seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceType]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceType](
	[ID] [int] NOT NULL,
	[Type] [nvarchar](50) NULL,
	[Lastupdate] [datetime] NULL,
 CONSTRAINT [PK_InvoiceType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LockUp]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LockUp](
	[ID] [int] NOT NULL,
	[NameAr] [nvarchar](50) NULL,
	[NameEn] [nvarchar](50) NULL,
	[Code] [nvarchar](50) NULL,
	[ParentId] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[Lastupdate] [datetime] NULL,
	[Createdby] [int] NULL,
	[updatedby] [int] NULL,
	[Active] [int] NOT NULL,
	[Deletedby] [int] NULL,
	[IsClothes] [int] NULL,
	[IsNegativeSale] [bit] NULL,
 CONSTRAINT [PK_LockUp] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MdPayMethod]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MdPayMethod](
	[PayMethodId] [int] NOT NULL,
	[PayMethodNa] [nvarchar](50) NOT NULL,
	[CardNoNeeded] [int] NOT NULL,
	[ClientId] [varchar](50) NOT NULL,
	[CompanyId] [varchar](50) NOT NULL,
	[StoreId] [varchar](50) NOT NULL,
	[Updated] [int] NOT NULL,
	[Active] [int] NOT NULL,
	[Lastupdate] [datetime] NULL,
 CONSTRAINT [PK_MdPayMethods] PRIMARY KEY CLUSTERED 
(
	[PayMethodId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MdSeller]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MdSeller](
	[Name] [nvarchar](50) NULL,
	[Address] [nvarchar](500) NULL,
	[Email] [varchar](50) NULL,
	[Mobile] [varchar](50) NULL,
	[Phone1] [varchar](50) NULL,
	[Phone2] [varchar](50) NULL,
	[Card] [varchar](50) NULL,
	[CompanyID] [varchar](50) NOT NULL,
	[StoreID] [varchar](50) NOT NULL,
	[Updated] [int] NOT NULL,
	[Active] [int] NOT NULL,
	[Lastupdate] [datetime] NULL,
	[SellerCode] [nvarchar](50) NOT NULL,
	[RoleID] [int] NULL,
	[Password] [nvarchar](50) NULL,
 CONSTRAINT [PK_MdSeller] PRIMARY KEY CLUSTERED 
(
	[SellerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Moveorderdetail]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Moveorderdetail](
	[ID] [int] NOT NULL,
	[MoveOrderMaserId] [int] NOT NULL,
	[DocumentNumber] [varchar](50) NULL,
	[ProductAttrId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [decimal](18, 3) NOT NULL,
	[RequestedQuantity] [decimal](18, 3) NOT NULL,
	[SubWareHouseId] [varchar](50) NULL,
	[SubWareHouseIdFrom] [varchar](50) NULL,
	[Notes] [varchar](100) NULL,
	[IsAccept] [bit] NOT NULL,
	[Updated] [int] NOT NULL,
	[Active] [int] NOT NULL,
	[CompanyID] [varchar](50) NULL,
	[Lastupdate] [datetime] NULL,
 CONSTRAINT [PK_Moveorderdetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PosBussinessDay]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PosBussinessDay](
	[DayId] [int] NOT NULL,
	[StartDate] [date] NULL,
	[StartTime] [time](7) NULL,
	[StartedBy] [varchar](50) NULL,
	[EndDate] [date] NULL,
	[EndTime] [time](7) NULL,
	[EndedBy] [varchar](50) NULL,
	[InvChk] [int] NULL,
	[AccessPos] [int] NULL,
	[CompanyId] [varchar](50) NOT NULL,
	[StoreId] [varchar](50) NOT NULL,
	[Updated] [int] NOT NULL,
	[Active] [int] NOT NULL,
	[DayOpeningCount] [int] NULL,
 CONSTRAINT [PK_PosBussinessDays] PRIMARY KEY CLUSTERED 
(
	[DayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PosScreenConfiguration]    Script Date: 2/27/2021 2:01:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PosScreenConfiguration](
	[ID] [int] NOT NULL,
	[ScreenName] [nvarchar](100) NULL,
	[IsShow] [bit] NULL,
	[LastUpdate] [datetime] NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[CreatedBy] [int] NULL,
	[DeletedBy] [int] NULL,
	[CompanyID] [nvarchar](50) NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_PosScreenConfiguration] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCostPriceForEverySupplier]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCostPriceForEverySupplier](
	[ID] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[SupplierId] [int] NULL,
	[ProductId] [numeric](10, 0) NULL,
	[CostWithoutTax] [decimal](10, 2) NULL,
	[Taxid] [decimal](10, 0) NULL,
	[TaxValue] [decimal](10, 2) NULL,
	[CostWithTax] [decimal](10, 2) NULL,
	[Updated] [bit] NOT NULL,
	[CompanyID] [varchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[Lastupdate] [datetime] NULL,
	[Createdby] [int] NULL,
	[updatedby] [int] NULL,
	[Active] [bit] NOT NULL,
	[Deletedby] [int] NULL,
 CONSTRAINT [PK_ProductCostPriceForEverySupplier] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [SupplierPriceProductUnique] UNIQUE NONCLUSTERED 
(
	[ProductId] ASC,
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductVsDistributor]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductVsDistributor](
	[PartnerCode] [nvarchar](50) NOT NULL,
	[CompanyID] [varchar](50) NOT NULL,
	[Active] [bit] NULL,
	[LastUpdate] [datetime] NULL,
	[UpdateBy] [int] NULL,
	[ProductAttrBarcode] [nvarchar](50) NOT NULL,
	[InternalCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProductVsDistributor] PRIMARY KEY CLUSTERED 
(
	[PartnerCode] ASC,
	[ProductAttrBarcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductVsVendor]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductVsVendor](
	[VendorCode] [nvarchar](50) NOT NULL,
	[CompanyID] [varchar](50) NOT NULL,
	[Active] [bit] NULL,
	[LastUpdate] [datetime] NULL,
	[UpdateBy] [int] NULL,
	[ProductAttrBarcode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProductVsVendor] PRIMARY KEY CLUSTERED 
(
	[VendorCode] ASC,
	[ProductAttrBarcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReturnWithoutInvDetails]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnWithoutInvDetails](
	[InvoiceNo] [varchar](50) NOT NULL,
	[Barcode] [varchar](50) NOT NULL,
	[Qty] [int] NULL,
	[NumOfUnitsPieces] [int] NULL,
	[TotalPrice] [decimal](18, 0) NULL,
 CONSTRAINT [PK_ReturnDetails] PRIMARY KEY CLUSTERED 
(
	[InvoiceNo] ASC,
	[Barcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReturnWithoutInvMaster]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReturnWithoutInvMaster](
	[InvoiceNo] [varchar](50) NOT NULL,
	[StoreId] [varchar](50) NULL,
	[UserId] [varchar](50) NULL,
	[CustomerCode] [varchar](50) NULL,
	[Date] [datetime] NULL,
	[TotalPrice] [decimal](18, 0) NULL,
	[DiscountPercentage] [decimal](18, 0) NULL,
	[DiscountQty] [decimal](18, 0) NULL,
	[TotalPriceAfterDiscount] [decimal](18, 0) NULL,
 CONSTRAINT [PK_ReturnMaster] PRIMARY KEY CLUSTERED 
(
	[InvoiceNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesDetail]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesDetail](
	[Seq] [int] NOT NULL,
	[InvoiceNo] [varchar](50) NOT NULL,
	[ProductId] [int] NOT NULL,
	[BarCode] [varchar](50) NOT NULL,
	[Qty] [decimal](18, 3) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[SubTotal] [decimal](18, 2) NOT NULL,
	[LineDiscountId] [int] NOT NULL,
	[LineDiscountRate] [decimal](18, 2) NOT NULL,
	[LineDiscountReason] [int] NOT NULL,
	[LineDiscountValue] [decimal](18, 2) NOT NULL,
	[InvoiceDiscountId] [int] NOT NULL,
	[InvoiceDiscountRate] [decimal](18, 2) NOT NULL,
	[InvoiceDiscountReason] [int] NOT NULL,
	[InvoiceDiscountValue] [decimal](18, 2) NOT NULL,
	[GrandTotal] [decimal](18, 2) NOT NULL,
	[ServiceId] [int] NOT NULL,
	[ServiceValue] [decimal](18, 2) NOT NULL,
	[TaxId] [int] NOT NULL,
	[ShiftID] [int] NOT NULL,
	[TaxRate] [decimal](18, 2) NOT NULL,
	[TaxValue] [decimal](18, 2) NOT NULL,
	[NetValue] [decimal](18, 2) NOT NULL,
	[InvoiceNetValue] [decimal](18, 2) NOT NULL,
	[VoidReasonId] [decimal](18, 2) NULL,
	[VoidById] [int] NULL,
	[VoidDateTime] [datetime] NULL,
	[Pay1Id] [int] NOT NULL,
	[Currency1Id] [int] NOT NULL,
	[Card1No] [varchar](50) NOT NULL,
	[Paid1Amount] [decimal](18, 2) NULL,
	[Pay2Id] [int] NOT NULL,
	[Currency2Id] [int] NOT NULL,
	[Card2No] [varchar](50) NOT NULL,
	[Paid2Amount] [decimal](18, 2) NOT NULL,
	[Pay3Id] [int] NOT NULL,
	[Currency3Id] [int] NOT NULL,
	[Card3No] [varchar](50) NOT NULL,
	[Paid3Amount] [decimal](18, 2) NOT NULL,
	[ChangeAmount] [decimal](18, 2) NOT NULL,
	[InvoiceNotes] [nvarchar](108) NOT NULL,
	[ItemsCount] [int] NOT NULL,
	[LineType] [int] NOT NULL,
	[LineRef] [varchar](50) NULL,
	[LineRefForStore] [varchar](50) NULL,
	[StatusId] [int] NOT NULL,
	[Pay1Na] [nvarchar](50) NOT NULL,
	[Pay2Na] [nvarchar](50) NOT NULL,
	[Pay3Na] [nvarchar](50) NOT NULL,
	[CompanyId] [varchar](50) NOT NULL,
	[Updated] [int] NOT NULL,
	[IsOffer] [bit] NULL,
	[InvoiceType] [int] NULL,
	[DeleveryServiceValue] [decimal](18, 2) NULL,
	[IsPostpond] [bit] NULL,
	[LineIdRef] [int] NULL,
 CONSTRAINT [PK_SalesDetails] PRIMARY KEY CLUSTERED 
(
	[Seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Salesholddetail]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salesholddetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNumber] [varchar](50) NULL,
	[ProductAttrId] [decimal](18, 0) NULL,
	[Qty] [decimal](18, 3) NULL,
	[IsOffer] [bit] NULL,
	[Barcode] [nvarchar](100) NULL,
	[DiscountPercentageForLine] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Salesholddetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Salesholdmaster]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salesholdmaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Deposit] [decimal](18, 0) NULL,
	[InvoiceNumber] [varchar](50) NULL,
	[Date] [date] NULL,
	[Time] [time](7) NULL,
	[CustomerID] [varchar](50) NULL,
	[IsSell] [bit] NULL,
	[DeleveryService] [decimal](18, 2) NULL,
	[ServicePercentage] [decimal](18, 2) NULL,
	[Note] [nvarchar](200) NULL,
	[DiscountPercentage] [decimal](18, 2) NULL,
	[Ispostpond] [bit] NULL,
	[SellerCode] [nvarchar](50) NULL,
	[ShiftID] [int] NULL,
 CONSTRAINT [PK_Salesholdmaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Salesmanagmentorder]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salesmanagmentorder](
	[ID] [int] NOT NULL,
	[DocumentNumber] [nvarchar](50) NULL,
	[Date] [date] NULL,
	[Time] [time](7) NULL,
	[CusromerId] [nvarchar](50) NULL,
	[StoreId] [nvarchar](50) NOT NULL,
	[ItemCount] [int] NULL,
	[SubTotal] [decimal](12, 2) NULL,
	[LineDiscount] [decimal](10, 2) NULL,
	[InvoiceDiscount] [decimal](10, 2) NULL,
	[GrandTotal] [decimal](12, 2) NULL,
	[TaxValue] [decimal](10, 2) NULL,
	[NetValue] [decimal](10, 2) NULL,
	[Note] [nvarchar](max) NULL,
	[IsDone] [bit] NULL,
	[CompanyId] [nvarchar](50) NULL,
	[Updated] [int] NULL,
	[Active] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[Lastupdate] [datetime] NULL,
	[Createdby] [int] NULL,
	[updatedby] [int] NULL,
	[Deletedby] [int] NULL,
	[ChecqNumber] [varchar](50) NULL,
 CONSTRAINT [PK_Salesmanagmentorder] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Salesordermanagmentdetail]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salesordermanagmentdetail](
	[ID] [int] NOT NULL,
	[DocumentNumber] [nvarchar](50) NULL,
	[ProductAttrId] [numeric](6, 0) NULL,
	[Quantity] [decimal](18, 3) NULL,
	[LineDiscountValue] [decimal](10, 2) NULL,
	[InvoiceDiscountValue] [decimal](12, 0) NULL,
	[GrandTotal] [decimal](12, 0) NULL,
	[TaxValue] [decimal](12, 0) NULL,
	[UnitPrice] [decimal](12, 0) NULL,
	[SubTotal] [decimal](12, 0) NULL,
	[NetValue] [decimal](12, 0) NULL,
	[InvoiceNetValue] [decimal](15, 2) NULL,
	[ItemCount] [int] NULL,
	[CompanyID] [nvarchar](50) NULL,
	[StoreID] [nvarchar](50) NULL,
	[Updated] [int] NULL,
	[Active] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[Lastupdate] [datetime] NULL,
	[Createdby] [int] NULL,
	[updatedby] [int] NULL,
	[Deletedby] [int] NULL,
 CONSTRAINT [PK_Salesordermanagmentdetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Setting]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Setting](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ItPassword] [nvarchar](50) NULL,
	[LastUpdate] [datetime] NULL,
	[APIConnection] [varchar](500) NULL,
	[LogoURL] [nvarchar](500) NULL,
	[LogoImage] [binary](500) NULL,
	[CompanyID] [nvarchar](50) NULL,
	[MasterMacAddress] [varchar](50) NULL,
 CONSTRAINT [PK_Setting] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shift]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shift](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NULL,
	[DayId] [int] NULL,
	[EndDate] [date] NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[CloseUserID] [varchar](50) NULL,
	[OpenUserID] [varchar](50) NULL,
	[Status] [int] NULL,
	[AccessPos] [int] NULL,
	[MoneyStartInStair] [decimal](18, 2) NULL,
	[MoneyEndInStair] [decimal](18, 2) NULL,
	[MoneyTransferd] [decimal](18, 2) NULL,
	[StoreId] [varchar](50) NULL,
	[CompanyID] [varchar](50) NULL,
	[Uploaded] [bit] NULL,
	[MacAddress] [nvarchar](100) NULL,
	[DifferanceValue] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Shift] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Storewarehouse]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Storewarehouse](
	[SubWHId] [varchar](50) NOT NULL,
	[SubWHNa] [nvarchar](50) NULL,
	[MainWHId] [varchar](50) NULL,
	[SubWHTypeId] [int] NULL,
	[CompanyID] [varchar](50) NULL,
	[Updated] [int] NULL,
	[Lastupdate] [datetime] NULL,
	[Createdby] [int] NULL,
	[Updatedby] [int] NULL,
	[Active] [int] NULL,
	[Deletedby] [int] NULL,
	[IsUsed] [bit] NULL,
	[SalesPreifx] [nvarchar](50) NULL,
	[ReturnPrifix] [nvarchar](50) NULL,
	[StoreTransPrefix] [nvarchar](50) NULL,
	[AdminPassword] [nvarchar](50) NULL,
	[DeliveryAmount] [decimal](18, 3) NULL,
 CONSTRAINT [PK_Storewarehouse] PRIMARY KEY CLUSTERED 
(
	[SubWHId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_StoreWarehouse] UNIQUE NONCLUSTERED 
(
	[StoreTransPrefix] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_StoreWarehouse_1] UNIQUE NONCLUSTERED 
(
	[SalesPreifx] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_StoreWarehouse_2] UNIQUE NONCLUSTERED 
(
	[ReturnPrifix] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SysStation]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysStation](
	[StationId] [int] NOT NULL,
	[StationNa] [nvarchar](50) NULL,
	[CurrencyId] [int] NULL,
	[Prefix] [varchar](50) NULL,
	[PrefixReturn] [varchar](50) NULL,
	[InvoiceSeqStart] [int] NULL,
	[InvoiceSeqNow] [int] NULL,
	[InvoiceOnholdSeqNow] [int] NULL,
	[InvoiceReturnQtyByOne] [int] NULL,
	[CustomerCode] [varchar](50) NULL,
	[CompanyId] [varchar](50) NULL,
	[StoreId] [varchar](50) NULL,
	[WarehouseId] [varchar](50) NULL,
	[Active] [int] NULL,
	[IsMaster] [bit] NULL,
	[ReturnSeqNow] [int] NULL,
 CONSTRAINT [PK_SysStation] PRIMARY KEY CLUSTERED 
(
	[StationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transit]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transit](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductAttrid] [decimal](18, 3) NULL,
	[SendedQty] [decimal](18, 3) NULL,
	[RecivedQty] [decimal](18, 3) NULL,
	[RemainQty] [decimal](18, 3) NULL,
	[SenderStorewarehouse] [varchar](50) NULL,
	[ReciverStorewarehouse] [varchar](50) NULL,
	[Mo] [varchar](50) NULL,
	[Updated] [int] NULL,
	[Lastupdate] [datetime] NULL,
 CONSTRAINT [PK_Transit] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Treasury]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Treasury](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[OpeningMoney] [decimal](18, 0) NULL,
	[CurrentMoney] [decimal](18, 0) NULL,
	[StoreID] [varchar](50) NULL,
	[CompanyId] [varchar](50) NULL,
 CONSTRAINT [PK_Treasury] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tresurytransaction]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tresurytransaction](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TransctionType] [int] NULL,
	[Value] [decimal](18, 0) NULL,
	[ShiftID] [int] NULL,
	[DayId] [int] NULL,
	[Storeid] [varchar](50) NULL,
	[CompanyId] [varchar](50) NULL,
	[Date] [date] NULL,
	[Time] [time](7) NULL,
	[UserID] [varchar](50) NULL,
	[AccessPos] [int] NULL,
	[IsUploaded] [bit] NULL,
 CONSTRAINT [PK_Tresurytransaction] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Error].[IntegrationError]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Error].[IntegrationError](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FunctionName] [varchar](100) NULL,
	[ErrorDescription] [varchar](5000) NULL,
	[ErrorDate] [datetime] NULL,
 CONSTRAINT [PK_Errors] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CentralizedLockUp] ADD  CONSTRAINT [DF_CentralizedLockUp_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[DirectPoDetail] ADD  CONSTRAINT [DF_DirectPoDetail_SystemQty]  DEFAULT ((0)) FOR [SystemQty]
GO
ALTER TABLE [dbo].[DirectPoDetail] ADD  CONSTRAINT [DF_DirectPoDetail_ApprovedQty]  DEFAULT ((0)) FOR [ApprovedQty]
GO
ALTER TABLE [dbo].[DirectPoMaster] ADD  CONSTRAINT [DF_DirectPoMaster_RemainAmount]  DEFAULT ((0)) FOR [RemainAmount]
GO
ALTER TABLE [dbo].[DiscountByPieces_Free] ADD  CONSTRAINT [DF_DiscountByPiecesDetail_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[DiscountByPieces_Purchase] ADD  CONSTRAINT [DF_DiscountByPeciesMaster_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[DiscountByPrice] ADD  CONSTRAINT [DF_DiscountByValue_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[DiscountForCustomer] ADD  CONSTRAINT [DF_CustomerDiscount_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[InvoiceCanceledItems] ADD  CONSTRAINT [DF_InvoiceCanceledItems_Updated]  DEFAULT ((0)) FOR [Updated]
GO
ALTER TABLE [dbo].[InvoiceHoldCanceledItems] ADD  CONSTRAINT [DF_InvoiceHoldCanceledItems_Updated]  DEFAULT ((0)) FOR [Updated]
GO
ALTER TABLE [dbo].[LockUp] ADD  CONSTRAINT [DF_LockUp_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[MdProduct] ADD  CONSTRAINT [DF_MdProducts_Updated]  DEFAULT ((0)) FOR [Updated]
GO
ALTER TABLE [dbo].[MdProduct] ADD  CONSTRAINT [DF_MdProducts_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[MdProductsAttribute] ADD  CONSTRAINT [DF_MdProductsAttribute_Updated]  DEFAULT ((0)) FOR [Updated]
GO
ALTER TABLE [dbo].[MdProductsAttribute] ADD  CONSTRAINT [DF_MdProductsAttribute_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[MdSeller] ADD  CONSTRAINT [DF_MdSellers_Updated]  DEFAULT ((0)) FOR [Updated]
GO
ALTER TABLE [dbo].[MdSeller] ADD  CONSTRAINT [DF_MdSellers_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Moveorderdetail] ADD  CONSTRAINT [DF_Moveorderdetail_Updated]  DEFAULT ((0)) FOR [Updated]
GO
ALTER TABLE [dbo].[Moveorderdetail] ADD  CONSTRAINT [DF_Moveorderdetail_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Moveordermaster] ADD  CONSTRAINT [DF_Moveordermaster_ReciptInPos]  DEFAULT ((0)) FOR [ReciptInPos]
GO
ALTER TABLE [dbo].[Moveordermaster] ADD  CONSTRAINT [DF_Moveordermaster_IsRequest]  DEFAULT ((0)) FOR [IsRequest]
GO
ALTER TABLE [dbo].[Moveordermaster] ADD  CONSTRAINT [DF_Moveordermaster_RequestedMo]  DEFAULT ((0)) FOR [RequestedMo]
GO
ALTER TABLE [dbo].[PosBussinessDay] ADD  CONSTRAINT [DF_PosBussinessDays_Updated]  DEFAULT ((0)) FOR [Updated]
GO
ALTER TABLE [dbo].[PosBussinessDay] ADD  CONSTRAINT [DF_PosBussinessDays_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[ProductCostPriceForEverySupplier] ADD  CONSTRAINT [DF_ProductCostPriceForEverySupplier_Updated]  DEFAULT ((1)) FOR [Updated]
GO
ALTER TABLE [dbo].[ProductCostPriceForEverySupplier] ADD  CONSTRAINT [DF_ProductCostPriceForEverySupplier_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[SalesDetail] ADD  CONSTRAINT [DF_SalesDetails_Pay1Na]  DEFAULT ((1)) FOR [Pay1Na]
GO
ALTER TABLE [dbo].[SalesDetail] ADD  CONSTRAINT [DF_SalesDetails_Pay2Na]  DEFAULT ((1)) FOR [Pay2Na]
GO
ALTER TABLE [dbo].[SalesDetail] ADD  CONSTRAINT [DF_SalesDetails_Pay3Na]  DEFAULT ((1)) FOR [Pay3Na]
GO
ALTER TABLE [dbo].[SalesDetail] ADD  CONSTRAINT [DF_SalesDetails_Updated]  DEFAULT ((0)) FOR [Updated]
GO
ALTER TABLE [dbo].[Salesmanagmentorder] ADD  CONSTRAINT [DF_Salesmanagmentorder_Updated]  DEFAULT ((1)) FOR [Updated]
GO
ALTER TABLE [dbo].[Salesmanagmentorder] ADD  CONSTRAINT [DF_Salesmanagmentorder_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Salesordermanagmentdetail] ADD  CONSTRAINT [DF_Salesordermanagmentdetail_Updated]  DEFAULT ((1)) FOR [Updated]
GO
ALTER TABLE [dbo].[Salesordermanagmentdetail] ADD  CONSTRAINT [DF_Salesordermanagmentdetail_Active]  DEFAULT ((1)) FOR [Active]
GO
ALTER TABLE [dbo].[Storetransactiondetail] ADD  CONSTRAINT [DF_Storetransactiondetail_Updated]  DEFAULT ((0)) FOR [Updated]
GO
ALTER TABLE [dbo].[Storetransactiondetail] ADD  CONSTRAINT [DF_Storetransactiondetail_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  StoredProcedure [dbo].[DeleteHoldInvoicesByShiftID]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create  procedure [dbo].[DeleteHoldInvoicesByShiftID] @ShiftID int
as
 delete from Salesholddetail where Salesholddetail.InvoiceNumber in (select Salesholdmaster.InvoiceNumber from Salesholdmaster where ShiftID = @ShiftID);
 delete from Salesholdmaster where ShiftID = @ShiftID;
GO
/****** Object:  StoredProcedure [dbo].[Get_ShiftsInSpecificPeroid]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Get_ShiftsInSpecificPeroid] @DateFrom Date , @DateTo Date
as
select  CONCAT( posday.StartDate , CONCAT(  ' - Shift  ',RANK() OVER(PARTITION BY shift.dayid ORDER BY shift.id ))) ShiftNa
,shift.ID  id
from Shift join PosBussinessDay posday on posday.DayId = shift.DayId
where posday.StartDate >@DateFrom
and posday.StartDate < @DateTo
GO
/****** Object:  StoredProcedure [dbo].[GetDailySales]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[GetDailySales]  @DateFrom date ,@DateTo date
as
SELECT p.StartDate,CONVERT(VARCHAR(5), p.StartTime,108) as StartTime,SUM(s.Pay1Amt)
AS Payment1,SUM(s.Pay2Amt) AS Payment2,
(SUM(s.SubTotal)) AS  TotalBeforeDiscount,
SUM(s.LineDiscounts+s.InvoiceDiscount)AS Discount,
SUM(s.ServiceValue + s.DeleveryServiceValue) as Tax
,(SUM (s.NetValue))AS Total,p.EndDate,CONVERT(VARCHAR(5), p.EndTime,108) as EndTime 
FROM SalesTotal s INNER JOIN PosBussinessDay p ON s.DayId=p.DayId
WHERE s.InvoiceDate>@DateFrom AND s.InvoiceDate<@DateTo  
GROUP BY s.DayId,p.StartDate,p.StartTime,p.EndDate,p.EndTime;
GO
/****** Object:  StoredProcedure [dbo].[GetDailyService]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[GetDailyService]  @DateFrom date ,@DateTo date
as
SELECT s.ShiftID
,s.InvoiceDate, Partner.Partner_Na as CustomerName
,s.invoiceNo, s.DeleveryServiceValue AS ServiceValue, s.ServiceValue TaxValue , MdSeller.Name SellerName
FROM SalesTotal s 
INNER JOIN Partner  on Partner.Partner_Code = s.PartnerCode
inner join MdSeller on MdSeller.SellerCode = s.SellerCode
WHERE s.InvoiceDate> @DateFrom AND s.InvoiceDate< @DateTo  and( DeleveryServiceValue!=0 or ServiceValue !=0 )
GO
/****** Object:  StoredProcedure [dbo].[GetPayedPaymentWays]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[GetPayedPaymentWays] @invoiceNumber nvarchar 
as
SELECT sum(t1.Paid1Amount) as Paid1Amount,sum(t1.Paid2Amount) as Paid2Amount FROM  SalesDetail t1 where LineRef=@invoiceNumber
GO
/****** Object:  StoredProcedure [dbo].[GetPrices]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Proc [dbo].[GetPrices]as
select Distinct mp.Barcode as Barcode,
ProductNa,
Pricewithtax,
(select top 1 dv.PriceWithDiscount from DiscountMaster Mstr  inner join DiscountByPrice dv on Mstr.ID = dv.DiscountMasterId where Mstr.DateFrom<=cast(GETDATE() as date) and  Mstr.DateTo>= cast(GETDATE() as date) and dv.ProductId=pa.Seq) as pricewithdiscount
,ISNULL((select top 1 dv.PriceWithDiscount from DiscountMaster Mstr  inner join DiscountByPrice dv on Mstr.ID=dv.DiscountMasterId where Mstr.DateFrom<=cast(GETDATE() as date) and Mstr.DateTo>=cast(GETDATE() as date) and dv.ProductId=pa.Seq),Pricewithtax)      as CurrentPrice
 from MdProduct mp 
inner join Price p on mp.ProductId=p.Productid
inner join MdProductsAttribute pa on pa.ProductId=mp.ProductId 
GO
/****** Object:  StoredProcedure [dbo].[GetPricesAttribute]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------21-01-2021---------------------------------------------------------------------
CREATE Proc [dbo].[GetPricesAttribute]
as
select Distinct pa.Barcode as Barcode,ProductNa,Pricewithtax,
(select top 1 dv.PriceWithDiscount from DiscountMaster Mstr  inner join DiscountByPrice dv on Mstr.ID = dv.DiscountMasterId 
where Mstr.DateFrom<=cast(GETDATE() as date) 
and  Mstr.DateTo>= cast(GETDATE() as date) 
and dv.ProductId=pa.Seq order by dv.ID desc) as pricewithdiscount
,ISNULL((select top 1 dv.PriceWithDiscount
 from DiscountMaster Mstr  inner join DiscountByPrice dv on Mstr.ID=dv.DiscountMasterId
 where Mstr.DateFrom<=cast(GETDATE() as date) 
 and Mstr.DateTo>=cast(GETDATE() as date) and dv.ProductId=pa.Seq order by Mstr.ID desc),Pricewithtax)      as CurrentPrice
from MdProductsAttribute pa
inner join MdProduct mp on pa.ProductId=mp.ProductId
inner join Price p on p.ProductId=pa.Seq
GO
/****** Object:  StoredProcedure [dbo].[GetSellerSeles]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[GetSellerSeles]  @DateFrom date ,@DateTo date
as
SELECT MdSeller.Name ,MdSeller.SellerCode ,
( case when  SUM(NetValue) is null then 0 else SUM(NetValue) end)NetValue 
 FROM MdSeller left join SalesTotal   ON 
 ( MdSeller.SellerCode = SalesTotal.SellerCode 
  and SalesTotal.InvoiceDate > @DateFrom
   and SalesTotal.InvoiceDate < @DateTo
  )
GROUP BY MdSeller.Name ,MdSeller.SellerCode

GO
/****** Object:  StoredProcedure [dbo].[GetSummaryReport]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[GetSummaryReport] @ActiveDate date
as
select   count(InvoiceNo)  as InvoiceCount,
 SUM(CASE WHEN SubTotal > 0 THEN ItemCount ELSE 0 END) SellItemCount ,
 SUM(CASE WHEN SubTotal < 0 THEN ItemCount ELSE 0 END) + iif( ( select SUM(Qty) from ReturnwithoutInvMaster rm inner join ReturnwithoutInvDetails rd on rm.InvoiceNo=rd.InvoiceNo
where CAST (Date as date)=@ActiveDate) is null,0,( select SUM(Qty) from ReturnwithoutInvMaster rm inner join ReturnwithoutInvDetails rd on rm.InvoiceNo=rd.InvoiceNo
where CAST (Date as date)=@ActiveDate))    ReturnItemCount   ,
----------------------------------------------------------------------------------------------------
SUM(CASE WHEN SubTotal > 0 THEN GrandTotal ELSE 0 END)
+SUM(CASE WHEN SubTotal > 0 THEN LineDiscounts ELSE 0 END)
+SUM(CASE WHEN SubTotal > 0 THEN InvoiceDiscount ELSE 0 END)
+SUM(CASE WHEN SubTotal > 0 THEN DeleveryServiceValue ELSE 0 END)
+SUM(CASE WHEN SubTotal > 0 THEN ServiceValue ELSE 0 END) as TotalSellRecicpts ,
---------------------------------------------------------------------------------------------------
SUM(CASE WHEN SubTotal > 0 THEN GrandTotal ELSE 0 END)+SUM(CASE WHEN SubTotal > 0 THEN LineDiscounts ELSE 0 END)+SUM(CASE WHEN SubTotal > 0 THEN InvoiceDiscount ELSE 0 END) as TotalSell,
---------------------------------------------------------------------------------------------------------
SUM(CASE WHEN SubTotal < 0 THEN GrandTotal ELSE 0 END)
+SUM(CASE WHEN SubTotal < 0 THEN LineDiscounts ELSE 0 END)
+SUM(CASE WHEN SubTotal < 0 THEN InvoiceDiscount ELSE 0 END)
+SUM(CASE WHEN SubTotal < 0 THEN DeleveryServiceValue ELSE 0 END)
+SUM(CASE WHEN SubTotal < 0 THEN ServiceValue ELSE 0 END) as TotalReturnRecicpts ,
---------------------------------------------------------------------------------------------------
SUM(CASE WHEN SubTotal < 0 THEN GrandTotal ELSE 0 END)+SUM(CASE WHEN SubTotal < 0 THEN LineDiscounts ELSE 0 END)+SUM(CASE WHEN SubTotal < 0 THEN InvoiceDiscount ELSE 0 END) as TotalReturn,
---------------------------------------------------------------------------------------------------------
iif( (select TotalPriceAfterDiscount from ReturnwithoutInvMaster where CAST (Date as date)=@ActiveDate) is null,0,(select TotalPriceAfterDiscount from ReturnwithoutInvMaster where CAST (Date as date)=@ActiveDate)) *-1 as ReturnswithuotInvoice,
--------------------------------------------------------------------------------------------------------
SUM(CASE WHEN SubTotal < 0 THEN GrandTotal ELSE 0 END)+SUM(CASE WHEN SubTotal < 0 THEN LineDiscounts ELSE 0 END)+SUM(CASE WHEN SubTotal < 0 THEN InvoiceDiscount ELSE 0 END) as ReturnWithInvoice,
--------------------------------------------------------------------------------------------------------
sum(LineDiscounts + InvoiceDiscount) * -1  as Discount
------------------------------------------------------------------------------------------------------------
,sum(TaxValue) as TaxValue,
 sum(Pay1Amt) as Payment1,
 sum(Pay2Amt) as Payment2,
 actives.StoreNa,actives.StoreId, SalesTotal.InvoiceDate  ,
---------------------------------------------------------------------------------------------------------------------
iif (sum(p.DayOpeningCount)/count(p.DayOpeningCount) is null , 0,sum(p.DayOpeningCount)/count(p.DayOpeningCount))as DayOpeningCount,
----------------------------------------------------------------------------------------------------------------------
    SUM(CASE WHEN SubTotal > 0 THEN DeleveryServiceValue ELSE 0 END) as SellDeleveryServiceValue,
-----------------------------------------------------------------------------------------------------------------------
SUM(CASE WHEN SubTotal > 0 THEN ServiceValue ELSE 0 END) as SellServiceValue,
-----------------------------------------------------------------------------------------------------------------------
SUM(CASE WHEN SubTotal < 0 THEN DeleveryServiceValue ELSE 0 END) as ReturnDeleveryServiceValue,
-----------------------------------------------------------------------------------------------------------------------
SUM(CASE WHEN SubTotal < 0 THEN ServiceValue ELSE 0 END) as ReturnServiceValue,
-----------------------------------------------------------------------------------------------------------------------
SUM(Remain) as Remain,
(select COUNT(id) from shift where DayId=p.DayId) as ShiftsCount
from  SalesTotal   INNER JOIN actives ON (actives.StoreId = SalesTotal.StoreId)  
inner join PosBussinessDay p on (actives.ActiveDate =p.StartDate)
where InvoiceDate >= @ActiveDate
and InvoiceDate <= @ActiveDate
group by SalesTotal.InvoiceDate,actives.StoreNa,actives.StoreId,p.DayId
GO
/****** Object:  StoredProcedure [dbo].[GetSumSalesRep]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetSumSalesRep]  @DateFrom date ,@DateTo date
as
select 
(case when Sales.DayId is null then Retrn.DayId else  Sales.DayId  end ) DayId,
(case when Sales.ShiftId is null then Retrn.ShiftId else  Sales.ShiftId  end ) ShiftId,
(case when Sales.StartDate is null then Retrn.StartDate else  Sales.StartDate  end ) StartDate,
(case when Sales.StartTime is null then Retrn.StartTime else  Sales.StartTime  end ) StartTime,
(case when Sales.EndDate is null then Retrn.EndDate else  Sales.EndDate  end ) EndDate,
(case when Sales.EndTime is null then Retrn.EndTime else  Sales.EndTime  end ) EndTime,
(case when Sales.SalesCash is null then 0 else Sales.SalesCash end ) SalesCash ,
(case when Sales.SalesCredit is null then 0 else Sales.SalesCredit end ) SalesCredit ,
(case when Sales.SalesRemaining is null then 0 else Sales.SalesRemaining end ) SalesRemaining, 
(case when Sales.SalesDiscount is null then 0 else Sales.SalesDiscount end ) SalesDiscount, 
(case when Sales.SalesIncoiceCount is null then 0 else Sales.SalesIncoiceCount end ) SalesIncoiceCount,
(case when Sales.SalesItemsCount is null then 0 else Sales.SalesItemsCount end ) SalesItemsCount,
(case when Sales.SalesServiceValue is null then 0 else Sales.SalesServiceValue end ) SalesServiceValue,
(case when Sales.SalesDeleveryValue is null then 0 else Sales.SalesDeleveryValue end ) SalesDeleveryValue,

(case when Retrn.RetrnCash is null then 0 else Retrn.RetrnCash end ) RetrnCash ,
(case when Retrn.RetrnCredit is null then 0 else Retrn.RetrnCredit end ) RetrnCredit ,
(case when Retrn.RetrnRemaining is null then 0 else Retrn.RetrnRemaining end ) RetrnRemaining, 
(case when Retrn.RetrnDiscount is null then 0 else Retrn.RetrnDiscount end ) RetrnDiscount, 
(case when Retrn.RetrnIncoiceCount is null then 0 else Retrn.RetrnIncoiceCount end ) RetrnIncoiceCount,
(case when Retrn.RetrnItemsCount is null then 0 else Retrn.RetrnItemsCount end ) RetrnItemsCount,
(case when Retrn.RetrnDeleveryValue is null then 0 else Retrn.RetrnDeleveryValue end ) RetrnDeleveryValue,
(case when Retrn.RetrnServiceValue is null then 0 else Retrn.RetrnServiceValue end ) RetrnServiceValue

from  GetSummerySalesOnlyPerDay( @DateFrom, @DateTo) Sales
full join GetSummeryReturnOnlyPerDay( @DateFrom, @DateTo) Retrn on Sales.DayId = Retrn.DayId
GO
/****** Object:  StoredProcedure [dbo].[InitialData]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InitialData]  (@Date datetime, @Comapnyid varchar(50), @storeid varchar(50), @storename nvarchar(50), 
@StorTransactionPrefix varchar(50), @AdminPassword varchar(50), @Prefix varchar(50), @PrefixReturn varchar(50))
   
AS
BEGIN
 

delete from [PosBussinessDay];

INSERT INTO [dbo].[PosBussinessDay]
           ([DayId]  ,[StartDate]  ,[StartTime]  ,[StartedBy]   ,[EndDate]  ,[EndTime]
           ,[EndedBy]  ,[InvChk]  ,[AccessPos] ,[CompanyId]  ,[StoreId]  ,[Updated]   ,[Active])

     VALUES  (1 ,@Date  ,CONVERT (time, @Date)  ,1 ,null ,null  
     ,null  ,1  ,1 ,@Comapnyid  ,@storeid  ,1 ,1);
 

delete from [Treasury];
SET IDENTITY_INSERT [dbo].[Treasury] on 
INSERT [dbo].[Treasury] ([Id], [Name], [OpeningMoney], [CurrentMoney], [StoreID], [CompanyId]) VALUES (1, N'الخزنة الرئيسية', CAST(0 AS Decimal(18, 0)), CAST(0 AS Decimal(18, 0)), @storeid, @Comapnyid)
SET IDENTITY_INSERT [dbo].[Treasury] off 

 
delete from MdPayMethod; 
INSERT [dbo].[MdPayMethod] ([PayMethodId], [PayMethodNa], [CardNoNeeded], [ClientId], [CompanyId], [StoreId], [Updated], [Active], [Lastupdate]) VALUES (1, N'فيزا ', 1, N'1', @Comapnyid, @storename, 1, 1, NULL)
INSERT [dbo].[MdPayMethod] ([PayMethodId], [PayMethodNa], [CardNoNeeded], [ClientId], [CompanyId], [StoreId], [Updated], [Active], [Lastupdate]) VALUES (2, N'ماستر', 1, N'1', @Comapnyid, @storename, 1, 1, NULL)
INSERT [dbo].[MdPayMethod] ([PayMethodId], [PayMethodNa], [CardNoNeeded], [ClientId], [CompanyId], [StoreId], [Updated], [Active], [Lastupdate]) VALUES (3, N'شيك', 1, N'1', @Comapnyid, @storename, 1, 1, NULL)


delete from [Actives];
INSERT [dbo].[Actives] ([StoreId], [StoreNa], [TaxId], [StartDate], [ActiveDate], [DayId],
               [ShiftId], [ById], [StoreType], [PriceOrDiscountPrice], [CurrencyId], [industryId],
       [CompanyId], [DaysLimitation], [VoucherApply], [LogoPath], [GrNow], [GiNow], 
    [StoreTransfer], [StorePrefix], [PasswordAdmin])
VALUES (@storeid, @storename, -1, @Date, @Date, 1, -1, 1010, N'0', 0, 0, 0, @Comapnyid, NULL, NULL, NULL, 5, 12, NULL, @StorTransactionPrefix, @AdminPassword)


delete [SysStation];
INSERT [dbo].[SysStation] ([StationId], [StationNa], [CurrencyId], [Prefix], [PrefixReturn], 
[InvoiceSeqStart], [InvoiceSeqNow], [InvoiceOnholdSeqNow], [InvoiceReturnQtyByOne], [CustomerCode], 
[CompanyId], [StoreId], [WarehouseId], [Active], [IsMaster], ReturnSeqNow) 
VALUES (1, N'POS1', 1, @Prefix, @PrefixReturn, 0, 0, 0,0, N'1',@Comapnyid,@storeid, N'1', 1, 1, 0)

INSERT [dbo].[SysStation] ([StationId], [StationNa], [CurrencyId], [Prefix], [PrefixReturn], 
[InvoiceSeqStart], [InvoiceSeqNow], [InvoiceOnholdSeqNow], [InvoiceReturnQtyByOne], [CustomerCode], 
[CompanyId], [StoreId], [WarehouseId], [Active], [IsMaster], ReturnSeqNow) 
VALUES (2, N'POS2', 1, @Prefix, @PrefixReturn, 0, 0, 0,0, N'1',@Comapnyid,@storeid, N'1', 1, 0, 0)

 
 delete from [HotKey];
 SET IDENTITY_INSERT [dbo].[HotKey] on 
INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (1, N'F1', N'Save')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (2, N'S', N'Renew')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (3, N'K', N'DeleteRow')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (4, N'Menu+E', N'Decrease')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (5, N'', N'Increase')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (6, N'F3', N'Reprint')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (7, N'F2', N'Holding')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (8, N'F6', N'SalesOrder')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (9, N'ControlKey-F1', N'Offers')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (10, N'F10', N'Exit')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (11, N'', N'CustomerDiscount')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (12, N'', N'SampleDiscount')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (13, N'ControlKey-S', N'EmployeeDiscount')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (14, N'U', N'ReturnInvoice')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (15, N'F7', N'Showproducts')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (16, N'', N'Showoffers')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (17, N'F5', N'Reports')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (18, N'F12', N'Customer')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (19, N'F8', N'Inventory')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (20, N'F9', N'Closeday')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (21, N'B', N'Keyboardshortcut')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (22, N'F11', N'OpenClosePeriod')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (23, N'W', N'TrnsferMoney')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (24, N'T', N'ReturnWithoutInvoice')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (25, N'L', N'PosponedCustomer')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (26, N'P', N'FocusBarcode')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (27, N'I', N'Sync')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (28, N'O', N'IncreaseDelvery')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (29, N'J', N'DecreaseDelvery')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (30, N'M', N'Payed')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (31, N'X', N'Card')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (32, N'Y', N'CheckHold')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (33, N'Z', N'PrintSettingScreen')

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (34, N'Menu, Alt+F10', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (35, N'Menu, Alt+F11', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (36, N'Menu, Alt+F12', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (37, N'ShiftKey, Shift+F1', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (38, N'ShiftKey, Shift+F2', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (39, N'ShiftKey, Shift+F3', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (40, N'ShiftKey, Shift+F4', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (41, N'ShiftKey, Shift+F5', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (42, N'ShiftKey, Shift+F6', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (43, N'ShiftKey, Shift+F7', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (44, N'ShiftKey, Shift+F8', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (45, N'ShiftKey, Shift+F9', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (46, N'ShiftKey, Shift+F10', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (47, N'ShiftKey, Shift+F11', NULL)

INSERT [dbo].[HotKey] ([Id], [HotKeyButton], [Operation]) VALUES (48, N'ShiftKey, Shift+F12', NULL)
END;
GO
/****** Object:  StoredProcedure [dbo].[P_GetShiftInfoByMacAddress]    Script Date: 2/27/2021 2:01:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  Proc [dbo].[P_GetShiftInfoByMacAddress] 
@MacAddreess nvarchar(100),
@UserId int null
as
--Get Shift Info For Report after close day and if used it in Reports
if @UserId is null
select top 1 s.ID,
-------------------------------------------------------------------------------------
iif((select COUNT (InvoiceNo) from SalesTotal where ShiftID=s.ID) is not null,(select COUNT (InvoiceNo) from SalesTotal where ShiftID=s.ID),0) as InvoiceCount,
-------------------------------------------------------------------------------------
iif(
(select SUM(CASE WHEN SubTotal > 0 THEN ItemCount ELSE 0 END) from SalesTotal where ShiftID=s.ID) is not null ,
(select SUM(CASE WHEN SubTotal > 0 THEN ItemCount ELSE 0 END) from SalesTotal where ShiftID=s.ID),0) 
as SellItemCount,
-------------------------------------------------------------------------------------
iif(
(select  SUM(CASE WHEN SubTotal < 0 THEN ItemCount ELSE 0 END)from SalesTotal where ShiftID=s.ID) is not null,
(select  SUM(CASE WHEN SubTotal < 0 THEN ItemCount ELSE 0 END)from SalesTotal where ShiftID=s.ID) ,0) 
as ReturnItemCount,
-------------------------------------------------------------------------------------
iif(
((select SUM(CASE WHEN SubTotal > 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select  SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2) +
(select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2)) is not null,

((select SUM(CASE WHEN SubTotal > 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select  SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2)+(select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID  and invoicetype!=2))
,0) as TotalSellRecicpts ,--اجمالي مبيعات
--------------------------------------------------------------------------------------
iif(
((select SUM(CASE WHEN SubTotal > 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)) is not null ,

((select SUM(CASE WHEN SubTotal > 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID))
,0)
as TotalSell,-- اجمالي مبيعات بالفاتورة
---------------------------------------------------------------------------------------------------
iif(
((select SUM(CASE WHEN SubTotal < 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal < 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal < 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select  SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2) +
(select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2)) is not null,

((select SUM(CASE WHEN SubTotal < 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal < 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal < 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select  SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2)+
(select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID  and invoicetype=2))
,0) as TotalReturnRecicpts , -- اجمالي المردودات
----------------------------------------------------------------------------------------------------
iif(
((select SUM(CASE WHEN SubTotal < 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal < 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID) +
(select SUM(CASE WHEN SubTotal < 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)) is not null, 

((select SUM(CASE WHEN SubTotal < 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal < 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID) +
(select SUM(CASE WHEN SubTotal < 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)),0) 
as ReturnWithInvoice, -- اجمالي مردودات بالفاتورة
--------------------------------------------------------------------------------------
iif((select sum(LineDiscounts + InvoiceDiscount) * -1 from SalesTotal where ShiftID=s.ID) is not null 
,(select sum(LineDiscounts + InvoiceDiscount) * -1 from SalesTotal where ShiftID=s.ID),0)
as Discount,
-----------------------------------------------------------------------------
iif( (select SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2) is not null
,(select SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2),0) 
as SellDeleveryServiceValue,
------------------------------------------------------------------------------------
iif((select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2) is not null 
, (select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2),0)
 as SellServiceValue,
----------------------------------------------------------------------------------
iif( (select SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2) is not null
,(select SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2),0) 
as ReturnDeleveryServiceValue,
------------------------------------------------------------------------------------
iif((select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2) is not null 
, (select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2),0) 
as ReturnServiceValue,
----------------------------------------------------------------------------------
iif((select sum(Pay1Amt) from SalesTotal where ShiftID=s.ID) is not null
,(select sum(Pay1Amt) from SalesTotal where ShiftID=s.ID),0) 
as Payment1,
---------------------------------------------------------------------------------
iif((select sum(Pay2Amt) from SalesTotal where ShiftID=s.ID) is not null
,(select sum(Pay2Amt) from SalesTotal where ShiftID=s.ID),0) 
as Payment2,
----------------------------------------------------------------------------------
iif((select SUM(Remain) from SalesTotal where ShiftID=s.ID) is not null 
,(select SUM(Remain) from SalesTotal where ShiftID=s.ID),0) 
as Remain,
--------------------------------------------------------------------------------------
 md1.Name as UserOpenShift,
 md2.Name as UserCloseShift ,
 s.StartDate ,
 s.EndDate,
 s.StartTime,
 s.EndTime,
 s.MoneyStartInStair,
 IIF(s.DifferanceValue is null,0,s.DifferanceValue) as DifferanceValue,
 s.MoneyEndInStair,
 iif(s.MoneyTransferd is null,
 0,
 s.MoneyTransferd)as MoneyTransferd
,st.SubWHNa as StoreName
from Shift s inner join  MdSeller md1 on s.OpenUserID= md1.SellerCode
inner join MdSeller md2 on s.CloseUserID= md2.SellerCode
inner join Storewarehouse st on s.StoreId=st.SubWHId
where s.MacAddress=@MacAddreess
order by ID desc
else 
select top 1 s.ID, 
-------------------------------------------------------------------------------------
iif((select COUNT (InvoiceNo) from SalesTotal where ShiftID=s.ID) is not null,(select COUNT (InvoiceNo) from SalesTotal where ShiftID=s.ID),0) as InvoiceCount,
-------------------------------------------------------------------------------------
iif(
(select SUM(CASE WHEN SubTotal > 0 THEN ItemCount ELSE 0 END) from SalesTotal where ShiftID=s.ID) is not null ,
(select SUM(CASE WHEN SubTotal > 0 THEN ItemCount ELSE 0 END) from SalesTotal where ShiftID=s.ID),0) as SellItemCount,
-------------------------------------------------------------------------------------
iif(
(select  SUM(CASE WHEN SubTotal < 0 THEN ItemCount ELSE 0 END)from SalesTotal where ShiftID=s.ID) is not null,
(select  SUM(CASE WHEN SubTotal < 0 THEN ItemCount ELSE 0 END)from SalesTotal where ShiftID=s.ID) ,0) as ReturnItemCount,
-------------------------------------------------------------------------------------
iif(
((select SUM(CASE WHEN SubTotal > 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select  SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2) +(select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2)) is not null,

((select SUM(CASE WHEN SubTotal > 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select  SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2)+(select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID  and invoicetype!=2))
,0) as TotalSellRecicpts ,
--------------------------------------------------------------------------------------
iif(
((select SUM(CASE WHEN SubTotal > 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)) is not null ,

((select SUM(CASE WHEN SubTotal > 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal > 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID))
,0)
as TotalSell,
---------------------------------------------------------------------------------------------------
iif(
((select SUM(CASE WHEN SubTotal < 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal < 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal < 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select  SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2) +(select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2)) is not null,

((select SUM(CASE WHEN SubTotal < 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal < 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal < 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select  SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2)+(select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID  and invoicetype=2))
,0) as TotalReturnRecicpts ,
----------------------------------------------------------------------------------------------------
iif(
((select SUM(CASE WHEN SubTotal < 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal < 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID) +
(select SUM(CASE WHEN SubTotal < 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)) is not null, 

((select SUM(CASE WHEN SubTotal < 0 THEN GrandTotal ELSE 0 END)from SalesTotal where ShiftID=s.ID)+
(select SUM(CASE WHEN SubTotal < 0 THEN LineDiscounts ELSE 0 END)from SalesTotal where ShiftID=s.ID) +
(select SUM(CASE WHEN SubTotal < 0 THEN InvoiceDiscount ELSE 0 END)from SalesTotal where ShiftID=s.ID)),0) as ReturnWithInvoice,
--------------------------------------------------------------------------------------
iif((select sum(LineDiscounts + InvoiceDiscount) * -1 from SalesTotal where ShiftID=s.ID) is not null ,(select sum(LineDiscounts + InvoiceDiscount) * -1 from SalesTotal where ShiftID=s.ID),0)as Discount,
-----------------------------------------------------------------------------
iif( (select SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2) is not null,(select SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2),0) as SellDeleveryServiceValue,
------------------------------------------------------------------------------------
iif((select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2) is not null , (select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype!=2),0) as SellServiceValue,
----------------------------------------------------------------------------------
iif( (select SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2) is not null,(select SUM(DeleveryServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2),0) as ReturnDeleveryServiceValue,
------------------------------------------------------------------------------------
iif((select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2) is not null , (select SUM(ServiceValue) from SalesTotal where ShiftID=s.ID and invoicetype=2),0) as ReturnServiceValue,
----------------------------------------------------------------------------------
iif((select sum(Pay1Amt) from SalesTotal where ShiftID=s.ID) is not null,(select sum(Pay1Amt) from SalesTotal where ShiftID=s.ID),0) as Payment1,
---------------------------------------------------------------------------------
iif((select sum(Pay2Amt) from SalesTotal where ShiftID=s.ID) is not null,(select sum(Pay2Amt) from SalesTotal where ShiftID=s.ID),0) as Payment2,
----------------------------------------------------------------------------------
iif((select SUM(Remain) from SalesTotal where ShiftID=s.ID) is not null ,(select SUM(Remain) from SalesTotal where ShiftID=s.ID),0) as Remain,
--------------------------------------------------------------------------------------
st.SubWHNa as StoreName
from Shift s inner join  MdSeller md1 on s.OpenUserID= md1.SellerCode
inner join MdSeller md2 on s.CloseUserID= md2.SellerCode
inner join Storewarehouse st on s.StoreId=st.SubWHId
where s.MacAddress=@MacAddreess and s.OpenUserID=@UserId
order by ID desc
 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Mstr"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DisCust"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 428
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Cust"
            Begin Extent = 
               Top = 6
               Left = 466
               Bottom = 136
               Right = 636
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_GetValidCustomerDiscount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_GetValidCustomerDiscount'
GO
USE [master]
GO
ALTER DATABASE [Bayan2] SET  READ_WRITE 
GO
