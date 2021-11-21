/* database
user id : team15
password: team15
dbname : team15
*/

-- create tables

-- Create original table : Done by Haengbok Chung
CREATE TABLE original (
ID VARCHAR(4),
Name VARCHAR(59),
Sex VARCHAR(3),
Age VARCHAR(3),
Height VARCHAR(6),
Weight VARCHAR(6),
Team VARCHAR(32),
NOC VARCHAR(3),
Games VARCHAR(11),
Year VARCHAR(4),
Season VARCHAR(6),
City VARCHAR(22),
Sport VARCHAR(21),
Event VARCHAR(69),
Medal VARCHAR(6)   
);

-- Create Athletes table : Done by Haengbok Chung 
CREATE TABLE Athletes (
id INTEGER(6) PRIMARY KEY NOT NULL AUTO_INCREMENT,
name VARCHAR(30) NOT NULL,
sex VARCHAR(30) NOT NULL,
age INTEGER(3) NOT NULL,
height INTEGER(3) NOT NULL,
weight INTEGER(3) NOT NULL,
team VARCHAR(30) NOT NULL,
NOC CHAR(3)
);
--add foreign key <<<<<<<<<<<<<<<<<<<<<<< error!!!!!!!!!!!!!!!!!!!!!
ALTER TABLE athletes ADD FOREIGN KEY(NOC) REFERENCES region(NOC) ON DELETE CASCADE ON UPDATE CASCADE;

-- Create Medals table : Done by Haengbok Chung 
CREATE TABLE Medals (
    id INTEGER(6) PRIMARY KEY NOT NULL,
    name VARCHAR(30) NOT NULL
    );

-- Create users table : Done by Haengbok Chung 
CREATE TABLE users (
    idUsers INTEGER(6) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    uidUsers TINYTEXT NOT NULL,
    emailUsers TINYTEXT NOT NULL,
    pwdUsers LONGTEXT NOT NULL
    );

-- Create Registration table : Done by Haengbok Chung 
CREATE TABLE Registration (
    id INTEGER(6) PRIMARY KEY NOT NULL,
    event_id INTEGER(6) NOT NULL,
    user_id INTEGER(6) NOT NULL,
    team_id INTEGER(6) NOT NULL,
    date DateTime NOT NULL
    );

-- Create Region table : Done by Jeongwon Eom
CREATE TABLE Region(
	NOC CHAR(3) NOT NULL,
	Region VARCHAR(60) NOT NULL,
	Notes VARCHAR(30),
	PRIMARY KEY(NOC)
	#(add later)FOREIGN KEY(ID) REFERENCES User(ID) ON DELETE NO ACTION 
);

-- Create Countries table : Done by Jeongwon Eom
CREATE TABLE Countries(
	#ID INT NOT NULL,
	Name VARCHAR(60) NOT NULL,
	SortName CHAR(3) NOT NULL,
	PRIMARY KEY(SortName)
);

-- Create Cities table : Done by Jeongwon Eom
CREATE TABLE Cities(
	Name VARCHAR(60) NOT NULL,
	Countries_ID CHAR(3) NOT NULL,
	PRIMARY KEY(Name),
	FOREIGN KEY(Countries_ID) REFERENCES Countries(SortName) ON DELETE NO ACTION 
);

-- Create memo table : Done by Jeongwon Eom
create table memo(
    idx int(11) not null auto_increment primary key,
    subject varchar(200) not null,
    memo text not null,
    regdate date not null,
    uidUsers tinytext

);

-- Create GoldMedals_NOC view : Done by Jeongwon Eom
/* 금메달을 가장 많이 획득한 >>나라<< 랭킹*/
create view GoldMedals_NOC(NOC, Gold)
as select NOC, count(*) from original
where Medal in (select Medal from original where Medal like 'Gold%')
group by NOC;
/* GoldMedals 뷰에서 rank 함수 이용 : $sql에 넣은 내용 */
select NOC, Gold, rank() over (order by Gold desc) as Rank
from GoldMedals_NOC;


-- Create GoldMedals_Athlete view : Done by Jeongwon Eom
/* 금메달을 가장 많이 획득한 >>선수<< 랭킹*/
create view GoldMedals_Athelete(Athelete, NOC, Gold)
as select Name, NOC, count(*) from original
where Medal in (select Medal from original where Medal like 'Gold%')
group by Name;
/* GoldMedals 뷰에서 rank 함수 이용: $sql에 넣은 내용 */
select Athelete, NOC, Gold, rank() over (order by Gold desc) as Rank
from GoldMedals_Athelete;


