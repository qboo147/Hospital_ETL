CREATE TABLE [dbo].[DimAnaemia](
	[RAISED CARDIAC ENZYMES] [bit] NULL,
	[SEVERE ANAEMIA] [bit] NULL,
	[ANAEMIA] [bit] NULL,
	[DM] [bit] NULL,
	[CAD] [bit] NULL,
	[HTN] [bit] NULL,
	[PRIOR CMP] [bit] NULL,
	[CKD] [bit] NULL,
	[AnaemiaID] [int] primary key,
)
GO


CREATE TABLE [dbo].[DimDiagnosis](
	[STABLE ANGINA] [bit] NULL,
	[ACS] [bit] NULL,
	[STEMI] [bit] NULL,
	[ATYPICAL CHEST PAIN] [bit] NULL,
	[HEART FAILURE] [bit] NULL,
	[HFREF] [bit] NULL,
	[HFNEF] [bit] NULL,
	[VALVULAR] [bit] NULL,
	[CHB] [bit] NULL,
	[SSS] [bit] NULL,
	[AKI] [bit] NULL,
	[CVA INFRACT] [bit] NULL,
	[CVA BLEED] [bit] NULL,
	[AF] [bit] NULL,
	[VT] [bit] NULL,
	[PSVT] [bit] NULL,
	[CONGENITAL] [bit] NULL,
	[UTI] [bit] NULL,
	[NEURO CARDIOGENIC SYNCOPE] [bit] NULL,
	[ORTHOSTATIC] [bit] NULL,
	[INFECTIVE ENDOCARDITIS] [bit] NULL,
	[DVT] [bit] NULL,
	[CARDIOGENIC SHOCK] [bit] NULL,
	[SHOCK] [bit] NULL,
	[PULMONARY EMBOLISM] [bit] NULL,
	[CHEST INFECTION] [bit] NULL,
	[DiagnosisID] [int] primary key,
)
GO


CREATE TABLE [dbo].[DimHabbit](
	[HabbitID] [int] primary key,
	[HabbitName] [varchar](50) NULL,
	[SMOKING] [bit] NULL,
	[ALCOHO] [bit] NULL
)
GO

CREATE TABLE [dbo].[DimPersonHealth](
	[HB] decimal(7,2) NULL,
	[TLC] decimal(7,2) NULL,
	[PLATELETS] decimal(7,2) NULL,
	[GLUCOSE] decimal(7,2) NULL,
	[UREA] decimal(7,2) NULL,
	[CREATININE] decimal(7,2) NULL,
	[BNP] int NULL,
	[PersonHealthID] int primary key,
)
GO

CREATE TABLE [dbo].[DimPerson](
	[AGE] [int] NULL,
	[GENDER] [nvarchar](255) NULL,
	[RURAL] [nvarchar](255) NULL,
	[PersonID] [int] primary key,
)
GO


CREATE TABLE dbo.DimDate (
   [DateKey]  int   NOT NULL
,  [Date]  smalldatetime   NULL
,  [DayOfWeek]  tinyint   NOT NULL
,  [DayName]  varchar(9)   NOT NULL
,  [DayOfMonth]  tinyint   NOT NULL
,  [DayOfYear]  smallint   NOT NULL
,  [WeekOfYear]  tinyint   NOT NULL
,  [MonthName]  varchar(9)   NOT NULL
,  [MonthOfYear]  tinyint   NOT NULL
,  [Quarter]  tinyint   NOT NULL
,  [Year]  smallint   NOT NULL
,  [IsWeekday]  char(7)  DEFAULT '0' NOT NULL
, CONSTRAINT [PK_dbo.DimDate] PRIMARY KEY CLUSTERED 
( [DateKey] )
) ON [PRIMARY]
;
GO

CREATE TABLE [dbo].[FactAdmissionReport](
	[SNO] [int] primary key,
	[MRD No#] [int],
	[AdmissionDateID] [int] references DimDate(DateKey),
	[DischargeDateID] [int] references DimDate(DateKey),
	[PersonID] [int] references DimPerson(PersonID) ,
	[PersonHealthID] [int] references DimPersonHealth(PersonHealthID),
	[AnaemiaID] [int] references DimAnaemia(AnaemiaID),
	[HabbitID] [int] references DimHabbit(HabbitID),
	[TYPE OF ADMISSION-EMERGENCY/OPD] nvarchar(255),
    [OUTCOME] nvarchar(255)
)

GO
CREATE TABLE [dbo].[FactDiagnosisReport](
	[SNO] [int] primary key,
	[MRD No#] [int],
	[AdmissionDateID] [int] references DimDate(DateKey),
	[DischargeDateID] [int] references DimDate(DateKey),
	[PersonID] [int] references DimPerson(PersonID),
	[PersonHealthID] [int] references DimPersonHealth(PersonHealthID),
	[AnaemiaID] [int] references DimAnaemia(AnaemiaID),
	[DiagnosisID] [int] references DimDiagnosis(DiagnosisID)
)

DELETE FROM DimPerson
DELETE FROM DimAnaemia
DELETE FROM DimDiagnosis
DELETE FROM DimHabbit
DELETE FROM DimPersonHealth
DELETE FROM FactAdmissionReport
DELETE FROM FactDiagnosisReport

DELETE FROM StgAdmissionReport
DELETE FROM StgDiagnosisReport

DROP TABLE DimPersonHealth
DROP TABLE FactAdmissionReport
DROP TABLE FactDiagnosisReport