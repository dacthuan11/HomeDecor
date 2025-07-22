USE [master]
GO
/****** Object:  Database [home_decor]    Script Date: 7/22/2025 12:18:53 PM ******/
CREATE DATABASE [home_decor]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'home_decor', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\home_decor.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'home_decor_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\home_decor_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [home_decor] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [home_decor].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [home_decor] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [home_decor] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [home_decor] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [home_decor] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [home_decor] SET ARITHABORT OFF 
GO
ALTER DATABASE [home_decor] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [home_decor] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [home_decor] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [home_decor] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [home_decor] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [home_decor] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [home_decor] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [home_decor] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [home_decor] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [home_decor] SET  ENABLE_BROKER 
GO
ALTER DATABASE [home_decor] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [home_decor] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [home_decor] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [home_decor] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [home_decor] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [home_decor] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [home_decor] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [home_decor] SET RECOVERY FULL 
GO
ALTER DATABASE [home_decor] SET  MULTI_USER 
GO
ALTER DATABASE [home_decor] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [home_decor] SET DB_CHAINING OFF 
GO
ALTER DATABASE [home_decor] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [home_decor] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [home_decor] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [home_decor] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'home_decor', N'ON'
GO
ALTER DATABASE [home_decor] SET QUERY_STORE = ON
GO
ALTER DATABASE [home_decor] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [home_decor]
GO
/****** Object:  Table [dbo].[cart]    Script Date: 7/22/2025 12:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](12, 2) NOT NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categories]    Script Date: 7/22/2025 12:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_details]    Script Date: 7/22/2025 12:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_details](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[product_id] [int] NULL,
	[quantity] [int] NULL,
	[price] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 7/22/2025 12:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[order_date] [datetime] NULL,
	[total] [float] NULL,
	[status] [varchar](20) NULL,
	[customer_name] [varchar](255) NULL,
	[customer_address] [text] NULL,
	[customer_phone] [varchar](20) NULL,
	[customer_email] [varchar](255) NULL,
	[payment_method] [varchar](50) NULL,
	[total_price] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 7/22/2025 12:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[price] [float] NOT NULL,
	[description] [nvarchar](max) NULL,
	[image] [varchar](255) NULL,
	[category_id] [int] NULL,
	[status] [bit] NULL,
	[stock] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 7/22/2025 12:18:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](255) NOT NULL,
	[email] [varchar](100) NULL,
	[role] [varchar](10) NULL,
	[active] [bit] NULL,
	[avatar] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[cart] ON 
GO
INSERT [dbo].[cart] ([id], [user_id], [product_id], [quantity], [price], [created_at], [updated_at]) VALUES (1086, 1, 8, 1, CAST(890000.00 AS Decimal(12, 2)), CAST(N'2025-07-22T11:06:16.483' AS DateTime), CAST(N'2025-07-22T11:06:16.483' AS DateTime))
GO
INSERT [dbo].[cart] ([id], [user_id], [product_id], [quantity], [price], [created_at], [updated_at]) VALUES (1088, 1, 15, 1, CAST(1150000.00 AS Decimal(12, 2)), CAST(N'2025-07-22T11:13:52.520' AS DateTime), CAST(N'2025-07-22T11:13:52.520' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[cart] OFF
GO
SET IDENTITY_INSERT [dbo].[categories] ON 
GO
INSERT [dbo].[categories] ([id], [name]) VALUES (1, N'Đèn trang trí và đồng hồ treo tường  ')
GO
INSERT [dbo].[categories] ([id], [name]) VALUES (2, N'Tranh treo tường')
GO
INSERT [dbo].[categories] ([id], [name]) VALUES (3, N'Đồ gốm sứ & gương')
GO
SET IDENTITY_INSERT [dbo].[categories] OFF
GO
SET IDENTITY_INSERT [dbo].[order_details] ON 
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (1, 1, 9, 4, 470000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (2, 1, 8, 3, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (3, 2, 8, 1, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (4, 3, 12, 1, 430000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (5, 3, 9, 1, 470000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (6, 3, 8, 1, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (7, 4, 9, 1, 470000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (8, 4, 10, 1, 520000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (9, 5, 8, 1, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (10, 6, 9, 3, 470000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (11, 6, 8, 4, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (12, 7, 8, 1, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (13, 8, 8, 4, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (14, 9, 8, 4, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (15, 10, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (16, 11, 16, 1, 780000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (17, 11, 8, 8, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (18, 11, 10, 1, 520000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (19, 12, 8, 1, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (20, 13, 8, 1, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (21, 14, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (22, 15, 8, 1, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (23, 16, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (24, 17, 8, 1, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (25, 18, 8, 1, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (26, 19, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (27, 20, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (28, 21, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (29, 22, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (30, 23, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (31, 24, 8, 4, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (32, 25, 8, 1, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (33, 26, 8, 1, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (34, 27, 8, 3, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (35, 28, 8, 1, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (36, 29, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (37, 30, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (38, 31, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (39, 32, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (40, 33, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (41, 34, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (42, 35, 8, 2, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (43, 36, 8, 3, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (44, 37, 8, 1, 890000)
GO
INSERT [dbo].[order_details] ([id], [order_id], [product_id], [quantity], [price]) VALUES (45, 38, 8, 2, 890000)
GO
SET IDENTITY_INSERT [dbo].[order_details] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (1, 1, CAST(N'2025-07-17T23:22:34.087' AS DateTime), 4550000, N'Shipped', N'admin', N'123', N'123', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (2, 1, CAST(N'2025-07-17T23:25:29.253' AS DateTime), 890000, N'In Transit', N'admin', N'123', N'123', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (3, 2, CAST(N'2025-07-17T23:54:25.783' AS DateTime), 1790000, N'Ðã giao', N'alice', N'123', N'123', N'alice@gmail.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (4, 2, CAST(N'2025-07-18T00:25:34.123' AS DateTime), 990000, N'Pending', N'alice', N'123', N'123', N'alice@gmail.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (5, 2, CAST(N'2025-07-18T00:26:15.030' AS DateTime), 890000, N'Pending', N'alice', N'123', N'123', N'alice@gmail.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (6, 1, CAST(N'2025-07-18T00:45:31.897' AS DateTime), 4970000, N'Pending', N'admin', N'123', N'123', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (7, 1, CAST(N'2025-07-18T00:47:01.697' AS DateTime), 890000, N'Pending', N'admin', N'123', N'123', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (8, 1, CAST(N'2025-07-18T00:47:44.013' AS DateTime), 3560000, N'Pending', N'admin', N'123', N'123', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (9, 1, CAST(N'2025-07-18T09:40:13.950' AS DateTime), 3560000, N'Ðang v?n chuy?n', N'admin', N'123', N'123', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (10, 1, CAST(N'2025-07-19T16:20:59.227' AS DateTime), 1246000, N'Ðã giao', N'admin', N'123', N'123', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (11, 1, CAST(N'2025-07-21T05:32:40.203' AS DateTime), 5894000, N'Pending', N'admin', N'123', N'123', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (12, 1, CAST(N'2025-07-21T05:36:26.747' AS DateTime), 890000, N'Pending', N'admin', N'123', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (13, 1, CAST(N'2025-07-21T05:44:24.587' AS DateTime), 890000, N'Pending', N'admin', N'123', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (14, 1, CAST(N'2025-07-21T05:47:44.127' AS DateTime), 1246000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (15, 1, CAST(N'2025-07-21T15:11:05.873' AS DateTime), 890000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (16, 1, CAST(N'2025-07-21T15:17:14.350' AS DateTime), 1246000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (17, 1, CAST(N'2025-07-21T15:20:24.600' AS DateTime), 890000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (18, 1, CAST(N'2025-07-21T15:20:31.113' AS DateTime), 890000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (19, 1, CAST(N'2025-07-22T01:59:56.063' AS DateTime), 1246000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (20, 1, CAST(N'2025-07-22T02:50:19.167' AS DateTime), 1246000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (21, 1, CAST(N'2025-07-22T02:58:56.970' AS DateTime), 1246000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (22, 1, CAST(N'2025-07-22T03:01:32.580' AS DateTime), 1246000, N'Cancelled', N'admin', N'1', N'0945933155', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (23, 1, CAST(N'2025-07-22T03:39:11.833' AS DateTime), 1246000, N'Cancelled', N'admin', N'12', N'0945933155', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (24, 1, CAST(N'2025-07-22T03:39:55.850' AS DateTime), 2492000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (25, 1, CAST(N'2025-07-22T03:40:40.530' AS DateTime), 890000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (26, 1, CAST(N'2025-07-22T03:41:02.073' AS DateTime), 890000, N'Cancelled', N'admin', N'1223', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (27, 1, CAST(N'2025-07-22T03:41:16.513' AS DateTime), 1868999.9999999998, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (28, 1, CAST(N'2025-07-22T03:42:00.337' AS DateTime), 890000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (29, 1, CAST(N'2025-07-22T03:44:09.527' AS DateTime), 1246000, N'Cancelled', N'admin', N'1', N'0945933155', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (30, 1, CAST(N'2025-07-22T03:53:16.197' AS DateTime), 1246000, N'Cancelled', N'admin', N'1', N'0945933155', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (31, 1, CAST(N'2025-07-22T04:01:50.833' AS DateTime), 1246000, N'Cancelled', N'admin', N'1', N'0945933155', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (32, 1, CAST(N'2025-07-22T04:11:55.060' AS DateTime), 1246000, N'Cancelled', N'admin', N'1', N'0945933155', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (33, 1, CAST(N'2025-07-22T04:19:36.040' AS DateTime), 1246000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (34, 1, CAST(N'2025-07-22T04:24:27.067' AS DateTime), 1246000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (35, 1, CAST(N'2025-07-22T04:33:33.983' AS DateTime), 1246000, N'Cancelled', N'admin', N'1', N'0945933155', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (36, 2, CAST(N'2025-07-22T10:01:50.417' AS DateTime), 1868999.9999999998, N'Cancelled', N'alice', N'12', N'0945933155', N'alice@gmail.com', N'COD', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (37, 1, CAST(N'2025-07-22T10:12:58.417' AS DateTime), 890000, N'Cancelled', N'admin', N'123', N'0945933155', N'admin@decor.com', N'BankTransfer', NULL)
GO
INSERT [dbo].[orders] ([id], [user_id], [order_date], [total], [status], [customer_name], [customer_address], [customer_phone], [customer_email], [payment_method], [total_price]) VALUES (38, 1, CAST(N'2025-07-22T11:05:59.710' AS DateTime), 1246000, N'Cancelled', N'admin', N'1123', N'0945933155', N'admin@decor.com', N'BankTransfer', NULL)
GO
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[products] ON 
GO
INSERT [dbo].[products] ([id], [name], [price], [description], [image], [category_id], [status], [stock]) VALUES (8, N'Tranh canvas hiện đại', 890000, N'Tranh treo tường trừu tượng', N'tranh_modern.jpg', 2, 1, 54)
GO
INSERT [dbo].[products] ([id], [name], [price], [description], [image], [category_id], [status], [stock]) VALUES (9, N'Bình gốm Nhật Bản', 470000, N'Bình gốm cao cấp, thủ công', N'gom_nhat.jpg', 3, 1, 100)
GO
INSERT [dbo].[products] ([id], [name], [price], [description], [image], [category_id], [status], [stock]) VALUES (10, N'Đèn mây tre đan', 520000, N'Đèn thủ công từ chất liệu mây tre thân thiện', N'den_maytre.jpg', 1, 1, 50)
GO
INSERT [dbo].[products] ([id], [name], [price], [description], [image], [category_id], [status], [stock]) VALUES (11, N'Gương nghệ thuật', 990000, N'Gương decor viền vàng sang trọng', N'guong_nghethuat.jpg', 2, 1, 50)
GO
INSERT [dbo].[products] ([id], [name], [price], [description], [image], [category_id], [status], [stock]) VALUES (12, N'Tượng hươu trang trí', 430000, N'Tượng hươu vàng cao cấp đặt kệ tivi', N'tuong_huou.jpg', 3, 1, 50)
GO
INSERT [dbo].[products] ([id], [name], [price], [description], [image], [category_id], [status], [stock]) VALUES (13, N'Khung ảnh gỗ cổ điển', 350000, N'Khung ảnh handmade từ gỗ thông', N'khung_go.jpg', 2, 1, 50)
GO
INSERT [dbo].[products] ([id], [name], [price], [description], [image], [category_id], [status], [stock]) VALUES (14, N'Cây giả decor', 300000, N'Cây xanh giả nhỏ để bàn, tăng sinh khí', N'cay_gia.jpg', 2, 1, 50)
GO
INSERT [dbo].[products] ([id], [name], [price], [description], [image], [category_id], [status], [stock]) VALUES (15, N'Thảm trải sàn vintage', 1150000, N'Thảm phòng khách họa tiết cổ điển', N'tham_vintage.jpg', 3, 1, 50)
GO
INSERT [dbo].[products] ([id], [name], [price], [description], [image], [category_id], [status], [stock]) VALUES (16, N'Đồng hồ treo tường decor', 780000, N'Đồng hồ lớn phong cách Bắc Âu', N'dongho_tuong.jpg', 2, 1, 50)
GO
SET IDENTITY_INSERT [dbo].[products] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 
GO
INSERT [dbo].[users] ([id], [username], [password], [email], [role], [active], [avatar]) VALUES (1, N'admin', N'6b51d431df5d7f141cbececcf79edf3dd861c3b4069f0b11661a3eefacbba918', N'admin@decor.com', N'admin', 0, N'1752927664660_31019008-20f9-4805-b31a-374e09bac8b0.jfif')
GO
INSERT [dbo].[users] ([id], [username], [password], [email], [role], [active], [avatar]) VALUES (2, N'alice', N'3b64db95cb55c763391c707108489ae18b4112d783300de38e033b4c98c3deaf', N'alice@gmail.com', N'user', 0, N'1752928156826_5ae208ce737de3ecbbf23764e1194249.jpg')
GO
INSERT [dbo].[users] ([id], [username], [password], [email], [role], [active], [avatar]) VALUES (3, N'guest', N'84983c60f7daadc1cb8698621f802c0d9f9a3c3c295c810748fb048115c186ec', NULL, N'guest', 0, NULL)
GO
INSERT [dbo].[users] ([id], [username], [password], [email], [role], [active], [avatar]) VALUES (4, N'dacthuan', N'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', N'toikshaylam1@gmail.com', N'user', 0, NULL)
GO
INSERT [dbo].[users] ([id], [username], [password], [email], [role], [active], [avatar]) VALUES (5, N'giacmo', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'a@gmail.com', N'user', 0, NULL)
GO
INSERT [dbo].[users] ([id], [username], [password], [email], [role], [active], [avatar]) VALUES (43, N'instructor', N'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b', N'a@gmail.com', N'user', 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__F3DBC572DC0465A6]    Script Date: 7/22/2025 12:18:53 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cart] ADD  DEFAULT ((1)) FOR [quantity]
GO
ALTER TABLE [dbo].[cart] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[cart] ADD  DEFAULT (getdate()) FOR [updated_at]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT (getdate()) FOR [order_date]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[products] ADD  DEFAULT ((0)) FOR [stock]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ('user') FOR [role]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [active]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD  CONSTRAINT [fk_cart_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[cart] CHECK CONSTRAINT [fk_cart_product]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD  CONSTRAINT [fk_cart_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[cart] CHECK CONSTRAINT [fk_cart_user]
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([id])
GO
ALTER TABLE [dbo].[order_details]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[products] ([id])
GO
ALTER TABLE [dbo].[orders]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[products]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[categories] ([id])
GO
USE [master]
GO
ALTER DATABASE [home_decor] SET  READ_WRITE 
GO