-- Create events table : Done by Cici Suhaeni
CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `games_id` int(11) NOT NULL,
  `sport_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- Indexes for table `events`
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);
-- AUTO_INCREMENT for table `events`
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1478;
COMMIT;


-- Create Sports table : Done by Cici Suhaeni
CREATE TABLE `sports` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- Indexes for table `sports`
ALTER TABLE `sports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);
-- AUTO_INCREMENT for table `sports`
ALTER TABLE `sports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
COMMIT;

-- Create games table : Done by Cici Suhaeni
CREATE TABLE `games` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `year` int(4) NOT NULL,
  `Season_id` int(11) NOT NULL,
  `city` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




-- Create Season table : Done by Zu Hyun Lee
CREATE TABLE Season (
    id INTEGER(6) PRIMARY KEY NOT NULL,
    name VARCHAR(30) NOT NULL
    );

-- Create Result table : Done by Zu Hyun Lee
 CREATE TABLE Result (
    id INTEGER(6) PRIMARY KEY NOT NULL,
    event_id INTEGER(6) NOT NULL,
    user_id INTEGER(6) NOT NULL,
    team_id INTEGER(6) NOT NULL,
    medals_id INTEGER(1) NOT NULL
    );



-- insert data

--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--Insert Data into original table : Done by Haengbok Chung !!!!!!!!!!!!!!!!!!!!!!!!!!!
LOAD DATA LOCAL INFILE "C:\xampp\htdocs\BigDataApplication\final_desgin added\sql\original.csv" INTO TABLE original FIELDS TERMINATED BY ",";

-- Insert Data into Athletes table : Done by Haengbok Chung
INSERT INTO Athletes(name,sex,age,height,weight,team)
SELECT Name,Sex,Age,Height,Weight,Team
FROM original
GROUP BY Name;

-- Insert Data into Region table : Done by Jeongwon Eom
INSERT INTO Region VALUES (	 'AFG'	,	 'Afghanistan'	,	NULL	); 
INSERT INTO Region VALUES (	 'AHO'	,	 'Curacao'	,	 'Netherlands Antilles'	); 
INSERT INTO Region VALUES (	 'ALB'	,	 'Albania'	,	NULL	); 
INSERT INTO Region VALUES (	 'ALG'	,	 'Algeria'	,	NULL	); 
INSERT INTO Region VALUES (	 'AND'	,	 'Andorra'	,	NULL	); 
INSERT INTO Region VALUES (	 'ANG'	,	 'Angola'	,	NULL	); 
INSERT INTO Region VALUES (	 'ANT'	,	 'Antigua'	,	 'Antigua and Barbuda'	); 
INSERT INTO Region VALUES (	 'ANZ'	,	 'Australia'	,	 'Australasia'	); 
INSERT INTO Region VALUES (	 'ARG'	,	 'Argentina'	,	NULL	); 
INSERT INTO Region VALUES (	 'ARM'	,	 'Armenia'	,	NULL	); 
INSERT INTO Region VALUES (	 'ARU'	,	 'Aruba'	,	NULL	); 
INSERT INTO Region VALUES (	 'ASA'	,	 'American Samoa'	,	NULL	); 
INSERT INTO Region VALUES (	 'AUS'	,	 'Australia'	,	NULL	); 
INSERT INTO Region VALUES (	 'AUT'	,	 'Austria'	,	NULL	); 
INSERT INTO Region VALUES (	 'AZE'	,	 'Azerbaijan'	,	NULL	); 
INSERT INTO Region VALUES (	 'BAH'	,	 'Bahamas'	,	NULL	); 
INSERT INTO Region VALUES (	 'BAN'	,	 'Bangladesh'	,	NULL	); 
INSERT INTO Region VALUES (	 'BAR'	,	 'Barbados'	,	NULL	); 
INSERT INTO Region VALUES (	 'BDI'	,	 'Burundi'	,	NULL	); 
INSERT INTO Region VALUES (	 'BEL'	,	 'Belgium'	,	NULL	); 
INSERT INTO Region VALUES (	 'BEN'	,	 'Benin'	,	NULL	); 
INSERT INTO Region VALUES (	 'BER'	,	 'Bermuda'	,	NULL	); 
INSERT INTO Region VALUES (	 'BHU'	,	 'Bhutan'	,	NULL	); 
INSERT INTO Region VALUES (	 'BIH'	,	 'Bosnia and Herzegovina'	,	NULL	); 
INSERT INTO Region VALUES (	 'BIZ'	,	 'Belize'	,	NULL	); 
INSERT INTO Region VALUES (	 'BLR'	,	 'Belarus'	,	NULL	); 
INSERT INTO Region VALUES (	 'BOH'	,	 'Czech Republic'	,	 'Bohemia'	); 
INSERT INTO Region VALUES (	 'BOL'	,	 'Boliva'	,	NULL	); 
INSERT INTO Region VALUES (	 'BOT'	,	 'Botswana'	,	NULL	); 
INSERT INTO Region VALUES (	 'BRA'	,	 'Brazil'	,	NULL	); 
INSERT INTO Region VALUES (	 'BRN'	,	 'Bahrain'	,	NULL	); 
INSERT INTO Region VALUES (	 'BRU'	,	 'Brunei'	,	NULL	); 
INSERT INTO Region VALUES (	 'BUL'	,	 'Bulgaria'	,	NULL	); 
INSERT INTO Region VALUES (	 'BUR'	,	 'Burkina Faso'	,	NULL	); 
INSERT INTO Region VALUES (	 'CAF'	,	 'Central African Republic'	,	NULL	); 
INSERT INTO Region VALUES (	 'CAM'	,	 'Cambodia'	,	NULL	); 
INSERT INTO Region VALUES (	 'CAN'	,	 'Canada'	,	NULL	); 
INSERT INTO Region VALUES (	 'CAY'	,	 'Cayman Islands'	,	NULL	); 
INSERT INTO Region VALUES (	 'CGO'	,	 'Republic of Congo'	,	NULL	); 
INSERT INTO Region VALUES (	 'CHA'	,	 'Chad'	,	NULL	); 
INSERT INTO Region VALUES (	 'CHI'	,	 'Chile'	,	NULL	); 
INSERT INTO Region VALUES (	 'CHN'	,	 'China'	,	NULL	); 
INSERT INTO Region VALUES (	 'CIV'	,	 'Ivory Coast'	,	NULL	); 
INSERT INTO Region VALUES (	 'CMR'	,	 'Cameroon'	,	NULL	); 
INSERT INTO Region VALUES (	 'COD'	,	 'Democratic Republic of the Congo'	,	NULL	); 
INSERT INTO Region VALUES (	 'COK'	,	 'Cook Islands'	,	NULL	); 
INSERT INTO Region VALUES (	 'COL'	,	 'Colombia'	,	NULL	); 
INSERT INTO Region VALUES (	 'COM'	,	 'Comoros'	,	NULL	); 
INSERT INTO Region VALUES (	 'CPV'	,	 'Cape Verde'	,	NULL	); 
INSERT INTO Region VALUES (	 'CRC'	,	 'Costa Rica'	,	NULL	); 
INSERT INTO Region VALUES (	 'CRO'	,	 'Croatia'	,	NULL	); 
INSERT INTO Region VALUES (	 'CRT'	,	 'Greece'	,	 'Crete'	); 
INSERT INTO Region VALUES (	 'CUB'	,	 'Cuba'	,	NULL	); 
INSERT INTO Region VALUES (	 'CYP'	,	 'Cyprus'	,	NULL	); 
INSERT INTO Region VALUES (	 'CZE'	,	 'Czech Republic'	,	NULL	); 
INSERT INTO Region VALUES (	 'DEN'	,	 'Denmark'	,	NULL	); 
INSERT INTO Region VALUES (	 'DJI'	,	 'Djibouti'	,	NULL	); 
INSERT INTO Region VALUES (	 'DMA'	,	 'Dominica'	,	NULL	); 
INSERT INTO Region VALUES (	 'DOM'	,	 'Dominican Republic'	,	NULL	); 
INSERT INTO Region VALUES (	 'ECU'	,	 'Ecuador'	,	NULL	); 
INSERT INTO Region VALUES (	 'EGY'	,	 'Egypt'	,	NULL	); 
INSERT INTO Region VALUES (	 'ERI'	,	 'Eritrea'	,	NULL	); 
INSERT INTO Region VALUES (	 'ESA'	,	 'El Salvador'	,	NULL	); 
INSERT INTO Region VALUES (	 'ESP'	,	 'Spain'	,	NULL	); 
INSERT INTO Region VALUES (	 'EST'	,	 'Estonia'	,	NULL	); 
INSERT INTO Region VALUES (	 'ETH'	,	 'Ethiopia'	,	NULL	); 
INSERT INTO Region VALUES (	 'EUN'	,	 'Russia'	,	NULL	); 
INSERT INTO Region VALUES (	 'FIJ'	,	 'Fiji'	,	NULL	); 
INSERT INTO Region VALUES (	 'FIN'	,	 'Finland'	,	NULL	); 
INSERT INTO Region VALUES (	 'FRA'	,	 'France'	,	NULL	); 
INSERT INTO Region VALUES (	 'FRG'	,	 'Germany'	,	NULL	); 
INSERT INTO Region VALUES (	 'FSM'	,	 'Micronesia'	,	NULL	); 
INSERT INTO Region VALUES (	 'GAB'	,	 'Gabon'	,	NULL	); 
INSERT INTO Region VALUES (	 'GAM'	,	 'Gambia'	,	NULL	); 
INSERT INTO Region VALUES (	 'GBR'	,	 'UK'	,	NULL	); 
INSERT INTO Region VALUES (	 'GBS'	,	 'Guinea-Bissau'	,	NULL	); 
INSERT INTO Region VALUES (	 'GDR'	,	 'Germany'	,	NULL	); 
INSERT INTO Region VALUES (	 'GEO'	,	 'Georgia'	,	NULL	); 
INSERT INTO Region VALUES (	 'GEQ'	,	 'Equatorial Guinea'	,	NULL	); 
INSERT INTO Region VALUES (	 'GER'	,	 'Germany'	,	NULL	); 
INSERT INTO Region VALUES (	 'GHA'	,	 'Ghana'	,	NULL	); 
INSERT INTO Region VALUES (	 'GRE'	,	 'Greece'	,	NULL	); 
INSERT INTO Region VALUES (	 'GRN'	,	 'Grenada'	,	NULL	); 
INSERT INTO Region VALUES (	 'GUA'	,	 'Guatemala'	,	NULL	); 
INSERT INTO Region VALUES (	 'GUI'	,	 'Guinea'	,	NULL	); 
INSERT INTO Region VALUES (	 'GUM'	,	 'Guam'	,	NULL	); 
INSERT INTO Region VALUES (	 'GUY'	,	 'Guyana'	,	NULL	); 
INSERT INTO Region VALUES (	 'HAI'	,	 'Haiti'	,	NULL	); 
INSERT INTO Region VALUES (	 'HKG'	,	 'China'	,	 'Hong Kong'	); 
INSERT INTO Region VALUES (	 'HON'	,	 'Honduras'	,	NULL	); 
INSERT INTO Region VALUES (	 'HUN'	,	 'Hungary'	,	NULL	); 
INSERT INTO Region VALUES (	 'INA'	,	 'Indonesia'	,	NULL	); 
INSERT INTO Region VALUES (	 'IND'	,	 'India'	,	NULL	); 
INSERT INTO Region VALUES (	 'IOA'	,	 'Individual Olympic Athletes'	,	NULL	); 
INSERT INTO Region VALUES (	 'IRI'	,	 'Iran'	,	NULL	); 
INSERT INTO Region VALUES (	 'IRL'	,	 'Ireland'	,	NULL	); 
INSERT INTO Region VALUES (	 'IRQ'	,	 'Iraq'	,	NULL	); 
INSERT INTO Region VALUES (	 'ISL'	,	 'Iceland'	,	NULL	); 
INSERT INTO Region VALUES (	 'ISR'	,	 'Israel'	,	NULL	); 
INSERT INTO Region VALUES (	 'ISV'	,	 'Virgin Islands, US'	,	 'Virgin Islands'	); 
INSERT INTO Region VALUES (	 'ITA'	,	 'Italy'	,	NULL	); 
INSERT INTO Region VALUES (	 'IVB'	,	 'Virgin Islands, British'	,	NULL	); 
INSERT INTO Region VALUES (	 'JAM'	,	 'Jamaica'	,	NULL	); 
INSERT INTO Region VALUES (	 'JOR'	,	 'Jordan'	,	NULL	); 
INSERT INTO Region VALUES (	 'JPN'	,	 'Japan'	,	NULL	); 
INSERT INTO Region VALUES (	 'KAZ'	,	 'Kazakhstan'	,	NULL	); 
INSERT INTO Region VALUES (	 'KEN'	,	 'Kenya'	,	NULL	); 
INSERT INTO Region VALUES (	 'KGZ'	,	 'Kyrgyzstan'	,	NULL	); 
INSERT INTO Region VALUES (	 'KIR'	,	 'Kiribati'	,	NULL	); 
INSERT INTO Region VALUES (	 'KOR'	,	 'South Korea'	,	NULL	); 
INSERT INTO Region VALUES (	 'KOS'	,	 'Kosovo'	,	NULL	); 
INSERT INTO Region VALUES (	 'KSA'	,	 'Saudi Arabia'	,	NULL	); 
INSERT INTO Region VALUES (	 'KUW'	,	 'Kuwait'	,	NULL	); 
INSERT INTO Region VALUES (	 'LAO'	,	 'Laos'	,	NULL	); 
INSERT INTO Region VALUES (	 'LAT'	,	 'Latvia'	,	NULL	); 
INSERT INTO Region VALUES (	 'LBA'	,	 'Libya'	,	NULL	); 
INSERT INTO Region VALUES (	 'LBR'	,	 'Liberia'	,	NULL	); 
INSERT INTO Region VALUES (	 'LCA'	,	 'Saint Lucia'	,	NULL	); 
INSERT INTO Region VALUES (	 'LES'	,	 'Lesotho'	,	NULL	); 
INSERT INTO Region VALUES (	 'LIB'	,	 'Lebanon'	,	NULL	); 
INSERT INTO Region VALUES (	 'LIE'	,	 'Liechtenstein'	,	NULL	); 
INSERT INTO Region VALUES (	 'LTU'	,	 'Lithuania'	,	NULL	); 
INSERT INTO Region VALUES (	 'LUX'	,	 'Luxembourg'	,	NULL	); 
INSERT INTO Region VALUES (	 'MAD'	,	 'Madagascar'	,	NULL	); 
INSERT INTO Region VALUES (	 'MAL'	,	 'Malaysia'	,	NULL	); 
INSERT INTO Region VALUES (	 'MAR'	,	 'Morocco'	,	NULL	); 
INSERT INTO Region VALUES (	 'MAS'	,	 'Malaysia'	,	NULL	); 
INSERT INTO Region VALUES (	 'MAW'	,	 'Malawi'	,	NULL	); 
INSERT INTO Region VALUES (	 'MDA'	,	 'Moldova'	,	NULL	); 
INSERT INTO Region VALUES (	 'MDV'	,	 'Maldives'	,	NULL	); 
INSERT INTO Region VALUES (	 'MEX'	,	 'Mexico'	,	NULL	); 
INSERT INTO Region VALUES (	 'MGL'	,	 'Mongolia'	,	NULL	); 
INSERT INTO Region VALUES (	 'MHL'	,	 'Marshall Islands'	,	NULL	); 
INSERT INTO Region VALUES (	 'MKD'	,	 'Macedonia'	,	NULL	); 
INSERT INTO Region VALUES (	 'MLI'	,	 'Mali'	,	NULL	); 
INSERT INTO Region VALUES (	 'MLT'	,	 'Malta'	,	NULL	); 
INSERT INTO Region VALUES (	 'MNE'	,	 'Montenegro'	,	NULL	); 
INSERT INTO Region VALUES (	 'MON'	,	 'Monaco'	,	NULL	); 
INSERT INTO Region VALUES (	 'MOZ'	,	 'Mozambique'	,	NULL	); 
INSERT INTO Region VALUES (	 'MRI'	,	 'Mauritius'	,	NULL	); 
INSERT INTO Region VALUES (	 'MTN'	,	 'Mauritania'	,	NULL	); 
INSERT INTO Region VALUES (	 'MYA'	,	 'Myanmar'	,	NULL	); 
INSERT INTO Region VALUES (	 'NAM'	,	 'Namibia'	,	NULL	); 
INSERT INTO Region VALUES (	 'NBO'	,	 'Malaysia'	,	 'North Borneo'	); 
INSERT INTO Region VALUES (	 'NCA'	,	 'Nicaragua'	,	NULL	); 
INSERT INTO Region VALUES (	 'NED'	,	 'Netherlands'	,	NULL	); 
INSERT INTO Region VALUES (	 'NEP'	,	 'Nepal'	,	NULL	); 
INSERT INTO Region VALUES (	 'NFL'	,	 'Canada'	,	 'Newfoundland'	); 
INSERT INTO Region VALUES (	 'NGR'	,	 'Nigeria'	,	NULL	); 
INSERT INTO Region VALUES (	 'NIG'	,	 'Niger'	,	NULL	); 
INSERT INTO Region VALUES (	 'NOR'	,	 'Norway'	,	NULL	); 
INSERT INTO Region VALUES (	 'NRU'	,	 'Nauru'	,	NULL	); 
INSERT INTO Region VALUES (	 'NZL'	,	 'New Zealand'	,	NULL	); 
INSERT INTO Region VALUES (	 'OMA'	,	 'Oman'	,	NULL	); 
INSERT INTO Region VALUES (	 'PAK'	,	 'Pakistan'	,	NULL	); 
INSERT INTO Region VALUES (	 'PAN'	,	 'Panama'	,	NULL	); 
INSERT INTO Region VALUES (	 'PAR'	,	 'Paraguay'	,	NULL	); 
INSERT INTO Region VALUES (	 'PER'	,	 'Peru'	,	NULL	); 
INSERT INTO Region VALUES (	 'PHI'	,	 'Philippines'	,	NULL	); 
INSERT INTO Region VALUES (	 'PLE'	,	 'Palestine'	,	NULL	); 
INSERT INTO Region VALUES (	 'PLW'	,	 'Palau'	,	NULL	); 
INSERT INTO Region VALUES (	 'PNG'	,	 'Papua New Guinea'	,	NULL	); 
INSERT INTO Region VALUES (	 'POL'	,	 'Poland'	,	NULL	); 
INSERT INTO Region VALUES (	 'POR'	,	 'Portugal'	,	NULL	); 
INSERT INTO Region VALUES (	 'PRK'	,	 'North Korea'	,	NULL	); 
INSERT INTO Region VALUES (	 'PUR'	,	 'Puerto Rico'	,	NULL	); 
INSERT INTO Region VALUES (	 'QAT'	,	 'Qatar'	,	NULL	); 
INSERT INTO Region VALUES (	 'RHO'	,	 'Zimbabwe'	,	NULL	); 
INSERT INTO Region VALUES (	 'ROT'	,	 'NA'	,	 'Refugee Olympic Team'	); 
INSERT INTO Region VALUES (	 'ROU'	,	 'Romania'	,	NULL	); 
INSERT INTO Region VALUES (	 'RSA'	,	 'South Africa'	,	NULL	); 
INSERT INTO Region VALUES (	 'RUS'	,	 'Russia'	,	NULL	); 
INSERT INTO Region VALUES (	 'RWA'	,	 'Rwanda'	,	NULL	); 
INSERT INTO Region VALUES (	 'SAA'	,	 'Germany'	,	NULL	); 
INSERT INTO Region VALUES (	 'SAM'	,	 'Samoa'	,	NULL	); 
INSERT INTO Region VALUES (	 'SCG'	,	 'Serbia'	,	 'Serbia and Montenegro'	); 
INSERT INTO Region VALUES (	 'SEN'	,	 'Senegal'	,	NULL	); 
INSERT INTO Region VALUES (	 'SEY'	,	 'Seychelles'	,	NULL	); 
INSERT INTO Region VALUES (	 'SIN'	,	 'Singapore'	,	NULL	); 
INSERT INTO Region VALUES (	 'SKN'	,	 'Saint Kitts'	,	 'Turks and Caicos Islands'	); 
INSERT INTO Region VALUES (	 'SLE'	,	 'Sierra Leone'	,	NULL	); 
INSERT INTO Region VALUES (	 'SLO'	,	 'Slovenia'	,	NULL	); 
INSERT INTO Region VALUES (	 'SMR'	,	 'San Marino'	,	NULL	); 
INSERT INTO Region VALUES (	 'SOL'	,	 'Solomon Islands'	,	NULL	); 
INSERT INTO Region VALUES (	 'SOM'	,	 'Somalia'	,	NULL	); 
INSERT INTO Region VALUES (	 'SRB'	,	 'Serbia'	,	NULL	); 
INSERT INTO Region VALUES (	 'SRI'	,	 'Sri Lanka'	,	NULL	); 
INSERT INTO Region VALUES (	 'SSD'	,	 'South Sudan'	,	NULL	); 
INSERT INTO Region VALUES (	 'STP'	,	 'Sao Tome and Principe'	,	NULL	); 
INSERT INTO Region VALUES (	 'SUD'	,	 'Sudan'	,	NULL	); 
INSERT INTO Region VALUES (	 'SUI'	,	 'Switzerland'	,	NULL	); 
INSERT INTO Region VALUES (	 'SUR'	,	 'Suriname'	,	NULL	); 
INSERT INTO Region VALUES (	 'SVK'	,	 'Slovakia'	,	NULL	); 
INSERT INTO Region VALUES (	 'SWE'	,	 'Sweden'	,	NULL	); 
INSERT INTO Region VALUES (	 'SWZ'	,	 'Swaziland'	,	NULL	); 
INSERT INTO Region VALUES (	 'SYR'	,	 'Syria'	,	NULL	); 
INSERT INTO Region VALUES (	 'TAN'	,	 'Tanzania'	,	NULL	); 
INSERT INTO Region VALUES (	 'TCH'	,	 'Czech Republic'	,	NULL	); 
INSERT INTO Region VALUES (	 'TGA'	,	 'Tonga'	,	NULL	); 
INSERT INTO Region VALUES (	 'THA'	,	 'Thailand'	,	NULL	); 
INSERT INTO Region VALUES (	 'TJK'	,	 'Tajikistan'	,	NULL	); 
INSERT INTO Region VALUES (	 'TKM'	,	 'Turkmenistan'	,	NULL	); 
INSERT INTO Region VALUES (	 'TLS'	,	 'Timor-Leste'	,	NULL	); 
INSERT INTO Region VALUES (	 'TOG'	,	 'Togo'	,	NULL	); 
INSERT INTO Region VALUES (	 'TPE'	,	 'Taiwan'	,	NULL	); 
INSERT INTO Region VALUES (	 'TTO'	,	 'Trinidad'	,	 'Trinidad and Tobago'	); 
INSERT INTO Region VALUES (	 'TUN'	,	 'Tunisia'	,	NULL	); 
INSERT INTO Region VALUES (	 'TUR'	,	 'Turkey'	,	NULL	); 
INSERT INTO Region VALUES (	 'TUV'	,	 'NA'	,	 'Tuvalu'	); 
INSERT INTO Region VALUES (	 'UAE'	,	 'United Arab Emirates'	,	NULL	); 
INSERT INTO Region VALUES (	 'UAR'	,	 'Syria'	,	 'United Arab Republic'	); 
INSERT INTO Region VALUES (	 'UGA'	,	 'Uganda'	,	NULL	); 
INSERT INTO Region VALUES (	 'UKR'	,	 'Ukraine'	,	NULL	); 
INSERT INTO Region VALUES (	 'UNK'	,	 'NA'	,	 'Unknown'	); 
INSERT INTO Region VALUES (	 'URS'	,	 'Russia'	,	NULL	); 
INSERT INTO Region VALUES (	 'URU'	,	 'Uruguay'	,	NULL	); 
INSERT INTO Region VALUES (	 'USA'	,	 'USA'	,	NULL	); 
INSERT INTO Region VALUES (	 'UZB'	,	 'Uzbekistan'	,	NULL	); 
INSERT INTO Region VALUES (	 'VAN'	,	 'Vanuatu'	,	NULL	); 
INSERT INTO Region VALUES (	 'VEN'	,	 'Venezuela'	,	NULL	); 
INSERT INTO Region VALUES (	 'VIE'	,	 'Vietnam'	,	NULL	); 
INSERT INTO Region VALUES (	 'VIN'	,	 'Saint Vincent'	,	NULL	); 
INSERT INTO Region VALUES (	 'VNM'	,	 'Vietnam'	,	NULL	); 
INSERT INTO Region VALUES (	 'WIF'	,	 'Trinidad'	,	 'West Indies Federation'	); 
INSERT INTO Region VALUES (	 'YAR'	,	 'Yemen'	,	 'North Yemen'	); 
INSERT INTO Region VALUES (	 'YEM'	,	 'Yemen'	,	NULL	); 
INSERT INTO Region VALUES (	 'YMD'	,	 'Yemen'	,	 'South Yemen'	); 
INSERT INTO Region VALUES (	 'YUG'	,	 'Serbia'	,	 'Yugoslavia'	); 
INSERT INTO Region VALUES (	 'ZAM'	,	 'Zambia'	,	NULL	); 
INSERT INTO Region VALUES (	 'ZIM'	,	 'Zimbabwe'	,	NULL	);

-- Insert Data into Countries table : Done by Jeongwon Eom
INSERT INTO Countries 
SELECT Region, NOC
FROM Region;


-- Insert Data into Cities table : Done by Jeongwon Eom
INSERT INTO Cities VALUES ('Barcelona'	 ,'ESP');
INSERT INTO Cities VALUES ('London'	 ,'GBR');
INSERT INTO Cities VALUES ('Antwerpen'	 ,'BEL');
INSERT INTO Cities VALUES ('Paris'	 ,'FRA');
INSERT INTO Cities VALUES ('Calgary'	 ,'CAN');
INSERT INTO Cities VALUES ('Albertville'	 ,'USA');
INSERT INTO Cities VALUES ('Lillehammer'	 ,'NOR');
INSERT INTO Cities VALUES ('Los Angeles'	 ,'USA');
INSERT INTO Cities VALUES ('Salt Lake City'	 ,'USA');
INSERT INTO Cities VALUES ('Helsinki'	 ,'FIN');
INSERT INTO Cities VALUES ('Lake Placid'	 ,'USA');
INSERT INTO Cities VALUES ('Sydney'	 ,'AUS');
INSERT INTO Cities VALUES ('Atlanta'	 ,'USA');
INSERT INTO Cities VALUES ('Stockholm'	 ,'SWE');
INSERT INTO Cities VALUES ('Sochi'	 ,'RUS');
INSERT INTO Cities VALUES ('Nagano'	 ,'JPN');
INSERT INTO Cities VALUES ('Torino'	 ,'ITA');
INSERT INTO Cities VALUES ('Beijing'	 ,'CHN');
INSERT INTO Cities VALUES ('Rio de Janeiro'	 ,'BRA');
INSERT INTO Cities VALUES ('Athina'	 ,'GRE');
INSERT INTO Cities VALUES ('Squaw Valley'	 ,'USA');
INSERT INTO Cities VALUES ('Innsbruck'	 ,'AUT');
INSERT INTO Cities VALUES ('Sarajevo'	 ,'BIH');
INSERT INTO Cities VALUES ('Mexico City'	 ,'MEX');
INSERT INTO Cities VALUES ('Munich'	 ,'GDR');
INSERT INTO Cities VALUES ('Seoul'	 ,'KOR');
INSERT INTO Cities VALUES ('Berlin'	 ,'GDR');
INSERT INTO Cities VALUES ('Oslo'	 ,'NOR');
INSERT INTO Cities VALUES ("Cortina d'Ampezzo"	 ,'ITA');
INSERT INTO Cities VALUES ('Melbourne'	 ,'AUS');
INSERT INTO Cities VALUES ('Roma'	 ,'ITA');
INSERT INTO Cities VALUES ('Amsterdam'	 ,'NED');
INSERT INTO Cities VALUES ('Montreal'	 ,'CAN');
INSERT INTO Cities VALUES ('Moskva'	 ,'RUS');
INSERT INTO Cities VALUES ('Tokyo'	 ,'JPN');
INSERT INTO Cities VALUES ('Vancouver'	 ,'CAN');
INSERT INTO Cities VALUES ('Grenoble'	 ,'FRA');
INSERT INTO Cities VALUES ('Sapporo'	 ,'JPN');
INSERT INTO Cities VALUES ('Chamonix'	 ,'FRA');
INSERT INTO Cities VALUES ('St. Louis'	 ,'USA');
INSERT INTO Cities VALUES ('Sankt Moritz'	 ,'SWZ');
INSERT INTO Cities VALUES ('Garmisch-Partenkirchen'	 ,'GDR');


-- Insert Data into games table : Done by Cici Suhaeni
INSERT INTO `games` (`id`, `name`, `year`, `Season_id`, `city`) VALUES
(1, '1900 Summer', 1900, 0, 'Paris'),
(2, '1904 Summer', 1904, 0, 'St. Louis'),
(3, '1906 Summer', 1906, 0, 'Athina'),
(4, '1908 Summer', 1908, 0, 'London'),
(5, '1912 Summer', 1912, 0, 'Stockholm'),
(6, '1920 Summer', 1920, 0, 'Antwerpen'),
(7, '1924 Summer', 1924, 0, 'Paris'),
(8, '1924 Winter', 1924, 1, 'Chamonix'),
(9, '1928 Summer', 1928, 0, 'Amsterdam'),
(10, '1928 Winter', 1928, 1, 'Sankt Moritz'),
(11, '1932 Summer', 1932, 0, 'Los Angeles'),
(12, '1932 Winter', 1932, 1, 'Lake Placid'),
(13, '1936 Summer', 1936, 0, 'Berlin'),
(14, '1936 Winter', 1936, 1, 'Garmisch-Partenkirchen'),
(15, '1948 Summer', 1948, 0, 'London'),
(16, '1948 Winter', 1948, 1, 'Sankt Moritz'),
(17, '1952 Summer', 1952, 0, 'Helsinki'),
(18, '1952 Winter', 1952, 1, 'Oslo'),
(19, '1956 Summer', 1956, 0, 'Melbourne'),
(20, '1956 Winter', 1956, 1, "Cortina d'Ampezzo"),
(21, '1960 Summer', 1960, 0, 'Roma'),
(22, '1960 Winter', 1960, 1, 'Squaw Valley'),
(23, '1964 Summer', 1964, 0, 'Tokyo'),
(24, '1964 Winter', 1964, 1, 'Innsbruck'),
(25, '1968 Summer', 1968, 0, 'Mexico City'),
(26, '1968 Winter', 1968, 1, 'Grenoble'),
(27, '1972 Summer', 1972, 0, 'Munich'),
(28, '1972 Winter', 1972, 1, 'Sapporo'),
(29, '1976 Summer', 1976, 0, 'Montreal'),
(30, '1976 Winter', 1976, 1, 'Innsbruck'),
(31, '1980 Summer', 1980, 0, 'Moskva'),
(32, '1980 Winter', 1980, 1, 'Lake Placid'),
(33, '1984 Summer', 1984, 0, 'Los Angeles'),
(34, '1984 Winter', 1984, 1, 'Sarajevo'),
(35, '1988 Summer', 1988, 0, 'Seoul'),
(36, '1988 Winter', 1988, 1, 'Calgary'),
(37, '1992 Summer', 1992, 0, 'Barcelona'),
(38, '1992 Winter', 1992, 1, 'Albertville'),
(39, '1994 Winter', 1994, 1, 'Lillehammer'),
(40, '1996 Summer', 1996, 0, 'Atlanta'),
(41, '1998 Winter', 1998, 1, 'Nagano'),
(42, '2000 Summer', 2000, 0, 'Sydney'),
(43, '2002 Winter', 2002, 1, 'Salt Lake City'),
(44, '2004 Summer', 2004, 0, 'Athina'),
(45, '2006 Winter', 2006, 1, 'Torino'),
(46, '2008 Summer', 2008, 0, 'Beijing'),
(47, '2010 Winter', 2010, 1, 'Vancouver'),
(48, '2012 Summer', 2012, 0, 'London'),
(49, '2014 Winter', 2014, 1, 'Sochi'),
(50, '2016 Summer', 2016, 0, 'Rio de Janeiro');


-- Insert Data into Sports table : Done by Cici Suhaeni
INSERT INTO sports (id, name) VALUES
(1, 'Alpine Skiing'),
(2, 'Archery'),
(3, 'Art Competitions'),
(4, 'Athletics'),
(5, 'Badminton'),
(6, 'Baseball'),
(7, 'Basketball'),
(8, 'Beach Volleyball'),
(9, 'Biathlon'),
(10, 'Bobsleigh'),
(11, 'Boxing'),
(12, 'Canoeing'),
(13, 'Cross Country Skiing'),
(14, 'Curling'),
(15, 'Cycling'),
(16, 'Diving'),
(17, 'Equestrianism'),
(18, 'Fencing'),
(19, 'Figure Skating'),
(20, 'Football'),
(21, 'Freestyle Skiing'),
(22, 'Golf'),
(23, 'Gymnastics'),
(24, 'Handball'),
(25, 'Hockey'),
(26, 'Ice Hockey'),
(27, 'Judo'),
(28, 'Luge'),
(29, 'Modern Pentathlon'),
(30, 'Nordic Combined'),
(31, 'Rhythmic Gymnastics'),
(32, 'Rowing'),
(33, 'Rugby Sevens'),
(34, 'Sailing'),
(35, 'Shooting'),
(36, 'Ski Jumping'),
(37, 'Softball'),
(38, 'Speed Skating'),
(39, 'Swimming'),
(40, 'Synchronized Swimming'),
(41, 'Table Tennis'),
(42, 'Taekwondo'),
(43, 'Tennis'),
(44, 'Trampolining'),
(45, 'Triathlon'),
(46, 'Tug-Of-War'),
(47, 'Volleyball'),
(48, 'Water Polo'),
(49, 'Weightlifting'),
(50, 'Wrestling');

-- Insert Data into events table : Done by Cici Suhaeni
INSERT INTO `events` (`id`, `name`, `games_id`, `sport_id`) VALUES
(1, 'Alpine Skiing Mens Combined', 36, 1),
(2, 'Alpine Skiing Mens Combined', 38, 1),
(3, 'Alpine Skiing Mens Combined', 39, 1),
(4, 'Alpine Skiing Mens Combined', 41, 1),
(5, 'Alpine Skiing Mens Combined', 43, 1),
(6, 'Alpine Skiing Mens Combined', 49, 1),
(7, 'Alpine Skiing Mens Downhill', 38, 1),
(8, 'Alpine Skiing Mens Downhill', 39, 1),
(9, 'Alpine Skiing Mens Downhill', 41, 1),
(10, 'Alpine Skiing Mens Downhill', 43, 1),
(11, 'Alpine Skiing Mens Downhill', 45, 1),
(12, 'Alpine Skiing Mens Downhill', 49, 1),
(13, 'Alpine Skiing Mens Giant Slalom', 30, 1),
(14, 'Alpine Skiing Mens Giant Slalom', 32, 1),
(15, 'Alpine Skiing Mens Giant Slalom', 38, 1),
(16, 'Alpine Skiing Mens Giant Slalom', 39, 1),
(17, 'Alpine Skiing Mens Giant Slalom', 41, 1),
(18, 'Alpine Skiing Mens Giant Slalom', 43, 1),
(19, 'Alpine Skiing Mens Giant Slalom', 45, 1),
(20, 'Alpine Skiing Mens Giant Slalom', 47, 1),
(21, 'Alpine Skiing Mens Giant Slalom', 49, 1),
(22, 'Alpine Skiing Mens Slalom', 26, 1),
(23, 'Alpine Skiing Mens Slalom', 30, 1),
(24, 'Alpine Skiing Mens Slalom', 36, 1),
(25, 'Alpine Skiing Mens Slalom', 38, 1),
(26, 'Alpine Skiing Mens Slalom', 39, 1),
(27, 'Alpine Skiing Mens Slalom', 41, 1),
(28, 'Alpine Skiing Mens Slalom', 43, 1),
(29, 'Alpine Skiing Mens Slalom', 45, 1),
(30, 'Alpine Skiing Mens Slalom', 47, 1),
(31, 'Alpine Skiing Mens Slalom', 49, 1),
(32, 'Alpine Skiing Mens Super G', 38, 1),
(33, 'Alpine Skiing Mens Super G', 39, 1),
(34, 'Alpine Skiing Mens Super G', 41, 1),
(35, 'Alpine Skiing Mens Super G', 43, 1),
(36, 'Alpine Skiing Mens Super G', 45, 1),
(37, 'Alpine Skiing Womens Combined', 45, 1),
(38, 'Alpine Skiing Womens Downhill', 24, 1),
(39, 'Alpine Skiing Womens Giant Slalom', 24, 1),
(40, 'Alpine Skiing Womens Giant Slalom', 41, 1),
(41, 'Alpine Skiing Womens Giant Slalom', 45, 1),
(42, 'Alpine Skiing Womens Giant Slalom', 49, 1),
(43, 'Alpine Skiing Womens Slalom', 18, 1),
(44, 'Alpine Skiing Womens Slalom', 39, 1),
(45, 'Alpine Skiing Womens Slalom', 41, 1),
(46, 'Alpine Skiing Womens Slalom', 45, 1),
(47, 'Alpine Skiing Womens Slalom', 47, 1),
(48, 'Alpine Skiing Womens Slalom', 49, 1),
(49, 'Alpine Skiing Womens Super G', 49, 1),
(50, 'Archery Mens Individual', 46, 2),
(51, 'Archery Mens Team', 46, 2),
(52, 'Archery Womens Individual', 29, 2),
(53, 'Archery Womens Individual', 40, 2),
(54, 'Archery Womens Individual', 46, 2),
(55, 'Archery Womens Team', 40, 2),
(56, 'Art Competitions Mixed Architecture, Architectural Designs', 9, 3),
(57, 'Art Competitions Mixed Architecture, Designs For Town Planning', 9, 3),
(58, 'Art Competitions Mixed Literature', 5, 3),
(59, 'Art Competitions Mixed Painting', 7, 3),
(60, 'Art Competitions Mixed Painting, Unknown Event', 11, 3),
(61, 'Art Competitions Mixed Sculpturing, Unknown Event', 15, 3),
(62, 'Athletics Mens 1,500 metres', 15, 4),
(63, 'Athletics Mens 1,500 metres', 17, 4),
(64, 'Athletics Mens 1,500 metres', 23, 4),
(65, 'Athletics Mens 1,500 metres', 27, 4),
(66, 'Athletics Mens 1,500 metres', 31, 4),
(67, 'Athletics Mens 1,500 metres', 33, 4),
(68, 'Athletics Mens 1,500 metres', 35, 4),
(69, 'Athletics Mens 1,500 metres', 40, 4),
(70, 'Athletics Mens 1,500 metres', 42, 4),
(71, 'Athletics Mens 1,500 metres', 46, 4),
(72, 'Athletics Mens 1,500 metres', 48, 4),
(73, 'Athletics Mens 10,000 metres', 17, 4),
(74, 'Athletics Mens 10,000 metres', 21, 4),
(75, 'Athletics Mens 10,000 metres', 35, 4),
(76, 'Athletics Mens 10,000 metres', 37, 4),
(77, 'Athletics Mens 10,000 metres', 40, 4),
(78, 'Athletics Mens 10,000 metres', 42, 4),
(79, 'Athletics Mens 10,000 metres', 44, 4),
(80, 'Athletics Mens 10,000 metres', 46, 4),
(81, 'Athletics Mens 10,000 metres', 50, 4),
(82, 'Athletics Mens 100 metres', 3, 4),
(83, 'Athletics Mens 100 metres', 5, 4),
(84, 'Athletics Mens 100 metres', 6, 4),
(85, 'Athletics Mens 100 metres', 7, 4),
(86, 'Athletics Mens 100 metres', 9, 4),
(87, 'Athletics Mens 100 metres', 17, 4),
(88, 'Athletics Mens 100 metres', 21, 4),
(89, 'Athletics Mens 100 metres', 25, 4),
(90, 'Athletics Mens 100 metres', 27, 4),
(91, 'Athletics Mens 100 metres', 29, 4),
(92, 'Athletics Mens 100 metres', 31, 4),
(93, 'Athletics Mens 100 metres', 33, 4),
(94, 'Athletics Mens 100 metres', 35, 4),
(95, 'Athletics Mens 100 metres', 37, 4),
(96, 'Athletics Mens 100 metres', 40, 4),
(97, 'Athletics Mens 100 metres', 42, 4),
(98, 'Athletics Mens 100 metres', 44, 4),
(99, 'Athletics Mens 100 metres', 46, 4),
(100, 'Athletics Mens 100 metres', 48, 4),
(101, 'Athletics Mens 100 metres', 50, 4),
(102, 'Athletics Mens 110 metres Hurdles', 9, 4),
(103, 'Athletics Mens 110 metres Hurdles', 27, 4),
(104, 'Athletics Mens 110 metres Hurdles', 35, 4),
(105, 'Athletics Mens 110 metres Hurdles', 37, 4),
(106, 'Athletics Mens 110 metres Hurdles', 40, 4),
(107, 'Athletics Mens 110 metres Hurdles', 48, 4),
(108, 'Athletics Mens 20 kilometres Walk', 29, 4),
(109, 'Athletics Mens 20 kilometres Walk', 44, 4),
(110, 'Athletics Mens 20 kilometres Walk', 46, 4),
(111, 'Athletics Mens 200 metres', 5, 4),
(112, 'Athletics Mens 200 metres', 6, 4),
(113, 'Athletics Mens 200 metres', 7, 4),
(114, 'Athletics Mens 200 metres', 9, 4),
(115, 'Athletics Mens 200 metres', 25, 4),
(116, 'Athletics Mens 200 metres', 27, 4),
(117, 'Athletics Mens 200 metres', 29, 4),
(118, 'Athletics Mens 200 metres', 31, 4),
(119, 'Athletics Mens 200 metres', 33, 4),
(120, 'Athletics Mens 200 metres', 35, 4),
(121, 'Athletics Mens 200 metres', 37, 4),
(122, 'Athletics Mens 200 metres', 40, 4),
(123, 'Athletics Mens 200 metres', 46, 4),
(124, 'Athletics Mens 200 metres', 48, 4),
(125, 'Athletics Mens 200 metres', 50, 4),
(126, 'Athletics Mens 3,000 metres Steeplechase', 27, 4),
(127, 'Athletics Mens 3,000 metres Steeplechase', 35, 4),
(128, 'Athletics Mens 3,000 metres Steeplechase', 37, 4),
(129, 'Athletics Mens 3,000 metres Steeplechase', 40, 4),
(130, 'Athletics Mens 3,000 metres Steeplechase', 46, 4),
(131, 'Athletics Mens 3,000 metres Steeplechase', 48, 4),
(132, 'Athletics Mens 4 x 100 metres Relay', 6, 4),
(133, 'Athletics Mens 4 x 100 metres Relay', 7, 4),
(134, 'Athletics Mens 4 x 100 metres Relay', 9, 4),
(135, 'Athletics Mens 4 x 100 metres Relay', 17, 4),
(136, 'Athletics Mens 4 x 100 metres Relay', 21, 4),
(137, 'Athletics Mens 4 x 100 metres Relay', 23, 4),
(138, 'Athletics Mens 4 x 100 metres Relay', 25, 4),
(139, 'Athletics Mens 4 x 100 metres Relay', 27, 4),
(140, 'Athletics Mens 4 x 100 metres Relay', 29, 4),
(141, 'Athletics Mens 4 x 100 metres Relay', 31, 4),
(142, 'Athletics Mens 4 x 100 metres Relay', 33, 4),
(143, 'Athletics Mens 4 x 100 metres Relay', 35, 4),
(144, 'Athletics Mens 4 x 100 metres Relay', 37, 4),
(145, 'Athletics Mens 4 x 100 metres Relay', 42, 4),
(146, 'Athletics Mens 4 x 100 metres Relay', 48, 4),
(147, 'Athletics Mens 4 x 100 metres Relay', 50, 4),
(148, 'Athletics Mens 4 x 400 metres Relay', 11, 4),
(149, 'Athletics Mens 4 x 400 metres Relay', 15, 4),
(150, 'Athletics Mens 4 x 400 metres Relay', 17, 4),
(151, 'Athletics Mens 4 x 400 metres Relay', 21, 4),
(152, 'Athletics Mens 4 x 400 metres Relay', 23, 4),
(153, 'Athletics Mens 4 x 400 metres Relay', 27, 4),
(154, 'Athletics Mens 4 x 400 metres Relay', 31, 4),
(155, 'Athletics Mens 4 x 400 metres Relay', 33, 4),
(156, 'Athletics Mens 4 x 400 metres Relay', 35, 4),
(157, 'Athletics Mens 4 x 400 metres Relay', 37, 4),
(158, 'Athletics Mens 4 x 400 metres Relay', 42, 4),
(159, 'Athletics Mens 4 x 400 metres Relay', 46, 4),
(160, 'Athletics Mens 4 x 400 metres Relay', 48, 4),
(161, 'Athletics Mens 400 metres', 15, 4),
(162, 'Athletics Mens 400 metres', 17, 4),
(163, 'Athletics Mens 400 metres', 21, 4),
(164, 'Athletics Mens 400 metres', 23, 4),
(165, 'Athletics Mens 400 metres', 27, 4),
(166, 'Athletics Mens 400 metres', 35, 4),
(167, 'Athletics Mens 400 metres', 37, 4),
(168, 'Athletics Mens 400 metres', 40, 4),
(169, 'Athletics Mens 400 metres', 44, 4),
(170, 'Athletics Mens 400 metres', 46, 4),
(171, 'Athletics Mens 400 metres', 50, 4),
(172, 'Athletics Mens 400 metres Hurdles', 9, 4),
(173, 'Athletics Mens 400 metres Hurdles', 11, 4),
(174, 'Athletics Mens 400 metres Hurdles', 17, 4),
(175, 'Athletics Mens 400 metres Hurdles', 25, 4),
(176, 'Athletics Mens 400 metres Hurdles', 29, 4),
(177, 'Athletics Mens 400 metres Hurdles', 31, 4),
(178, 'Athletics Mens 400 metres Hurdles', 33, 4),
(179, 'Athletics Mens 400 metres Hurdles', 37, 4),
(180, 'Athletics Mens 400 metres Hurdles', 40, 4),
(181, 'Athletics Mens 400 metres Hurdles', 42, 4),
(182, 'Athletics Mens 5,000 metres', 9, 4),
(183, 'Athletics Mens 5,000 metres', 13, 4),
(184, 'Athletics Mens 5,000 metres', 17, 4),
(185, 'Athletics Mens 5,000 metres', 21, 4),
(186, 'Athletics Mens 5,000 metres', 25, 4),
(187, 'Athletics Mens 5,000 metres', 27, 4),
(188, 'Athletics Mens 5,000 metres', 31, 4),
(189, 'Athletics Mens 5,000 metres', 35, 4),
(190, 'Athletics Mens 5,000 metres', 37, 4),
(191, 'Athletics Mens 5,000 metres', 40, 4),
(192, 'Athletics Mens 5,000 metres', 46, 4),
(193, 'Athletics Mens 5,000 metres', 48, 4),
(194, 'Athletics Mens 5,000 metres', 50, 4),
(195, 'Athletics Mens 50 kilometres Walk', 13, 4),
(196, 'Athletics Mens 50 kilometres Walk', 46, 4),
(197, 'Athletics Mens 50 kilometres Walk', 48, 4),
(198, 'Athletics Mens 800 metres', 15, 4),
(199, 'Athletics Mens 800 metres', 25, 4),
(200, 'Athletics Mens 800 metres', 27, 4),
(201, 'Athletics Mens 800 metres', 33, 4),
(202, 'Athletics Mens 800 metres', 35, 4),
(203, 'Athletics Mens 800 metres', 37, 4),
(204, 'Athletics Mens 800 metres', 40, 4),
(205, 'Athletics Mens Decathlon', 5, 4),
(206, 'Athletics Mens Decathlon', 15, 4),
(207, 'Athletics Mens Decathlon', 17, 4),
(208, 'Athletics Mens Decathlon', 40, 4),
(209, 'Athletics Mens Decathlon', 46, 4),
(210, 'Athletics Mens Decathlon', 48, 4),
(211, 'Athletics Mens Decathlon', 50, 4),
(212, 'Athletics Mens Discus Throw', 4, 4),
(213, 'Athletics Mens Discus Throw', 31, 4),
(214, 'Athletics Mens Discus Throw, Greek Style', 4, 4),
(215, 'Athletics Mens Hammer Throw', 5, 4),
(216, 'Athletics Mens Hammer Throw', 13, 4),
(217, 'Athletics Mens Hammer Throw', 27, 4),
(218, 'Athletics Mens Hammer Throw', 29, 4),
(219, 'Athletics Mens Hammer Throw', 37, 4),
(220, 'Athletics Mens Hammer Throw', 40, 4),
(221, 'Athletics Mens Hammer Throw', 42, 4),
(222, 'Athletics Mens High Jump', 5, 4),
(223, 'Athletics Mens High Jump', 9, 4),
(224, 'Athletics Mens High Jump', 15, 4),
(225, 'Athletics Mens High Jump', 21, 4),
(226, 'Athletics Mens High Jump', 23, 4),
(227, 'Athletics Mens High Jump', 25, 4),
(228, 'Athletics Mens High Jump', 29, 4),
(229, 'Athletics Mens High Jump', 50, 4),
(230, 'Athletics Mens Javelin Throw', 5, 4),
(231, 'Athletics Mens Javelin Throw', 19, 4),
(232, 'Athletics Mens Javelin Throw', 31, 4),
(233, 'Athletics Mens Javelin Throw', 48, 4),
(234, 'Athletics Mens Javelin Throw, Both Hands', 5, 4),
(235, 'Athletics Mens Long Jump', 3, 4),
(236, 'Athletics Mens Long Jump', 5, 4),
(237, 'Athletics Mens Long Jump', 6, 4),
(238, 'Athletics Mens Long Jump', 7, 4),
(239, 'Athletics Mens Long Jump', 9, 4),
(240, 'Athletics Mens Long Jump', 15, 4),
(241, 'Athletics Mens Long Jump', 21, 4),
(242, 'Athletics Mens Long Jump', 25, 4),
(243, 'Athletics Mens Long Jump', 27, 4),
(244, 'Athletics Mens Long Jump', 31, 4),
(245, 'Athletics Mens Long Jump', 40, 4),
(246, 'Athletics Mens Marathon', 13, 4),
(247, 'Athletics Mens Marathon', 17, 4),
(248, 'Athletics Mens Marathon', 23, 4),
(249, 'Athletics Mens Marathon', 25, 4),
(250, 'Athletics Mens Marathon', 27, 4),
(251, 'Athletics Mens Marathon', 33, 4),
(252, 'Athletics Mens Marathon', 35, 4),
(253, 'Athletics Mens Marathon', 37, 4),
(254, 'Athletics Mens Marathon', 40, 4),
(255, 'Athletics Mens Marathon', 42, 4),
(256, 'Athletics Mens Marathon', 44, 4),
(257, 'Athletics Mens Marathon', 48, 4),
(258, 'Athletics Mens Marathon', 50, 4),
(259, 'Athletics Mens Pole Vault', 7, 4),
(260, 'Athletics Mens Pole Vault', 13, 4),
(261, 'Athletics Mens Pole Vault', 21, 4),
(262, 'Athletics Mens Pole Vault', 29, 4),
(263, 'Athletics Mens Shot Put', 33, 4),
(264, 'Athletics Mens Shot Put', 35, 4),
(265, 'Athletics Mens Shot Put', 42, 4),
(266, 'Athletics Mens Shot Put', 50, 4),
(267, 'Athletics Mens Standing High Jump', 4, 4),
(268, 'Athletics Mens Standing High Jump', 5, 4),
(269, 'Athletics Mens Standing Long Jump', 4, 4),
(270, 'Athletics Mens Standing Long Jump', 5, 4),
(271, 'Athletics Mens Triple Jump', 4, 4),
(272, 'Athletics Mens Triple Jump', 5, 4),
(273, 'Athletics Mens Triple Jump', 21, 4),
(274, 'Athletics Mens Triple Jump', 35, 4),
(275, 'Athletics Mens Triple Jump', 42, 4),
(276, 'Athletics Mens Triple Jump', 44, 4),
(277, 'Athletics Mens Triple Jump', 46, 4),
(278, 'Athletics Mens Triple Jump', 48, 4),
(279, 'Athletics Womens 1,500 metres', 44, 4),
(280, 'Athletics Womens 1,500 metres', 48, 4),
(281, 'Athletics Womens 10,000 metres', 40, 4),
(282, 'Athletics Womens 10,000 metres', 42, 4),
(283, 'Athletics Womens 10,000 metres', 46, 4),
(284, 'Athletics Womens 100 metres', 9, 4),
(285, 'Athletics Womens 100 metres', 11, 4),
(286, 'Athletics Womens 100 metres', 21, 4),
(287, 'Athletics Womens 100 metres', 27, 4),
(288, 'Athletics Womens 100 metres', 35, 4),
(289, 'Athletics Womens 100 metres', 42, 4),
(290, 'Athletics Womens 100 metres', 44, 4),
(291, 'Athletics Womens 100 metres', 46, 4),
(292, 'Athletics Womens 100 metres', 48, 4),
(293, 'Athletics Womens 100 metres', 50, 4),
(294, 'Athletics Womens 100 metres Hurdles', 37, 4),
(295, 'Athletics Womens 100 metres Hurdles', 48, 4),
(296, 'Athletics Womens 200 metres', 27, 4),
(297, 'Athletics Womens 200 metres', 35, 4),
(298, 'Athletics Womens 200 metres', 48, 4),
(299, 'Athletics Womens 200 metres', 50, 4),
(300, 'Athletics Womens 3,000 metres', 33, 4),
(301, 'Athletics Womens 4 x 100 metres Relay', 9, 4),
(302, 'Athletics Womens 4 x 100 metres Relay', 11, 4),
(303, 'Athletics Womens 4 x 100 metres Relay', 35, 4),
(304, 'Athletics Womens 4 x 100 metres Relay', 40, 4),
(305, 'Athletics Womens 4 x 100 metres Relay', 42, 4),
(306, 'Athletics Womens 4 x 100 metres Relay', 48, 4),
(307, 'Athletics Womens 4 x 100 metres Relay', 50, 4),
(308, 'Athletics Womens 4 x 400 metres Relay', 27, 4),
(309, 'Athletics Womens 4 x 400 metres Relay', 33, 4),
(310, 'Athletics Womens 4 x 400 metres Relay', 35, 4),
(311, 'Athletics Womens 4 x 400 metres Relay', 40, 4),
(312, 'Athletics Womens 4 x 400 metres Relay', 42, 4),
(313, 'Athletics Womens 4 x 400 metres Relay', 46, 4),
(314, 'Athletics Womens 4 x 400 metres Relay', 48, 4),
(315, 'Athletics Womens 400 metres', 27, 4),
(316, 'Athletics Womens 400 metres', 33, 4),
(317, 'Athletics Womens 400 metres', 35, 4),
(318, 'Athletics Womens 400 metres', 40, 4),
(319, 'Athletics Womens 400 metres', 42, 4),
(320, 'Athletics Womens 400 metres', 46, 4),
(321, 'Athletics Womens 400 metres', 50, 4),
(322, 'Athletics Womens 400 metres Hurdles', 35, 4),
(323, 'Athletics Womens 5,000 metres', 44, 4),
(324, 'Athletics Womens 5,000 metres', 46, 4),
(325, 'Athletics Womens 5,000 metres', 48, 4),
(326, 'Athletics Womens 800 metres', 33, 4),
(327, 'Athletics Womens 800 metres', 35, 4),
(328, 'Athletics Womens 800 metres', 37, 4),
(329, 'Athletics Womens 800 metres', 40, 4),
(330, 'Athletics Womens 800 metres', 44, 4),
(331, 'Athletics Womens Discus Throw', 15, 4),
(332, 'Athletics Womens Discus Throw', 44, 4),
(333, 'Athletics Womens Discus Throw', 46, 4),
(334, 'Athletics Womens Heptathlon', 48, 4),
(335, 'Athletics Womens High Jump', 9, 4),
(336, 'Athletics Womens High Jump', 40, 4),
(337, 'Athletics Womens High Jump', 42, 4),
(338, 'Athletics Womens High Jump', 44, 4),
(339, 'Athletics Womens High Jump', 46, 4),
(340, 'Athletics Womens High Jump', 48, 4),
(341, 'Athletics Womens Javelin Throw', 44, 4),
(342, 'Athletics Womens Javelin Throw', 46, 4),
(343, 'Athletics Womens Javelin Throw', 48, 4),
(344, 'Athletics Womens Long Jump', 46, 4),
(345, 'Athletics Womens Marathon', 44, 4),
(346, 'Athletics Womens Marathon', 46, 4),
(347, 'Athletics Womens Marathon', 48, 4),
(348, 'Athletics Womens Marathon', 50, 4),
(349, 'Athletics Womens Pentathlon', 25, 4),
(350, 'Athletics Womens Pole Vault', 48, 4),
(351, 'Athletics Womens Shot Put', 27, 4),
(352, 'Athletics Womens Shot Put', 29, 4),
(353, 'Athletics Womens Shot Put', 31, 4),
(354, 'Athletics Womens Shot Put', 40, 4),
(355, 'Athletics Womens Shot Put', 44, 4),
(356, 'Athletics Womens Shot Put', 46, 4),
(357, 'Athletics Womens Shot Put', 48, 4),
(358, 'Athletics Womens Shot Put', 50, 4),
(359, 'Badminton Mens Singles', 42, 5),
(360, 'Badminton Mens Singles', 46, 5),
(361, 'Badminton Mens Singles', 48, 5),
(362, 'Badminton Mens Singles', 50, 5),
(363, 'Badminton Mixed Doubles', 48, 5),
(364, 'Badminton Mixed Doubles', 50, 5),
(365, 'Badminton Womens Singles', 37, 5),
(366, 'Badminton Womens Singles', 40, 5),
(367, 'Baseball Mens Baseball', 37, 6),
(368, 'Baseball Mens Baseball', 42, 6),
(369, 'Baseball Mens Baseball', 44, 6),
(370, 'Baseball Mens Baseball', 46, 6),
(371, 'Basketball Mens Basketball', 15, 7),
(372, 'Basketball Mens Basketball', 17, 7),
(373, 'Basketball Mens Basketball', 21, 7),
(374, 'Basketball Mens Basketball', 23, 7),
(375, 'Basketball Mens Basketball', 25, 7),
(376, 'Basketball Mens Basketball', 27, 7),
(377, 'Basketball Mens Basketball', 29, 7),
(378, 'Basketball Mens Basketball', 31, 7),
(379, 'Basketball Mens Basketball', 33, 7),
(380, 'Basketball Mens Basketball', 35, 7),
(381, 'Basketball Mens Basketball', 37, 7),
(382, 'Basketball Mens Basketball', 42, 7),
(383, 'Basketball Mens Basketball', 46, 7),
(384, 'Basketball Mens Basketball', 48, 7),
(385, 'Basketball Mens Basketball', 50, 7),
(386, 'Basketball Womens Basketball', 37, 7),
(387, 'Basketball Womens Basketball', 40, 7),
(388, 'Basketball Womens Basketball', 42, 7),
(389, 'Basketball Womens Basketball', 44, 7),
(390, 'Basketball Womens Basketball', 46, 7),
(391, 'Basketball Womens Basketball', 48, 7),
(392, 'Basketball Womens Basketball', 50, 7),
(393, 'Beach Volleyball Mens Beach Volleyball', 46, 8),
(394, 'Biathlon Mens 10 kilometres Sprint', 32, 9),
(395, 'Biathlon Mens 10 kilometres Sprint', 34, 9),
(396, 'Biathlon Mens 10 kilometres Sprint', 47, 9),
(397, 'Biathlon Mens 10 kilometres Sprint', 49, 9),
(398, 'Biathlon Mens 12.5 kilometres Pursuit', 47, 9),
(399, 'Biathlon Mens 12.5 kilometres Pursuit', 49, 9),
(400, 'Biathlon Mens 20 kilometres', 30, 9),
(401, 'Biathlon Mens 20 kilometres', 32, 9),
(402, 'Biathlon Mens 20 kilometres', 34, 9),
(403, 'Biathlon Mens 20 kilometres', 47, 9),
(404, 'Biathlon Mens 20 kilometres', 49, 9),
(405, 'Biathlon Mens 4 x 7.5 kilometres Relay', 30, 9),
(406, 'Biathlon Mens 4 x 7.5 kilometres Relay', 32, 9),
(407, 'Biathlon Mens 4 x 7.5 kilometres Relay', 34, 9),
(408, 'Biathlon Mens 4 x 7.5 kilometres Relay', 47, 9),
(409, 'Biathlon Mens 4 x 7.5 kilometres Relay', 49, 9),
(410, 'Biathlon Mixed 2 x 6 kilometres and 2 x 7.5 kilometres Relay', 49, 9),
(411, 'Biathlon Womens 15 kilometres', 38, 9),
(412, 'Biathlon Womens 15 kilometres', 39, 9),
(413, 'Biathlon Womens 15 kilometres', 41, 9),
(414, 'Biathlon Womens 3 x 7.5 kilometres Relay', 38, 9),
(415, 'Biathlon Womens 4 x 7.5 kilometres Relay', 39, 9),
(416, 'Biathlon Womens 4 x 7.5 kilometres Relay', 41, 9),
(417, 'Biathlon Womens 7.5 kilometres Sprint', 38, 9),
(418, 'Biathlon Womens 7.5 kilometres Sprint', 39, 9),
(419, 'Biathlon Womens 7.5 kilometres Sprint', 41, 9),
(420, 'Bobsleigh Mens Four', 16, 10),
(421, 'Bobsleigh Mens Four', 28, 10),
(422, 'Bobsleigh Mens Four', 30, 10),
(423, 'Bobsleigh Mens Four', 38, 10),
(424, 'Bobsleigh Mens Four', 39, 10),
(425, 'Bobsleigh Mens Four', 41, 10),
(426, 'Bobsleigh Mens Four', 43, 10),
(427, 'Bobsleigh Mens Four', 45, 10),
(428, 'Bobsleigh Mens Four', 47, 10),
(429, 'Bobsleigh Mens Two', 28, 10),
(430, 'Bobsleigh Mens Two', 30, 10),
(431, 'Bobsleigh Mens Two', 36, 10),
(432, 'Bobsleigh Mens Two', 38, 10),
(433, 'Bobsleigh Mens Two', 39, 10),
(434, 'Bobsleigh Mens Two', 41, 10),
(435, 'Bobsleigh Mens Two', 43, 10),
(436, 'Bobsleigh Mens Two', 47, 10),
(437, 'Boxing Mens Bantamweight', 17, 11),
(438, 'Boxing Mens Bantamweight', 19, 11),
(439, 'Boxing Mens Bantamweight', 31, 11),
(440, 'Boxing Mens Bantamweight', 33, 11),
(441, 'Boxing Mens Bantamweight', 35, 11),
(442, 'Boxing Mens Bantamweight', 37, 11),
(443, 'Boxing Mens Bantamweight', 40, 11),
(444, 'Boxing Mens Bantamweight', 44, 11),
(445, 'Boxing Mens Bantamweight', 46, 11),
(446, 'Boxing Mens Bantamweight', 48, 11),
(447, 'Boxing Mens Featherweight', 4, 11),
(448, 'Boxing Mens Featherweight', 6, 11),
(449, 'Boxing Mens Featherweight', 7, 11),
(450, 'Boxing Mens Featherweight', 21, 11),
(451, 'Boxing Mens Featherweight', 25, 11),
(452, 'Boxing Mens Featherweight', 31, 11),
(453, 'Boxing Mens Featherweight', 35, 11),
(454, 'Boxing Mens Featherweight', 40, 11),
(455, 'Boxing Mens Flyweight', 15, 11),
(456, 'Boxing Mens Flyweight', 27, 11),
(457, 'Boxing Mens Flyweight', 35, 11),
(458, 'Boxing Mens Flyweight', 40, 11),
(459, 'Boxing Mens Flyweight', 50, 11),
(460, 'Boxing Mens Heavyweight', 15, 11),
(461, 'Boxing Mens Heavyweight', 21, 11),
(462, 'Boxing Mens Heavyweight', 46, 11),
(463, 'Boxing Mens Heavyweight', 50, 11),
(464, 'Boxing Mens Light-Flyweight', 29, 11),
(465, 'Boxing Mens Light-Flyweight', 35, 11),
(466, 'Boxing Mens Light-Flyweight', 42, 11),
(467, 'Boxing Mens Light-Flyweight', 44, 11),
(468, 'Boxing Mens Light-Heavyweight', 13, 11),
(469, 'Boxing Mens Light-Heavyweight', 35, 11),
(470, 'Boxing Mens Light-Heavyweight', 40, 11),
(471, 'Boxing Mens Light-Heavyweight', 42, 11),
(472, 'Boxing Mens Light-Heavyweight', 48, 11),
(473, 'Boxing Mens Light-Heavyweight', 50, 11),
(474, 'Boxing Mens Light-Middleweight', 25, 11),
(475, 'Boxing Mens Light-Middleweight', 31, 11),
(476, 'Boxing Mens Lightweight', 21, 11),
(477, 'Boxing Mens Lightweight', 23, 11),
(478, 'Boxing Mens Lightweight', 25, 11),
(479, 'Boxing Mens Lightweight', 27, 11),
(480, 'Boxing Mens Lightweight', 31, 11),
(481, 'Boxing Mens Lightweight', 40, 11),
(482, 'Boxing Mens Lightweight', 48, 11),
(483, 'Boxing Mens Lightweight', 50, 11),
(484, 'Boxing Mens Light-Welterweight', 17, 11),
(485, 'Boxing Mens Light-Welterweight', 35, 11),
(486, 'Boxing Mens Light-Welterweight', 42, 11),
(487, 'Boxing Mens Light-Welterweight', 48, 11),
(488, 'Boxing Mens Middleweight', 21, 11),
(489, 'Boxing Mens Middleweight', 25, 11),
(490, 'Boxing Mens Middleweight', 27, 11),
(491, 'Boxing Mens Middleweight', 42, 11),
(492, 'Boxing Mens Middleweight', 44, 11),
(493, 'Boxing Mens Middleweight', 50, 11),
(494, 'Boxing Mens Super-Heavyweight', 42, 11),
(495, 'Boxing Mens Welterweight', 15, 11),
(496, 'Boxing Mens Welterweight', 17, 11),
(497, 'Boxing Mens Welterweight', 33, 11),
(498, 'Boxing Mens Welterweight', 35, 11),
(499, 'Boxing Mens Welterweight', 37, 11),
(500, 'Boxing Mens Welterweight', 48, 11),
(501, 'Boxing Womens Flyweight', 48, 11),
(502, 'Boxing Womens Flyweight', 50, 11),
(503, 'Canoeing Mens Canadian Doubles, 1,000 metres', 27, 12),
(504, 'Canoeing Mens Canadian Doubles, 1,000 metres', 29, 12),
(505, 'Canoeing Mens Canadian Doubles, 1,000 metres', 37, 12),
(506, 'Canoeing Mens Canadian Doubles, 500 metres', 37, 12),
(507, 'Canoeing Mens Canadian Doubles, Slalom', 37, 12),
(508, 'Canoeing Mens Canadian Doubles, Slalom', 40, 12),
(509, 'Canoeing Mens Canadian Doubles, Slalom', 42, 12),
(510, 'Canoeing Mens Kayak Doubles, 500 metres', 35, 12),
(511, 'Canoeing Mens Kayak Doubles, 500 metres', 37, 12),
(512, 'Canoeing Mens Kayak Fours, 1,000 metres', 35, 12),
(513, 'Canoeing Mens Kayak Fours, 1,000 metres', 37, 12),
(514, 'Canoeing Mens Kayak Fours, 1,000 metres', 40, 12),
(515, 'Canoeing Mens Kayak Fours, 1,000 metres', 44, 12),
(516, 'Canoeing Mens Kayak Fours, 1,000 metres', 46, 12),
(517, 'Canoeing Mens Kayak Singles, 1,000 metres', 33, 12),
(518, 'Canoeing Mens Kayak Singles, 1,000 metres', 46, 12),
(519, 'Canoeing Mens Kayak Singles, 500 metres', 40, 12),
(520, 'Canoeing Mens Kayak Singles, 500 metres', 46, 12),
(521, 'Canoeing Mens Kayak Singles, Slalom', 37, 12),
(522, 'Canoeing Mens Kayak Singles, Slalom', 40, 12),
(523, 'Canoeing Womens Kayak Fours, 500 metres', 44, 12),
(524, 'Cross Country Skiing Mens 10 kilometres', 38, 13),
(525, 'Cross Country Skiing Mens 10 kilometres', 39, 13),
(526, 'Cross Country Skiing Mens 10/15 kilometres Pursuit', 38, 13),
(527, 'Cross Country Skiing Mens 10/15 kilometres Pursuit', 39, 13),
(528, 'Cross Country Skiing Mens 15 kilometres', 43, 13),
(529, 'Cross Country Skiing Mens 15 kilometres', 45, 13),
(530, 'Cross Country Skiing Mens 18 kilometres', 8, 13),
(531, 'Cross Country Skiing Mens 30 kilometres', 32, 13),
(532, 'Cross Country Skiing Mens 30 kilometres', 39, 13),
(533, 'Cross Country Skiing Mens 30 kilometres', 41, 13),
(534, 'Cross Country Skiing Mens 4 x 10 kilometres Relay', 38, 13),
(535, 'Cross Country Skiing Mens 4 x 10 kilometres Relay', 39, 13),
(536, 'Cross Country Skiing Mens 4 x 10 kilometres Relay', 43, 13),
(537, 'Cross Country Skiing Mens 50 kilometres', 38, 13),
(538, 'Cross Country Skiing Mens 50 kilometres', 41, 13),
(539, 'Cross Country Skiing Mens 50 kilometres', 43, 13),
(540, 'Cross Country Skiing Mens Sprint', 45, 13),
(541, 'Cross Country Skiing Womens 10 kilometres', 24, 13),
(542, 'Cross Country Skiing Womens 10 kilometres', 36, 13),
(543, 'Cross Country Skiing Womens 20 kilometres', 36, 13),
(544, 'Cross Country Skiing Womens 3 x 5 kilometres Relay', 26, 13),
(545, 'Cross Country Skiing Womens 5 kilometres', 24, 13),
(546, 'Cross Country Skiing Womens 5 kilometres', 26, 13),
(547, 'Cross Country Skiing Womens 5 kilometres', 36, 13),
(548, 'Curling Mens Curling', 45, 14),
(549, 'Curling Womens Curling', 49, 14),
(550, 'Cycling Mens 1,000 metres Time Trial', 9, 15),
(551, 'Cycling Mens 1,000 metres Time Trial', 25, 15),
(552, 'Cycling Mens 1,000 metres Time Trial', 33, 15),
(553, 'Cycling Mens 100 kilometres Team Time Trial', 21, 15),
(554, 'Cycling Mens 100 kilometres Team Time Trial', 23, 15),
(555, 'Cycling Mens 100 kilometres Team Time Trial', 27, 15),
(556, 'Cycling Mens 100 kilometres Team Time Trial', 31, 15),
(557, 'Cycling Mens 100 kilometres Team Time Trial', 33, 15),
(558, 'Cycling Mens 100 kilometres Team Time Trial', 37, 15),
(559, 'Cycling Mens Individual Pursuit, 4,000 metres', 25, 15),
(560, 'Cycling Mens Individual Pursuit, 4,000 metres', 27, 15),
(561, 'Cycling Mens Individual Pursuit, 4,000 metres', 37, 15),
(562, 'Cycling Mens Mountainbike, Cross-Country', 44, 15),
(563, 'Cycling Mens Mountainbike, Cross-Country', 46, 15),
(564, 'Cycling Mens Mountainbike, Cross-Country', 48, 15),
(565, 'Cycling Mens Mountainbike, Cross-Country', 50, 15),
(566, 'Cycling Mens Points Race', 37, 15),
(567, 'Cycling Mens Road Race, Individual', 7, 15),
(568, 'Cycling Mens Road Race, Individual', 9, 15),
(569, 'Cycling Mens Road Race, Individual', 13, 15),
(570, 'Cycling Mens Road Race, Individual', 19, 15),
(571, 'Cycling Mens Road Race, Individual', 21, 15),
(572, 'Cycling Mens Road Race, Individual', 25, 15),
(573, 'Cycling Mens Road Race, Individual', 27, 15),
(574, 'Cycling Mens Road Race, Individual', 29, 15),
(575, 'Cycling Mens Road Race, Individual', 31, 15),
(576, 'Cycling Mens Road Race, Individual', 33, 15),
(577, 'Cycling Mens Road Race, Individual', 35, 15),
(578, 'Cycling Mens Road Race, Individual', 37, 15),
(579, 'Cycling Mens Road Race, Individual', 40, 15),
(580, 'Cycling Mens Road Race, Individual', 42, 15),
(581, 'Cycling Mens Road Race, Individual', 46, 15),
(582, 'Cycling Mens Road Race, Team', 7, 15),
(583, 'Cycling Mens Road Race, Team', 9, 15),
(584, 'Cycling Mens Road Race, Team', 13, 15),
(585, 'Cycling Mens Road Race, Team', 19, 15),
(586, 'Cycling Mens Sprint', 25, 15),
(587, 'Cycling Mens Sprint', 31, 15),
(588, 'Cycling Mens Sprint', 35, 15),
(589, 'Cycling Mens Tandem Sprint, 2,000 metres', 15, 15),
(590, 'Cycling Mens Team Pursuit, 4,000 metres', 11, 15),
(591, 'Cycling Mens Team Pursuit, 4,000 metres', 15, 15),
(592, 'Cycling Mens Team Pursuit, 4,000 metres', 21, 15),
(593, 'Cycling Mens Team Pursuit, 4,000 metres', 33, 15),
(594, 'Cycling Mens Team Pursuit, 4,000 metres', 37, 15),
(595, 'Cycling Womens 500 metres Time Trial', 44, 15),
(596, 'Cycling Womens Mountainbike, Cross-Country', 48, 15),
(597, 'Cycling Womens Road Race, Individual', 33, 15),
(598, 'Cycling Womens Road Race, Individual', 50, 15),
(599, 'Cycling Womens Sprint', 44, 15),
(600, 'Diving Mens Plain High', 5, 16),
(601, 'Diving Mens Plain High', 6, 16),
(602, 'Diving Mens Plain High', 7, 16),
(603, 'Diving Mens Platform', 4, 16),
(604, 'Diving Mens Platform', 5, 16),
(605, 'Diving Mens Platform', 6, 16),
(606, 'Diving Mens Platform', 7, 16),
(607, 'Diving Mens Platform', 13, 16),
(608, 'Diving Mens Platform', 15, 16),
(609, 'Diving Mens Platform', 17, 16),
(610, 'Diving Mens Platform', 25, 16),
(611, 'Diving Mens Platform', 33, 16),
(612, 'Diving Mens Platform', 37, 16),
(613, 'Diving Mens Platform', 40, 16),
(614, 'Diving Mens Platform', 42, 16),
(615, 'Diving Mens Platform', 44, 16),
(616, 'Diving Mens Springboard', 17, 16),
(617, 'Diving Mens Springboard', 33, 16),
(618, 'Diving Womens Plain High', 5, 16),
(619, 'Diving Womens Plain High', 6, 16),
(620, 'Diving Womens Plain High', 7, 16),
(621, 'Diving Womens Platform', 13, 16),
(622, 'Diving Womens Platform', 21, 16),
(623, 'Diving Womens Platform', 35, 16),
(624, 'Diving Womens Platform', 37, 16),
(625, 'Diving Womens Platform', 50, 16),
(626, 'Diving Womens Springboard', 13, 16),
(627, 'Diving Womens Springboard', 21, 16),
(628, 'Diving Womens Springboard', 46, 16),
(629, 'Diving Womens Springboard', 48, 16),
(630, 'Diving Womens Springboard', 50, 16),
(631, 'Diving Womens Synchronized Springboard', 48, 16),
(632, 'Diving Womens Synchronized Springboard', 50, 16),
(633, 'Equestrianism Mens Dressage, Individual', 5, 17),
(634, 'Equestrianism Mens Dressage, Individual', 13, 17),
(635, 'Equestrianism Mens Dressage, Team', 13, 17),
(636, 'Equestrianism Mens Jumping, Individual', 5, 17),
(637, 'Equestrianism Mens Jumping, Individual', 15, 17),
(638, 'Equestrianism Mens Jumping, Team', 15, 17),
(639, 'Equestrianism Mens Three-Day Event, Individual', 5, 17),
(640, 'Equestrianism Mens Three-Day Event, Individual', 17, 17),
(641, 'Equestrianism Mens Three-Day Event, Team', 5, 17),
(642, 'Equestrianism Mens Three-Day Event, Team', 17, 17),
(643, 'Equestrianism Mixed Dressage, Individual', 27, 17),
(644, 'Equestrianism Mixed Dressage, Individual', 50, 17),
(645, 'Equestrianism Mixed Dressage, Team', 27, 17),
(646, 'Equestrianism Mixed Jumping, Individual', 37, 17),
(647, 'Equestrianism Mixed Three-Day Event, Individual', 25, 17),
(648, 'Equestrianism Mixed Three-Day Event, Individual', 27, 17),
(649, 'Equestrianism Mixed Three-Day Event, Individual', 46, 17),
(650, 'Equestrianism Mixed Three-Day Event, Individual', 50, 17),
(651, 'Equestrianism Mixed Three-Day Event, Team', 25, 17),
(652, 'Equestrianism Mixed Three-Day Event, Team', 27, 17),
(653, 'Equestrianism Mixed Three-Day Event, Team', 46, 17),
(654, 'Equestrianism Mixed Three-Day Event, Team', 50, 17),
(655, 'Fencing Mens epee, Individual', 1, 18),
(656, 'Fencing Mens epee, Individual', 4, 18),
(657, 'Fencing Mens epee, Individual', 5, 18),
(658, 'Fencing Mens epee, Individual', 9, 18),
(659, 'Fencing Mens epee, Individual', 13, 18),
(660, 'Fencing Mens epee, Individual', 15, 18),
(661, 'Fencing Mens epee, Individual', 17, 18),
(662, 'Fencing Mens epee, Individual', 19, 18),
(663, 'Fencing Mens epee, Individual', 21, 18),
(664, 'Fencing Mens epee, Individual', 23, 18),
(665, 'Fencing Mens epee, Individual', 27, 18),
(666, 'Fencing Mens epee, Individual', 29, 18),
(667, 'Fencing Mens epee, Individual', 31, 18),
(668, 'Fencing Mens epee, Individual', 33, 18),
(669, 'Fencing Mens epee, Individual', 35, 18),
(670, 'Fencing Mens epee, Individual', 42, 18),
(671, 'Fencing Mens epee, Individual', 44, 18),
(672, 'Fencing Mens epee, Individual', 46, 18),
(673, 'Fencing Mens epee, Team', 5, 18),
(674, 'Fencing Mens epee, Team', 9, 18),
(675, 'Fencing Mens epee, Team', 13, 18),
(676, 'Fencing Mens epee, Team', 15, 18),
(677, 'Fencing Mens epee, Team', 17, 18),
(678, 'Fencing Mens epee, Team', 19, 18),
(679, 'Fencing Mens epee, Team', 21, 18),
(680, 'Fencing Mens epee, Team', 23, 18),
(681, 'Fencing Mens epee, Team', 29, 18),
(682, 'Fencing Mens epee, Team', 31, 18),
(683, 'Fencing Mens epee, Team', 33, 18),
(684, 'Fencing Mens epee, Team', 42, 18),
(685, 'Fencing Mens epee, Team', 44, 18),
(686, 'Fencing Mens Foil, Individual', 5, 18),
(687, 'Fencing Mens Foil, Individual', 9, 18),
(688, 'Fencing Mens Foil, Individual', 13, 18),
(689, 'Fencing Mens Foil, Individual', 15, 18),
(690, 'Fencing Mens Foil, Individual', 21, 18),
(691, 'Fencing Mens Foil, Individual', 23, 18),
(692, 'Fencing Mens Foil, Individual', 25, 18),
(693, 'Fencing Mens Foil, Individual', 37, 18),
(694, 'Fencing Mens Foil, Individual', 48, 18),
(695, 'Fencing Mens Foil, Individual', 50, 18),
(696, 'Fencing Mens Foil, Team', 9, 18),
(697, 'Fencing Mens Foil, Team', 13, 18),
(698, 'Fencing Mens Foil, Team', 15, 18),
(699, 'Fencing Mens Foil, Team', 17, 18),
(700, 'Fencing Mens Foil, Team', 21, 18),
(701, 'Fencing Mens Foil, Team', 23, 18),
(702, 'Fencing Mens Foil, Team', 25, 18),
(703, 'Fencing Mens Foil, Team', 48, 18),
(704, 'Fencing Mens Foil, Team', 50, 18),
(705, 'Fencing Mens Sabre, Individual', 4, 18),
(706, 'Fencing Mens Sabre, Individual', 7, 18),
(707, 'Fencing Mens Sabre, Individual', 13, 18),
(708, 'Fencing Mens Sabre, Individual', 15, 18),
(709, 'Fencing Mens Sabre, Individual', 17, 18),
(710, 'Fencing Mens Sabre, Individual', 48, 18),
(711, 'Fencing Mens Sabre, Individual', 50, 18),
(712, 'Fencing Mens Sabre, Team', 5, 18),
(713, 'Fencing Mens Sabre, Team', 7, 18),
(714, 'Fencing Mens Sabre, Team', 9, 18),
(715, 'Fencing Mens Sabre, Team', 13, 18),
(716, 'Fencing Mens Sabre, Team', 15, 18),
(717, 'Fencing Mens Sabre, Team', 17, 18),
(718, 'Fencing Mens Sabre, Team', 25, 18),
(719, 'Fencing Mens Sabre, Team', 27, 18),
(720, 'Fencing Mens Sabre, Team', 37, 18),
(721, 'Fencing Womens epee, Individual', 48, 18),
(722, 'Fencing Womens Foil, Individual', 7, 18),
(723, 'Fencing Womens Foil, Individual', 9, 18),
(724, 'Fencing Womens Foil, Individual', 11, 18),
(725, 'Fencing Womens Foil, Individual', 13, 18),
(726, 'Fencing Womens Foil, Individual', 15, 18),
(727, 'Fencing Womens Foil, Team', 27, 18),
(728, 'Figure Skating Mens Singles', 24, 19),
(729, 'Figure Skating Mens Singles', 26, 19),
(730, 'Figure Skating Mens Singles', 43, 19),
(731, 'Figure Skating Mens Singles', 47, 19),
(732, 'Figure Skating Mens Singles', 49, 19),
(733, 'Figure Skating Mixed Pairs', 41, 19),
(734, 'Figure Skating Mixed Team', 49, 19),
(735, 'Figure Skating Womens Singles', 16, 19),
(736, 'Figure Skating Womens Singles', 39, 19),
(737, 'Football Mens Football', 3, 20),
(738, 'Football Mens Football', 6, 20),
(739, 'Football Mens Football', 7, 20),
(740, 'Football Mens Football', 9, 20),
(741, 'Football Mens Football', 15, 20),
(742, 'Football Mens Football', 17, 20),
(743, 'Football Mens Football', 21, 20),
(744, 'Football Mens Football', 23, 20),
(745, 'Football Mens Football', 25, 20),
(746, 'Football Mens Football', 27, 20),
(747, 'Football Mens Football', 29, 20),
(748, 'Football Mens Football', 31, 20),
(749, 'Football Mens Football', 33, 20),
(750, 'Football Mens Football', 35, 20),
(751, 'Football Mens Football', 37, 20),
(752, 'Football Mens Football', 40, 20),
(753, 'Football Mens Football', 42, 20),
(754, 'Football Mens Football', 44, 20),
(755, 'Football Mens Football', 46, 20),
(756, 'Football Mens Football', 48, 20),
(757, 'Football Mens Football', 50, 20),
(758, 'Football Womens Football', 40, 20),
(759, 'Football Womens Football', 48, 20),
(760, 'Football Womens Football', 50, 20),
(761, 'Freestyle Skiing Mens Aerials', 43, 21),
(762, 'Freestyle Skiing Mens Aerials', 45, 21),
(763, 'Freestyle Skiing Mens Aerials', 47, 21),
(764, 'Freestyle Skiing Mens Aerials', 49, 21),
(765, 'Freestyle Skiing Mens Moguls', 38, 21),
(766, 'Freestyle Skiing Mens Slopestyle', 49, 21),
(767, 'Freestyle Skiing Womens Halfpipe', 49, 21),
(768, 'Golf Mens Individual', 2, 22),
(769, 'Golf Womens Individual', 1, 22),
(770, 'Gymnastics Mens Floor Exercise', 13, 23),
(771, 'Gymnastics Mens Floor Exercise', 15, 23),
(772, 'Gymnastics Mens Floor Exercise', 17, 23),
(773, 'Gymnastics Mens Floor Exercise', 21, 23),
(774, 'Gymnastics Mens Floor Exercise', 23, 23),
(775, 'Gymnastics Mens Floor Exercise', 25, 23),
(776, 'Gymnastics Mens Floor Exercise', 48, 23),
(777, 'Gymnastics Mens Floor Exercise', 50, 23),
(778, 'Gymnastics Mens Horizontal Bar', 13, 23),
(779, 'Gymnastics Mens Horizontal Bar', 15, 23),
(780, 'Gymnastics Mens Horizontal Bar', 17, 23),
(781, 'Gymnastics Mens Horizontal Bar', 21, 23),
(782, 'Gymnastics Mens Horizontal Bar', 23, 23),
(783, 'Gymnastics Mens Horizontal Bar', 25, 23),
(784, 'Gymnastics Mens Horizontal Bar', 48, 23),
(785, 'Gymnastics Mens Horizontal Bar', 50, 23),
(786, 'Gymnastics Mens Horse Vault', 13, 23),
(787, 'Gymnastics Mens Horse Vault', 15, 23),
(788, 'Gymnastics Mens Horse Vault', 17, 23),
(789, 'Gymnastics Mens Horse Vault', 21, 23),
(790, 'Gymnastics Mens Horse Vault', 23, 23),
(791, 'Gymnastics Mens Horse Vault', 25, 23),
(792, 'Gymnastics Mens Horse Vault', 42, 23),
(793, 'Gymnastics Mens Horse Vault', 48, 23),
(794, 'Gymnastics Mens Horse Vault', 50, 23),
(795, 'Gymnastics Mens Individual All-Around', 1, 23),
(796, 'Gymnastics Mens Individual All-Around', 13, 23),
(797, 'Gymnastics Mens Individual All-Around', 15, 23),
(798, 'Gymnastics Mens Individual All-Around', 17, 23),
(799, 'Gymnastics Mens Individual All-Around', 21, 23),
(800, 'Gymnastics Mens Individual All-Around', 23, 23),
(801, 'Gymnastics Mens Individual All-Around', 25, 23),
(802, 'Gymnastics Mens Individual All-Around', 42, 23),
(803, 'Gymnastics Mens Individual All-Around', 50, 23),
(804, 'Gymnastics Mens Parallel Bars', 13, 23),
(805, 'Gymnastics Mens Parallel Bars', 15, 23),
(806, 'Gymnastics Mens Parallel Bars', 17, 23),
(807, 'Gymnastics Mens Parallel Bars', 21, 23),
(808, 'Gymnastics Mens Parallel Bars', 23, 23),
(809, 'Gymnastics Mens Parallel Bars', 25, 23),
(810, 'Gymnastics Mens Parallel Bars', 42, 23),
(811, 'Gymnastics Mens Parallel Bars', 48, 23),
(812, 'Gymnastics Mens Parallel Bars', 50, 23),
(813, 'Gymnastics Mens Pommelled Horse', 13, 23),
(814, 'Gymnastics Mens Pommelled Horse', 15, 23),
(815, 'Gymnastics Mens Pommelled Horse', 17, 23),
(816, 'Gymnastics Mens Pommelled Horse', 21, 23),
(817, 'Gymnastics Mens Pommelled Horse', 23, 23),
(818, 'Gymnastics Mens Pommelled Horse', 25, 23),
(819, 'Gymnastics Mens Pommelled Horse', 42, 23),
(820, 'Gymnastics Mens Pommelled Horse', 50, 23),
(821, 'Gymnastics Mens Rings', 13, 23),
(822, 'Gymnastics Mens Rings', 15, 23),
(823, 'Gymnastics Mens Rings', 17, 23),
(824, 'Gymnastics Mens Rings', 21, 23),
(825, 'Gymnastics Mens Rings', 23, 23),
(826, 'Gymnastics Mens Rings', 25, 23),
(827, 'Gymnastics Mens Rings', 42, 23),
(828, 'Gymnastics Mens Rings', 48, 23),
(829, 'Gymnastics Mens Rings', 50, 23),
(830, 'Gymnastics Mens Team All-Around', 3, 23),
(831, 'Gymnastics Mens Team All-Around', 4, 23),
(832, 'Gymnastics Mens Team All-Around', 5, 23),
(833, 'Gymnastics Mens Team All-Around', 13, 23),
(834, 'Gymnastics Mens Team All-Around', 15, 23),
(835, 'Gymnastics Mens Team All-Around', 17, 23),
(836, 'Gymnastics Mens Team All-Around', 21, 23),
(837, 'Gymnastics Mens Team All-Around', 23, 23),
(838, 'Gymnastics Mens Team All-Around', 25, 23),
(839, 'Gymnastics Mens Team All-Around', 48, 23),
(840, 'Gymnastics Mens Team All-Around', 50, 23),
(841, 'Gymnastics Mens Team All-Around, Free System', 5, 23),
(842, 'Gymnastics Mens Team All-Around, Free System', 6, 23),
(843, 'Gymnastics Mens Team All-Around, Swedish System', 6, 23),
(844, 'Gymnastics Womens Balance Beam', 17, 23),
(845, 'Gymnastics Womens Balance Beam', 21, 23),
(846, 'Gymnastics Womens Balance Beam', 23, 23),
(847, 'Gymnastics Womens Balance Beam', 27, 23),
(848, 'Gymnastics Womens Balance Beam', 31, 23),
(849, 'Gymnastics Womens Balance Beam', 33, 23),
(850, 'Gymnastics Womens Balance Beam', 46, 23),
(851, 'Gymnastics Womens Balance Beam', 48, 23),
(852, 'Gymnastics Womens Floor Exercise', 17, 23),
(853, 'Gymnastics Womens Floor Exercise', 21, 23),
(854, 'Gymnastics Womens Floor Exercise', 23, 23),
(855, 'Gymnastics Womens Floor Exercise', 27, 23),
(856, 'Gymnastics Womens Floor Exercise', 31, 23),
(857, 'Gymnastics Womens Floor Exercise', 33, 23),
(858, 'Gymnastics Womens Floor Exercise', 46, 23),
(859, 'Gymnastics Womens Floor Exercise', 48, 23),
(860, 'Gymnastics Womens Horse Vault', 17, 23),
(861, 'Gymnastics Womens Horse Vault', 21, 23),
(862, 'Gymnastics Womens Horse Vault', 23, 23),
(863, 'Gymnastics Womens Horse Vault', 27, 23),
(864, 'Gymnastics Womens Horse Vault', 31, 23),
(865, 'Gymnastics Womens Horse Vault', 33, 23),
(866, 'Gymnastics Womens Individual All-Around', 17, 23),
(867, 'Gymnastics Womens Individual All-Around', 21, 23),
(868, 'Gymnastics Womens Individual All-Around', 23, 23),
(869, 'Gymnastics Womens Individual All-Around', 27, 23),
(870, 'Gymnastics Womens Individual All-Around', 31, 23),
(871, 'Gymnastics Womens Individual All-Around', 33, 23),
(872, 'Gymnastics Womens Individual All-Around', 46, 23),
(873, 'Gymnastics Womens Individual All-Around', 48, 23),
(874, 'Gymnastics Womens Team All-Around', 17, 23),
(875, 'Gymnastics Womens Team All-Around', 21, 23),
(876, 'Gymnastics Womens Team All-Around', 23, 23),
(877, 'Gymnastics Womens Team All-Around', 27, 23),
(878, 'Gymnastics Womens Team All-Around', 46, 23),
(879, 'Gymnastics Womens Team All-Around', 48, 23),
(880, 'Gymnastics Womens Team Portable Apparatus', 17, 23),
(881, 'Gymnastics Womens Uneven Bars', 17, 23),
(882, 'Gymnastics Womens Uneven Bars', 21, 23),
(883, 'Gymnastics Womens Uneven Bars', 23, 23),
(884, 'Gymnastics Womens Uneven Bars', 27, 23),
(885, 'Gymnastics Womens Uneven Bars', 31, 23),
(886, 'Gymnastics Womens Uneven Bars', 33, 23),
(887, 'Gymnastics Womens Uneven Bars', 46, 23),
(888, 'Gymnastics Womens Uneven Bars', 48, 23),
(889, 'Handball Mens Handball', 27, 24),
(890, 'Handball Mens Handball', 29, 24),
(891, 'Handball Mens Handball', 31, 24),
(892, 'Handball Mens Handball', 33, 24),
(893, 'Handball Mens Handball', 37, 24),
(894, 'Handball Mens Handball', 40, 24),
(895, 'Handball Mens Handball', 42, 24),
(896, 'Handball Mens Handball', 44, 24),
(897, 'Handball Mens Handball', 46, 24),
(898, 'Handball Mens Handball', 48, 24),
(899, 'Handball Mens Handball', 50, 24),
(900, 'Handball Womens Handball', 31, 24),
(901, 'Handball Womens Handball', 37, 24),
(902, 'Handball Womens Handball', 40, 24),
(903, 'Handball Womens Handball', 46, 24),
(904, 'Handball Womens Handball', 50, 24),
(905, 'Hockey Mens Hockey', 9, 25),
(906, 'Hockey Mens Hockey', 13, 25),
(907, 'Hockey Mens Hockey', 15, 25),
(908, 'Hockey Mens Hockey', 17, 25),
(909, 'Hockey Mens Hockey', 19, 25),
(910, 'Hockey Mens Hockey', 21, 25),
(911, 'Hockey Mens Hockey', 23, 25),
(912, 'Hockey Mens Hockey', 27, 25),
(913, 'Hockey Mens Hockey', 29, 25),
(914, 'Hockey Mens Hockey', 33, 25),
(915, 'Hockey Mens Hockey', 37, 25),
(916, 'Hockey Mens Hockey', 40, 25),
(917, 'Hockey Mens Hockey', 42, 25),
(918, 'Hockey Mens Hockey', 44, 25),
(919, 'Hockey Mens Hockey', 46, 25),
(920, 'Hockey Mens Hockey', 48, 25),
(921, 'Hockey Womens Hockey', 35, 25),
(922, 'Ice Hockey Mens Ice Hockey', 8, 26),
(923, 'Ice Hockey Mens Ice Hockey', 10, 26),
(924, 'Ice Hockey Mens Ice Hockey', 18, 26),
(925, 'Ice Hockey Mens Ice Hockey', 22, 26),
(926, 'Ice Hockey Mens Ice Hockey', 28, 26),
(927, 'Ice Hockey Mens Ice Hockey', 32, 26),
(928, 'Ice Hockey Mens Ice Hockey', 34, 26),
(929, 'Ice Hockey Mens Ice Hockey', 36, 26),
(930, 'Ice Hockey Mens Ice Hockey', 38, 26),
(931, 'Ice Hockey Mens Ice Hockey', 39, 26),
(932, 'Ice Hockey Mens Ice Hockey', 43, 26),
(933, 'Ice Hockey Mens Ice Hockey', 45, 26),
(934, 'Ice Hockey Mens Ice Hockey', 47, 26),
(935, 'Ice Hockey Mens Ice Hockey', 49, 26),
(936, 'Ice Hockey Womens Ice Hockey', 43, 26),
(937, 'Ice Hockey Womens Ice Hockey', 49, 26),
(938, 'Judo Mens Extra-Lightweight', 40, 27),
(939, 'Judo Mens Extra-Lightweight', 44, 27),
(940, 'Judo Mens Extra-Lightweight', 48, 27),
(941, 'Judo Mens Extra-Lightweight', 50, 27),
(942, 'Judo Mens Half-Heavyweight', 27, 27),
(943, 'Judo Mens Half-Heavyweight', 33, 27),
(944, 'Judo Mens Half-Lightweight', 35, 27),
(945, 'Judo Mens Half-Lightweight', 40, 27),
(946, 'Judo Mens Half-Lightweight', 46, 27),
(947, 'Judo Mens Half-Middleweight', 31, 27),
(948, 'Judo Mens Half-Middleweight', 33, 27),
(949, 'Judo Mens Half-Middleweight', 35, 27),
(950, 'Judo Mens Half-Middleweight', 37, 27),
(951, 'Judo Mens Half-Middleweight', 44, 27),
(952, 'Judo Mens Half-Middleweight', 50, 27),
(953, 'Judo Mens Heavyweight', 31, 27),
(954, 'Judo Mens Heavyweight', 50, 27),
(955, 'Judo Mens Lightweight', 31, 27),
(956, 'Judo Mens Lightweight', 40, 27),
(957, 'Judo Mens Lightweight', 48, 27),
(958, 'Judo Mens Middleweight', 27, 27),
(959, 'Judo Mens Middleweight', 29, 27),
(960, 'Judo Mens Open Class', 31, 27),
(961, 'Judo Womens Half-Heavyweight', 46, 27),
(962, 'Judo Womens Half-Lightweight', 50, 27),
(963, 'Judo Womens Half-Middleweight', 46, 27),
(964, 'Judo Womens Half-Middleweight', 48, 27),
(965, 'Luge Womens Singles', 34, 28),
(966, 'Luge Womens Singles', 36, 28),
(967, 'Luge Womens Singles', 38, 28),
(968, 'Luge Womens Singles', 39, 28),
(969, 'Luge Womens Singles', 41, 28),
(970, 'Luge Womens Singles', 43, 28),
(971, 'Modern Pentathlon Mens Individual', 5, 29),
(972, 'Modern Pentathlon Mens Individual', 13, 29),
(973, 'Modern Pentathlon Mens Individual', 23, 29),
(974, 'Modern Pentathlon Mens Individual', 29, 29),
(975, 'Modern Pentathlon Mens Individual', 35, 29),
(976, 'Modern Pentathlon Mens Individual', 37, 29),
(977, 'Modern Pentathlon Mens Individual', 44, 29),
(978, 'Modern Pentathlon Mens Team', 23, 29),
(979, 'Modern Pentathlon Mens Team', 29, 29),
(980, 'Modern Pentathlon Mens Team', 35, 29),
(981, 'Modern Pentathlon Mens Team', 37, 29),
(982, 'Modern Pentathlon Womens Individual', 50, 29),
(983, 'Nordic Combined Mens Individual', 8, 30),
(984, 'Nordic Combined Mens Individual', 30, 30),
(985, 'Nordic Combined Mens Individual', 32, 30),
(986, 'Nordic Combined Mens Individual', 36, 30),
(987, 'Nordic Combined Mens Individual', 38, 30),
(988, 'Nordic Combined Mens Individual', 39, 30),
(989, 'Nordic Combined Mens Individual', 41, 30),
(990, 'Nordic Combined Mens Individual', 43, 30),
(991, 'Nordic Combined Mens Individual', 45, 30),
(992, 'Nordic Combined Mens Sprint', 43, 30),
(993, 'Nordic Combined Mens Sprint', 45, 30),
(994, 'Nordic Combined Mens Team', 36, 30),
(995, 'Nordic Combined Mens Team', 39, 30),
(996, 'Nordic Combined Mens Team', 41, 30),
(997, 'Nordic Combined Mens Team', 43, 30),
(998, 'Nordic Combined Mens Team', 45, 30),
(999, 'Rhythmic Gymnastics Womens Group', 44, 31),
(1000, 'Rhythmic Gymnastics Womens Group', 48, 31),
(1001, 'Rhythmic Gymnastics Womens Individual', 37, 31),
(1002, 'Rhythmic Gymnastics Womens Individual', 40, 31),
(1003, 'Rowing Mens Coxed Eights', 1, 32),
(1004, 'Rowing Mens Coxed Eights', 2, 32),
(1005, 'Rowing Mens Coxed Eights', 13, 32),
(1006, 'Rowing Mens Coxed Eights', 15, 32),
(1007, 'Rowing Mens Coxed Eights', 17, 32),
(1008, 'Rowing Mens Coxed Eights', 21, 32),
(1009, 'Rowing Mens Coxed Eights', 23, 32),
(1010, 'Rowing Mens Coxed Eights', 27, 32),
(1011, 'Rowing Mens Coxed Eights', 33, 32),
(1012, 'Rowing Mens Coxed Eights', 35, 32),
(1013, 'Rowing Mens Coxed Eights', 37, 32),
(1014, 'Rowing Mens Coxed Eights', 40, 32),
(1015, 'Rowing Mens Coxed Eights', 48, 32),
(1016, 'Rowing Mens Coxed Fours', 25, 32),
(1017, 'Rowing Mens Coxed Fours', 29, 32),
(1018, 'Rowing Mens Coxed Fours', 33, 32),
(1019, 'Rowing Mens Coxed Pairs', 13, 32),
(1020, 'Rowing Mens Coxed Pairs', 31, 32),
(1021, 'Rowing Mens Coxed Pairs', 33, 32),
(1022, 'Rowing Mens Coxed Pairs', 35, 32),
(1023, 'Rowing Mens Coxed Pairs', 37, 32),
(1024, 'Rowing Mens Coxless Fours', 21, 32),
(1025, 'Rowing Mens Coxless Fours', 42, 32),
(1026, 'Rowing Mens Coxless Fours', 46, 32),
(1027, 'Rowing Mens Coxless Fours', 50, 32),
(1028, 'Rowing Mens Coxless Pairs', 33, 32),
(1029, 'Rowing Mens Coxless Pairs', 50, 32),
(1030, 'Rowing Mens Double Sculls', 40, 32),
(1031, 'Rowing Mens Double Sculls', 44, 32),
(1032, 'Rowing Mens Lightweight Double Sculls', 40, 32),
(1033, 'Rowing Mens Lightweight Double Sculls', 42, 32),
(1034, 'Rowing Mens Quadruple Sculls', 35, 32),
(1035, 'Rowing Mens Quadruple Sculls', 42, 32),
(1036, 'Rowing Mens Quadruple Sculls', 50, 32),
(1037, 'Rowing Mens Single Sculls', 17, 32),
(1038, 'Rowing Womens Coxed Eights', 29, 32),
(1039, 'Rowing Womens Coxed Eights', 48, 32),
(1040, 'Rowing Womens Coxed Quadruple Sculls', 29, 32),
(1041, 'Rowing Womens Coxed Quadruple Sculls', 31, 32),
(1042, 'Rowing Womens Coxless Pairs', 48, 32),
(1043, 'Rowing Womens Double Sculls', 50, 32),
(1044, 'Rowing Womens Lightweight Double Sculls', 40, 32),
(1045, 'Rowing Womens Lightweight Double Sculls', 50, 32),
(1046, 'Rowing Womens Quadruple Sculls', 50, 32),
(1047, 'Rowing Womens Single Sculls', 48, 32),
(1048, 'Rugby Sevens Mens Rugby Sevens', 50, 33),
(1049, 'Rugby Sevens Womens Rugby Sevens', 50, 33),
(1050, 'Sailing Mens One Person Dinghy', 42, 34),
(1051, 'Sailing Mens One Person Dinghy', 44, 34),
(1052, 'Sailing Mens One Person Dinghy', 48, 34),
(1053, 'Sailing Mens One Person Dinghy', 50, 34),
(1054, 'Sailing Mens Two Person Dinghy', 37, 34),
(1055, 'Sailing Mens Two Person Dinghy', 40, 34),
(1056, 'Sailing Mens Two Person Dinghy', 50, 34),
(1057, 'Sailing Mens Windsurfer', 37, 34),
(1058, 'Sailing Mixed 6 metres', 13, 34),
(1059, 'Sailing Mixed 7 metres', 6, 34),
(1060, 'Sailing Mixed 8 metres', 5, 34),
(1061, 'Sailing Mixed One Person Dinghy', 40, 34),
(1062, 'Sailing Mixed Three Person Keelboat', 25, 34),
(1063, 'Sailing Mixed Three Person Keelboat', 27, 34),
(1064, 'Sailing Mixed Three Person Keelboat', 33, 34),
(1065, 'Sailing Mixed Three Person Keelboat', 35, 34),
(1066, 'Sailing Mixed Three Person Keelboat', 37, 34),
(1067, 'Sailing Mixed Three Person Keelboat', 40, 34),
(1068, 'Sailing Mixed Three Person Keelboat', 42, 34),
(1069, 'Sailing Mixed Two Person Heavyweight Dinghy', 29, 34),
(1070, 'Sailing Mixed Two Person Heavyweight Dinghy', 31, 34),
(1071, 'Sailing Mixed Two Person Heavyweight Dinghy', 33, 34),
(1072, 'Sailing Mixed Two Person Heavyweight Dinghy', 35, 34),
(1073, 'Sailing Mixed Two Person Heavyweight Dinghy', 37, 34),
(1074, 'Sailing Mixed Two Person Keelboat', 23, 34),
(1075, 'Sailing Mixed Two Person Keelboat', 37, 34),
(1076, 'Sailing Womens Three Person Keelboat', 46, 34),
(1077, 'Sailing Womens Two Person Dinghy', 35, 34),
(1078, 'Sailing Womens Two Person Dinghy', 40, 34),
(1079, 'Sailing Womens Windsurfer', 40, 34),
(1080, 'Sailing Womens Windsurfer', 42, 34),
(1081, 'Shooting Mens Air Pistol, 10 metres', 35, 35),
(1082, 'Shooting Mens Air Pistol, 10 metres', 37, 35),
(1083, 'Shooting Mens Air Pistol, 10 metres', 40, 35),
(1084, 'Shooting Mens Air Pistol, 10 metres', 46, 35),
(1085, 'Shooting Mens Air Pistol, 10 metres', 50, 35),
(1086, 'Shooting Mens Air Rifle, 10 metres', 40, 35),
(1087, 'Shooting Mens Air Rifle, 10 metres', 42, 35),
(1088, 'Shooting Mens Air Rifle, 10 metres', 44, 35),
(1089, 'Shooting Mens Air Rifle, 10 metres', 46, 35),
(1090, 'Shooting Mens Free Pistol, 50 metres', 33, 35),
(1091, 'Shooting Mens Free Pistol, 50 metres', 35, 35),
(1092, 'Shooting Mens Free Pistol, 50 metres', 37, 35),
(1093, 'Shooting Mens Free Pistol, 50 metres', 40, 35),
(1094, 'Shooting Mens Free Pistol, 50 metres', 46, 35),
(1095, 'Shooting Mens Free Pistol, 50 metres', 50, 35),
(1096, 'Shooting Mens Free Pistol, 50 metres, Team', 6, 35),
(1097, 'Shooting Mens Free Rifle, 400, 600 and 800 metres, Team', 7, 35),
(1098, 'Shooting Mens Free Rifle, Prone, 600 metres', 7, 35),
(1099, 'Shooting Mens Free Rifle, Three Positions, 300 metres', 5, 35);
INSERT INTO `events` (`id`, `name`, `games_id`, `sport_id`) VALUES
(1100, 'Shooting Mens Free Rifle, Three Positions, 300 metres, Team', 6, 35),
(1101, 'Shooting Mens Military Rifle, 200, 400, 500 and 600 metres, Team', 5, 35),
(1102, 'Shooting Mens Military Rifle, 300 metres and 600 metres, Prone, Team', 6, 35),
(1103, 'Shooting Mens Military Rifle, Any Position, 600 metres', 5, 35),
(1104, 'Shooting Mens Military Rifle, Prone, 300 metres', 6, 35),
(1105, 'Shooting Mens Military Rifle, Prone, 300 metres, Team', 6, 35),
(1106, 'Shooting Mens Military Rifle, Prone, 600 metres, Team', 6, 35),
(1107, 'Shooting Mens Military Rifle, Standing, 300 metres, Team', 6, 35),
(1108, 'Shooting Mens Military Rifle, Three Positions, 300 metres', 5, 35),
(1109, 'Shooting Mens Rapid-Fire Pistol, 25 metres', 13, 35),
(1110, 'Shooting Mens Rapid-Fire Pistol, 25 metres', 15, 35),
(1111, 'Shooting Mens Rapid-Fire Pistol, 25 metres', 33, 35),
(1112, 'Shooting Mens Running Target, 50 metres', 33, 35),
(1113, 'Shooting Mens Running Target, Double Shot', 7, 35),
(1114, 'Shooting Mens Running Target, Single Shot', 7, 35),
(1115, 'Shooting Mens Skeet', 40, 35),
(1116, 'Shooting Mens Skeet', 42, 35),
(1117, 'Shooting Mens Skeet', 50, 35),
(1118, 'Shooting Mens Small-Bore Rifle, Prone, 50 metres', 7, 35),
(1119, 'Shooting Mens Small-Bore Rifle, Prone, 50 metres', 13, 35),
(1120, 'Shooting Mens Small-Bore Rifle, Prone, 50 metres', 15, 35),
(1121, 'Shooting Mens Small-Bore Rifle, Prone, 50 metres', 17, 35),
(1122, 'Shooting Mens Small-Bore Rifle, Prone, 50 metres', 33, 35),
(1123, 'Shooting Mens Small-Bore Rifle, Three Positions, 50 metres', 17, 35),
(1124, 'Shooting Mens Small-Bore Rifle, Three Positions, 50 metres', 33, 35),
(1125, 'Shooting Mens Trap', 1, 35),
(1126, 'Shooting Mens Trap', 17, 35),
(1127, 'Shooting Mens Trap', 19, 35),
(1128, 'Shooting Mens Trap', 21, 35),
(1129, 'Shooting Mixed Skeet', 35, 35),
(1130, 'Shooting Mixed Skeet', 37, 35),
(1131, 'Shooting Mixed Small-Bore Rifle, Prone, 50 metres', 27, 35),
(1132, 'Shooting Mixed Small-Bore Rifle, Prone, 50 metres', 29, 35),
(1133, 'Shooting Mixed Small-Bore Rifle, Three Positions, 50 metres', 29, 35),
(1134, 'Shooting Mixed Trap', 33, 35),
(1135, 'Shooting Womens Air Pistol, 10 metres', 35, 35),
(1136, 'Shooting Womens Air Pistol, 10 metres', 42, 35),
(1137, 'Shooting Womens Air Rifle, 10 metres', 44, 35),
(1138, 'Shooting Womens Air Rifle, 10 metres', 46, 35),
(1139, 'Shooting Womens Air Rifle, 10 metres', 50, 35),
(1140, 'Shooting Womens Sporting Pistol, 25 metres', 33, 35),
(1141, 'Shooting Womens Sporting Pistol, 25 metres', 35, 35),
(1142, 'Shooting Womens Sporting Pistol, 25 metres', 42, 35),
(1143, 'Ski Jumping Mens Normal Hill, Individual', 8, 36),
(1144, 'Ski Jumping Mens Normal Hill, Individual', 12, 36),
(1145, 'Ski Jumping Mens Normal Hill, Individual', 14, 36),
(1146, 'Softball Womens Softball', 46, 37),
(1147, 'Speed Skating Mens 1,000 metres', 36, 38),
(1148, 'Speed Skating Mens 1,000 metres', 38, 38),
(1149, 'Speed Skating Mens 1,000 metres', 39, 38),
(1150, 'Speed Skating Mens 1,000 metres', 41, 38),
(1151, 'Speed Skating Mens 1,000 metres', 43, 38),
(1152, 'Speed Skating Mens 1,500 metres', 18, 38),
(1153, 'Speed Skating Mens 1,500 metres', 20, 38),
(1154, 'Speed Skating Mens 1,500 metres', 22, 38),
(1155, 'Speed Skating Mens 1,500 metres', 24, 38),
(1156, 'Speed Skating Mens 1,500 metres', 36, 38),
(1157, 'Speed Skating Mens 1,500 metres', 38, 38),
(1158, 'Speed Skating Mens 1,500 metres', 39, 38),
(1159, 'Speed Skating Mens 1,500 metres', 41, 38),
(1160, 'Speed Skating Mens 10,000 metres', 22, 38),
(1161, 'Speed Skating Mens 5,000 metres', 20, 38),
(1162, 'Speed Skating Mens 5,000 metres', 22, 38),
(1163, 'Speed Skating Mens 500 metres', 22, 38),
(1164, 'Speed Skating Mens 500 metres', 36, 38),
(1165, 'Speed Skating Mens 500 metres', 38, 38),
(1166, 'Speed Skating Mens 500 metres', 39, 38),
(1167, 'Speed Skating Mens 500 metres', 41, 38),
(1168, 'Speed Skating Mens 500 metres', 43, 38),
(1169, 'Speed Skating Womens 1,000 metres', 36, 38),
(1170, 'Speed Skating Womens 1,000 metres', 38, 38),
(1171, 'Speed Skating Womens 1,000 metres', 39, 38),
(1172, 'Speed Skating Womens 1,000 metres', 45, 38),
(1173, 'Speed Skating Womens 1,500 metres', 39, 38),
(1174, 'Speed Skating Womens 1,500 metres', 45, 38),
(1175, 'Speed Skating Womens 1,500 metres', 47, 38),
(1176, 'Speed Skating Womens 500 metres', 36, 38),
(1177, 'Speed Skating Womens 500 metres', 38, 38),
(1178, 'Speed Skating Womens 500 metres', 39, 38),
(1179, 'Speed Skating Womens Team Pursuit (6 laps)', 45, 38),
(1180, 'Swimming Mens 1,500 metres Freestyle', 50, 39),
(1181, 'Swimming Mens 100 metres Backstroke', 15, 39),
(1182, 'Swimming Mens 100 metres Backstroke', 25, 39),
(1183, 'Swimming Mens 100 metres Backstroke', 29, 39),
(1184, 'Swimming Mens 100 metres Backstroke', 31, 39),
(1185, 'Swimming Mens 100 metres Backstroke', 35, 39),
(1186, 'Swimming Mens 100 metres Backstroke', 40, 39),
(1187, 'Swimming Mens 100 metres Backstroke', 42, 39),
(1188, 'Swimming Mens 100 metres Backstroke', 44, 39),
(1189, 'Swimming Mens 100 metres Backstroke', 50, 39),
(1190, 'Swimming Mens 100 metres Butterfly', 31, 39),
(1191, 'Swimming Mens 100 metres Butterfly', 40, 39),
(1192, 'Swimming Mens 100 metres Butterfly', 42, 39),
(1193, 'Swimming Mens 100 metres Freestyle', 13, 39),
(1194, 'Swimming Mens 100 metres Freestyle', 15, 39),
(1195, 'Swimming Mens 100 metres Freestyle', 17, 39),
(1196, 'Swimming Mens 100 metres Freestyle', 25, 39),
(1197, 'Swimming Mens 100 metres Freestyle', 27, 39),
(1198, 'Swimming Mens 100 metres Freestyle', 31, 39),
(1199, 'Swimming Mens 100 metres Freestyle', 33, 39),
(1200, 'Swimming Mens 100 metres Freestyle', 44, 39),
(1201, 'Swimming Mens 100 metres Freestyle', 46, 39),
(1202, 'Swimming Mens 100 metres Freestyle', 48, 39),
(1203, 'Swimming Mens 100 metres Freestyle', 50, 39),
(1204, 'Swimming Mens 200 metres Backstroke', 25, 39),
(1205, 'Swimming Mens 200 metres Backstroke', 35, 39),
(1206, 'Swimming Mens 200 metres Backstroke', 40, 39),
(1207, 'Swimming Mens 200 metres Breaststroke', 5, 39),
(1208, 'Swimming Mens 200 metres Breaststroke', 6, 39),
(1209, 'Swimming Mens 200 metres Breaststroke', 7, 39),
(1210, 'Swimming Mens 200 metres Breaststroke', 11, 39),
(1211, 'Swimming Mens 200 metres Breaststroke', 13, 39),
(1212, 'Swimming Mens 200 metres Breaststroke', 29, 39),
(1213, 'Swimming Mens 200 metres Butterfly', 29, 39),
(1214, 'Swimming Mens 200 metres Butterfly', 35, 39),
(1215, 'Swimming Mens 200 metres Butterfly', 40, 39),
(1216, 'Swimming Mens 200 metres Butterfly', 42, 39),
(1217, 'Swimming Mens 200 metres Butterfly', 44, 39),
(1218, 'Swimming Mens 200 metres Butterfly', 46, 39),
(1219, 'Swimming Mens 200 metres Freestyle', 1, 39),
(1220, 'Swimming Mens 200 metres Freestyle', 25, 39),
(1221, 'Swimming Mens 200 metres Freestyle', 31, 39),
(1222, 'Swimming Mens 200 metres Freestyle', 37, 39),
(1223, 'Swimming Mens 200 metres Freestyle', 46, 39),
(1224, 'Swimming Mens 200 metres Freestyle', 50, 39),
(1225, 'Swimming Mens 200 metres Individual Medley', 35, 39),
(1226, 'Swimming Mens 200 metres Individual Medley', 37, 39),
(1227, 'Swimming Mens 200 metres Individual Medley', 40, 39),
(1228, 'Swimming Mens 200 metres Individual Medley', 42, 39),
(1229, 'Swimming Mens 220 yard Freestyle', 2, 39),
(1230, 'Swimming Mens 4 x 100 metres Freestyle Relay', 25, 39),
(1231, 'Swimming Mens 4 x 100 metres Freestyle Relay', 27, 39),
(1232, 'Swimming Mens 4 x 100 metres Freestyle Relay', 35, 39),
(1233, 'Swimming Mens 4 x 100 metres Freestyle Relay', 46, 39),
(1234, 'Swimming Mens 4 x 100 metres Freestyle Relay', 48, 39),
(1235, 'Swimming Mens 4 x 100 metres Freestyle Relay', 50, 39),
(1236, 'Swimming Mens 4 x 100 metres Medley Relay', 25, 39),
(1237, 'Swimming Mens 4 x 100 metres Medley Relay', 27, 39),
(1238, 'Swimming Mens 4 x 100 metres Medley Relay', 29, 39),
(1239, 'Swimming Mens 4 x 100 metres Medley Relay', 31, 39),
(1240, 'Swimming Mens 4 x 100 metres Medley Relay', 35, 39),
(1241, 'Swimming Mens 4 x 100 metres Medley Relay', 40, 39),
(1242, 'Swimming Mens 4 x 100 metres Medley Relay', 42, 39),
(1243, 'Swimming Mens 4 x 100 metres Medley Relay', 48, 39),
(1244, 'Swimming Mens 4 x 100 metres Medley Relay', 50, 39),
(1245, 'Swimming Mens 4 x 200 metres Freestyle Relay', 13, 39),
(1246, 'Swimming Mens 4 x 200 metres Freestyle Relay', 25, 39),
(1247, 'Swimming Mens 4 x 200 metres Freestyle Relay', 27, 39),
(1248, 'Swimming Mens 4 x 200 metres Freestyle Relay', 29, 39),
(1249, 'Swimming Mens 4 x 200 metres Freestyle Relay', 31, 39),
(1250, 'Swimming Mens 4 x 200 metres Freestyle Relay', 35, 39),
(1251, 'Swimming Mens 4 x 200 metres Freestyle Relay', 44, 39),
(1252, 'Swimming Mens 4 x 50 Yard Freestyle Relay', 2, 39),
(1253, 'Swimming Mens 400 metres Breaststroke', 5, 39),
(1254, 'Swimming Mens 400 metres Breaststroke', 6, 39),
(1255, 'Swimming Mens 400 metres Freestyle', 17, 39),
(1256, 'Swimming Mens 400 metres Freestyle', 27, 39),
(1257, 'Swimming Mens 400 metres Freestyle', 29, 39),
(1258, 'Swimming Mens 400 metres Freestyle', 31, 39),
(1259, 'Swimming Mens 400 metres Freestyle', 37, 39),
(1260, 'Swimming Mens 400 metres Freestyle', 44, 39),
(1261, 'Swimming Mens 400 metres Freestyle', 50, 39),
(1262, 'Swimming Mens 400 metres Individual Medley', 29, 39),
(1263, 'Swimming Mens 400 metres Individual Medley', 40, 39),
(1264, 'Swimming Mens 400 metres Individual Medley', 42, 39),
(1265, 'Swimming Mens 50 metres Freestyle', 42, 39),
(1266, 'Swimming Mens 50 metres Freestyle', 46, 39),
(1267, 'Swimming Mens 50 metres Freestyle', 48, 39),
(1268, 'Swimming Mens 50 metres Freestyle', 50, 39),
(1269, 'Swimming Mens 880 yard Freestyle', 2, 39),
(1270, 'Swimming Mens One Mile Freestyle', 2, 39),
(1271, 'Swimming Mens Plunge For Distance', 2, 39),
(1272, 'Swimming Womens 100 metres Backstroke', 19, 39),
(1273, 'Swimming Womens 100 metres Backstroke', 33, 39),
(1274, 'Swimming Womens 100 metres Backstroke', 50, 39),
(1275, 'Swimming Womens 100 metres Freestyle', 5, 39),
(1276, 'Swimming Womens 100 metres Freestyle', 13, 39),
(1277, 'Swimming Womens 200 metres Backstroke', 31, 39),
(1278, 'Swimming Womens 200 metres Backstroke', 33, 39),
(1279, 'Swimming Womens 200 metres Backstroke', 42, 39),
(1280, 'Swimming Womens 200 metres Backstroke', 44, 39),
(1281, 'Swimming Womens 200 metres Butterfly', 29, 39),
(1282, 'Swimming Womens 200 metres Butterfly', 48, 39),
(1283, 'Swimming Womens 200 metres Butterfly', 50, 39),
(1284, 'Swimming Womens 200 metres Freestyle', 40, 39),
(1285, 'Swimming Womens 200 metres Individual Medley', 40, 39),
(1286, 'Swimming Womens 200 metres Individual Medley', 42, 39),
(1287, 'Swimming Womens 4 x 100 metres Freestyle Relay', 5, 39),
(1288, 'Swimming Womens 4 x 100 metres Freestyle Relay', 13, 39),
(1289, 'Swimming Womens 4 x 100 metres Freestyle Relay', 19, 39),
(1290, 'Swimming Womens 4 x 100 metres Freestyle Relay', 35, 39),
(1291, 'Swimming Womens 4 x 100 metres Medley Relay', 33, 39),
(1292, 'Swimming Womens 400 metres Freestyle', 40, 39),
(1293, 'Swimming Womens 400 metres Freestyle', 46, 39),
(1294, 'Swimming Womens 400 metres Freestyle', 48, 39),
(1295, 'Swimming Womens 400 metres Individual Medley', 29, 39),
(1296, 'Swimming Womens 400 metres Individual Medley', 40, 39),
(1297, 'Swimming Womens 400 metres Individual Medley', 42, 39),
(1298, 'Swimming Womens 50 metres Freestyle', 35, 39),
(1299, 'Swimming Womens 50 metres Freestyle', 42, 39),
(1300, 'Swimming Womens 50 metres Freestyle', 48, 39),
(1301, 'Swimming Womens 800 metres Freestyle', 46, 39),
(1302, 'Swimming Womens 800 metres Freestyle', 48, 39),
(1303, 'Synchronized Swimming Womens Duet', 37, 40),
(1304, 'Synchronized Swimming Womens Duet', 42, 40),
(1305, 'Synchronized Swimming Womens Duet', 44, 40),
(1306, 'Synchronized Swimming Womens Duet', 46, 40),
(1307, 'Synchronized Swimming Womens Duet', 48, 40),
(1308, 'Synchronized Swimming Womens Duet', 50, 40),
(1309, 'Synchronized Swimming Womens Solo', 37, 40),
(1310, 'Synchronized Swimming Womens Team', 40, 40),
(1311, 'Synchronized Swimming Womens Team', 46, 40),
(1312, 'Synchronized Swimming Womens Team', 48, 40),
(1313, 'Synchronized Swimming Womens Team', 50, 40),
(1314, 'Table Tennis Mens Doubles', 35, 41),
(1315, 'Table Tennis Mens Doubles', 40, 41),
(1316, 'Table Tennis Mens Singles', 44, 41),
(1317, 'Table Tennis Mens Singles', 46, 41),
(1318, 'Table Tennis Mens Singles', 50, 41),
(1319, 'Table Tennis Mens Team', 50, 41),
(1320, 'Table Tennis Womens Doubles', 42, 41),
(1321, 'Table Tennis Womens Singles', 42, 41),
(1322, 'Table Tennis Womens Singles', 46, 41),
(1323, 'Taekwondo Mens Featherweight', 42, 42),
(1324, 'Taekwondo Mens Featherweight', 46, 42),
(1325, 'Taekwondo Mens Featherweight', 48, 42),
(1326, 'Taekwondo Mens Featherweight', 50, 42),
(1327, 'Taekwondo Mens Flyweight', 42, 42),
(1328, 'Taekwondo Mens Welterweight', 42, 42),
(1329, 'Taekwondo Mens Welterweight', 48, 42),
(1330, 'Taekwondo Womens Featherweight', 42, 42),
(1331, 'Taekwondo Womens Featherweight', 44, 42),
(1332, 'Taekwondo Womens Flyweight', 50, 42),
(1333, 'Taekwondo Womens Heavyweight', 46, 42),
(1334, 'Tennis Mens Doubles', 7, 43),
(1335, 'Tennis Mens Doubles', 35, 43),
(1336, 'Tennis Mens Doubles', 42, 43),
(1337, 'Tennis Mens Singles', 7, 43),
(1338, 'Tennis Mens Singles', 35, 43),
(1339, 'Tennis Womens Singles, Covered Courts', 4, 43),
(1340, 'Trampolining Mens Individual', 50, 44),
(1341, 'Trampolining Womens Individual', 50, 44),
(1342, 'Triathlon Womens Olympic Distance', 46, 45),
(1343, 'Triathlon Womens Olympic Distance', 48, 45),
(1344, 'Triathlon Womens Olympic Distance', 50, 45),
(1345, 'Tug-Of-War Mens Tug-Of-War', 1, 46),
(1346, 'Volleyball Mens Volleyball', 27, 47),
(1347, 'Volleyball Mens Volleyball', 29, 47),
(1348, 'Volleyball Mens Volleyball', 33, 47),
(1349, 'Volleyball Mens Volleyball', 42, 47),
(1350, 'Volleyball Mens Volleyball', 44, 47),
(1351, 'Volleyball Mens Volleyball', 46, 47),
(1352, 'Volleyball Mens Volleyball', 50, 47),
(1353, 'Volleyball Womens Volleyball', 23, 47),
(1354, 'Volleyball Womens Volleyball', 46, 47),
(1355, 'Volleyball Womens Volleyball', 48, 47),
(1356, 'Volleyball Womens Volleyball', 50, 47),
(1357, 'Water Polo Mens Water Polo', 5, 48),
(1358, 'Water Polo Mens Water Polo', 9, 48),
(1359, 'Water Polo Mens Water Polo', 13, 48),
(1360, 'Water Polo Mens Water Polo', 15, 48),
(1361, 'Water Polo Mens Water Polo', 17, 48),
(1362, 'Water Polo Mens Water Polo', 21, 48),
(1363, 'Water Polo Mens Water Polo', 23, 48),
(1364, 'Water Polo Mens Water Polo', 29, 48),
(1365, 'Water Polo Mens Water Polo', 33, 48),
(1366, 'Water Polo Mens Water Polo', 40, 48),
(1367, 'Water Polo Mens Water Polo', 42, 48),
(1368, 'Water Polo Mens Water Polo', 44, 48),
(1369, 'Water Polo Mens Water Polo', 46, 48),
(1370, 'Water Polo Mens Water Polo', 48, 48),
(1371, 'Water Polo Mens Water Polo', 50, 48),
(1372, 'Water Polo Womens Water Polo', 48, 48),
(1373, 'Water Polo Womens Water Polo', 50, 48),
(1374, 'Weightlifting Mens Featherweight', 21, 49),
(1375, 'Weightlifting Mens Featherweight', 23, 49),
(1376, 'Weightlifting Mens Featherweight', 35, 49),
(1377, 'Weightlifting Mens Featherweight', 46, 49),
(1378, 'Weightlifting Mens Featherweight', 50, 49),
(1379, 'Weightlifting Mens Flyweight', 29, 49),
(1380, 'Weightlifting Mens Flyweight', 31, 49),
(1381, 'Weightlifting Mens Flyweight', 37, 49),
(1382, 'Weightlifting Mens Flyweight', 40, 49),
(1383, 'Weightlifting Mens Heavyweight', 21, 49),
(1384, 'Weightlifting Mens Heavyweight', 23, 49),
(1385, 'Weightlifting Mens Heavyweight', 50, 49),
(1386, 'Weightlifting Mens Light-Heavyweight', 17, 49),
(1387, 'Weightlifting Mens Light-Heavyweight', 21, 49),
(1388, 'Weightlifting Mens Light-Heavyweight', 23, 49),
(1389, 'Weightlifting Mens Light-Heavyweight', 31, 49),
(1390, 'Weightlifting Mens Light-Heavyweight', 44, 49),
(1391, 'Weightlifting Mens Light-Heavyweight', 48, 49),
(1392, 'Weightlifting Mens Lightweight', 9, 49),
(1393, 'Weightlifting Mens Lightweight', 19, 49),
(1394, 'Weightlifting Mens Lightweight', 23, 49),
(1395, 'Weightlifting Mens Lightweight', 33, 49),
(1396, 'Weightlifting Mens Lightweight', 37, 49),
(1397, 'Weightlifting Mens Lightweight', 46, 49),
(1398, 'Weightlifting Mens Lightweight', 48, 49),
(1399, 'Weightlifting Mens Middle-Heavyweight', 37, 49),
(1400, 'Weightlifting Mens Middle-Heavyweight', 50, 49),
(1401, 'Weightlifting Mens Middleweight', 7, 49),
(1402, 'Weightlifting Mens Middleweight', 13, 49),
(1403, 'Weightlifting Mens Middleweight', 21, 49),
(1404, 'Weightlifting Mens Middleweight', 27, 49),
(1405, 'Weightlifting Mens Middleweight', 44, 49),
(1406, 'Weightlifting Mens Middleweight', 48, 49),
(1407, 'Weightlifting Mens Middleweight', 50, 49),
(1408, 'Weightlifting Womens Featherweight', 42, 49),
(1409, 'Weightlifting Womens Heavyweight', 48, 49),
(1410, 'Weightlifting Womens Light-Heavyweight', 46, 49),
(1411, 'Weightlifting Womens Lightweight', 44, 49),
(1412, 'Weightlifting Womens Middleweight', 46, 49),
(1413, 'Weightlifting Womens Middleweight', 48, 49),
(1414, 'Weightlifting Womens Super-Heavyweight', 50, 49),
(1415, 'Wrestling Mens Bantamweight, Freestyle', 33, 50),
(1416, 'Wrestling Mens Bantamweight, Freestyle', 40, 50),
(1417, 'Wrestling Mens Bantamweight, Freestyle', 42, 50),
(1418, 'Wrestling Mens Bantamweight, Greco-Roman', 42, 50),
(1419, 'Wrestling Mens Featherweight, Freestyle', 4, 50),
(1420, 'Wrestling Mens Featherweight, Freestyle', 6, 50),
(1421, 'Wrestling Mens Featherweight, Freestyle', 15, 50),
(1422, 'Wrestling Mens Featherweight, Freestyle', 27, 50),
(1423, 'Wrestling Mens Featherweight, Freestyle', 31, 50),
(1424, 'Wrestling Mens Featherweight, Freestyle', 37, 50),
(1425, 'Wrestling Mens Featherweight, Freestyle', 42, 50),
(1426, 'Wrestling Mens Featherweight, Freestyle', 44, 50),
(1427, 'Wrestling Mens Featherweight, Greco-Roman', 33, 50),
(1428, 'Wrestling Mens Featherweight, Greco-Roman', 44, 50),
(1429, 'Wrestling Mens Flyweight, Freestyle', 29, 50),
(1430, 'Wrestling Mens Flyweight, Freestyle', 40, 50),
(1431, 'Wrestling Mens Flyweight, Greco-Roman', 15, 50),
(1432, 'Wrestling Mens Flyweight, Greco-Roman', 31, 50),
(1433, 'Wrestling Mens Flyweight, Greco-Roman', 33, 50),
(1434, 'Wrestling Mens Heavyweight, Freestyle', 37, 50),
(1435, 'Wrestling Mens Heavyweight, Freestyle', 40, 50),
(1436, 'Wrestling Mens Heavyweight, Greco-Roman', 48, 50),
(1437, 'Wrestling Mens Light-Flyweight, Freestyle', 35, 50),
(1438, 'Wrestling Mens Light-Flyweight, Freestyle', 37, 50),
(1439, 'Wrestling Mens Light-Heavyweight, Freestyle', 35, 50),
(1440, 'Wrestling Mens Light-Heavyweight, Freestyle', 42, 50),
(1441, 'Wrestling Mens Light-Heavyweight, Freestyle', 46, 50),
(1442, 'Wrestling Mens Light-Heavyweight, Freestyle', 48, 50),
(1443, 'Wrestling Mens Light-Heavyweight, Greco-Roman', 23, 50),
(1444, 'Wrestling Mens Light-Heavyweight, Greco-Roman', 35, 50),
(1445, 'Wrestling Mens Light-Heavyweight, Greco-Roman', 42, 50),
(1446, 'Wrestling Mens Light-Heavyweight, Greco-Roman', 44, 50),
(1447, 'Wrestling Mens Light-Heavyweight, Greco-Roman', 46, 50),
(1448, 'Wrestling Mens Light-Heavyweight, Greco-Roman', 48, 50),
(1449, 'Wrestling Mens Lightweight, Freestyle', 21, 50),
(1450, 'Wrestling Mens Lightweight, Freestyle', 31, 50),
(1451, 'Wrestling Mens Lightweight, Greco-Roman', 35, 50),
(1452, 'Wrestling Mens Lightweight, Greco-Roman', 40, 50),
(1453, 'Wrestling Mens Lightweight, Greco-Roman', 48, 50),
(1454, 'Wrestling Mens Middleweight A, Greco-Roman', 5, 50),
(1455, 'Wrestling Mens Middleweight, Freestyle', 29, 50),
(1456, 'Wrestling Mens Middleweight, Freestyle', 31, 50),
(1457, 'Wrestling Mens Middleweight, Freestyle', 35, 50),
(1458, 'Wrestling Mens Middleweight, Freestyle', 44, 50),
(1459, 'Wrestling Mens Middleweight, Freestyle', 46, 50),
(1460, 'Wrestling Mens Middleweight, Freestyle', 50, 50),
(1461, 'Wrestling Mens Middleweight, Greco-Roman', 31, 50),
(1462, 'Wrestling Mens Middleweight, Greco-Roman', 42, 50),
(1463, 'Wrestling Mens Middleweight, Greco-Roman', 46, 50),
(1464, 'Wrestling Mens Middleweight, Greco-Roman', 50, 50),
(1465, 'Wrestling Mens Super-Heavyweight, Greco-Roman', 46, 50),
(1466, 'Wrestling Mens Super-Heavyweight, Greco-Roman', 48, 50),
(1467, 'Wrestling Mens Super-Heavyweight, Greco-Roman', 50, 50),
(1468, 'Wrestling Mens Welterweight, Freestyle', 23, 50),
(1469, 'Wrestling Mens Welterweight, Freestyle', 27, 50),
(1470, 'Wrestling Mens Welterweight, Greco-Roman', 25, 50),
(1471, 'Wrestling Mens Welterweight, Greco-Roman', 42, 50),
(1472, 'Wrestling Mens Welterweight, Greco-Roman', 46, 50),
(1473, 'Wrestling Mens Welterweight, Greco-Roman', 48, 50),
(1474, 'Wrestling Womens Featherweight, Freestyle', 50, 50),
(1475, 'Wrestling Womens Heavyweight, Freestyle', 50, 50),
(1476, 'Wrestling Womens Light-Heavyweight, Freestyle', 50, 50),
(1477, 'Wrestling Womens Lightweight, Freestyle', 50, 50);

-- Insert Data into Medals table : Done by Zu Hyun Lee
INSERT INTO Medals(id,name)
VALUES
(0, 'Gold'),
(1,'Silver'),
(2,'Bronze');

-- Insert Data into Seasons table : Done by Zu Hyun Lee
INSERT INTO Season(id,name)
VALUES
(0, 'Summer Olympics'),
(1,'Winter Olympics');