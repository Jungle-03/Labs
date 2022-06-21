go
USE UNIVER;
CREATE table FACULTY
(FACULTY      char(10)   constraint  FACULTY_PK primary key,
FACULTY_NAME  varchar(50) default '???'
);
create table PROFESSION
(PROFESSION   char(20) constraint PROFESSION_PK  primary key,
FACULTY    char(10) constraint PROFESSION_FACULTY_FK foreign key references FACULTY(FACULTY),
PROFESSION_NAME varchar(100),    
QUALIFICATION   varchar(50)  
);  
create table  PULPIT 
(PULPIT   char(20)  constraint PULPIT_PK  primary key,
PULPIT_NAME  varchar(100), 
FACULTY   char(10)   constraint PULPIT_FACULTY_FK foreign key 
                         references FACULTY(FACULTY) 
);  
create table TEACHER
(TEACHER    char(10)  constraint TEACHER_PK  primary key,
TEACHER_NAME  varchar(100), 
GENDER     char(1) CHECK (GENDER in ('м', 'ж')),
PULPIT   char(20) constraint TEACHER_PULPIT_FK foreign key 
                         references PULPIT(PULPIT) 
 );
create table SUBJECT
(SUBJECT  char(10) constraint SUBJECT_PK  primary key, 
SUBJECT_NAME varchar(100) unique,
PULPIT  char(20) constraint SUBJECT_PULPIT_FK foreign key references PULPIT(PULPIT)   
)
;
create table AUDITORIUM_TYPE 
(AUDITORIUM_TYPE  char(10) constraint AUDITORIUM_TYPE_PK  primary key,  
AUDITORIUM_TYPENAME  varchar(30)       
);
create table AUDITORIUM 
(AUDITORIUM   char(20)  constraint AUDITORIUM_PK  primary key,              
AUDITORIUM_TYPE char(10) constraint  AUDITORIUM_AUDITORIUM_TYPE_FK foreign key references AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
AUDITORIUM_CAPACITY  integer constraint  AUDITORIUM_CAPACITY_CHECK default 1  check (AUDITORIUM_CAPACITY between 1 and 300),  -- вместимость 
AUDITORIUM_NAME      varchar(50)                                     
);
create table GROUPS
(IDGROUP  int  identity(22,1) constraint GROUP_PK  primary key,              
FACULTY   char(10) constraint  GROUPS_FACULTY_FK foreign key references FACULTY(FACULTY), 
PROFESSION  char(20) constraint  GROUPS_PROFESSION_FK foreign key references PROFESSION(PROFESSION),
YEAR_FIRST  smallint  check (YEAR_FIRST<=YEAR(GETDATE())) 
);
create table STUDENT 
(IDSTUDENT   integer  identity(1000,1) constraint STUDENT_PK  primary key,
IDGROUP   integer  constraint STUDENT_GROUP_FK foreign key  references GROUPS(IDGROUP),
NAME   nvarchar(100), 
BDAY   date,
STAMP  timestamp,
INFO     xml,
FOTO     varbinary
);
create table PROGRESS
(SUBJECT   char(10) constraint PROGRESS_SUBJECT_FK foreign key
                      references SUBJECT(SUBJECT),                
IDSTUDENT integer  constraint PROGRESS_IDSTUDENT_FK foreign key         
                      references STUDENT(IDSTUDENT),        
PDATE    date, 
NOTE     integer check (NOTE between 1 and 10)
);
go
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ТТЛП',    'Технология и техника лесной промышленности');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ТОВ',     'Технология органических веществ');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ХТиТ',   'Химическая технология и техника');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ИЭФ',     'Инженерно-экономический факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ЛХФ',     'Лесохозяйственный факультет');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ИДиП',     'Издательское дело и полиграфия');  
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ИТ',     'Информационных технологий');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('ПиМ',     'Принттехнологий и медиакоммуникаций');
go
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)    values    ('ИДиП',  '1-36 06 01',  'Полиграфическое оборудование и системы обработки информации', 'инженер-электромеханик' );	
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)      values    ('ХТиТ',  '1-36 07 01',  'Машины и аппараты химических производств и предприятий строительных материалов', 'инженер-механик' );
insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('ИТ',  '1-40 01 02',   'Информационные системы и технологии', 'инженер-программист-системотехник' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('ТТЛП',  '1-46 01 01', 'Лесоинженерное дело', 'инженер-технолог	' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)    values    ('ИДиП',  '1-47 01 01', 'Издательское дело', 'редактор-технолог' );     
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)  values    ('ТОВ',  '1-48 01 02',    'Химическая технология органических веществ, материалов и изделий', 'инженер-химик-технолог' );
  insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)  values    ('ТОВ',  '1-48 01 05',    'Химическая технология переработки древесины', 'инженер-химик-технолог' );
   insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)  values    ('ТОВ',  '1-54 01 03',    'Физико-химические методы и приборы контроля качества продукции', 'инженер по сертификации' );
 insert into PROFESSION(FACULTY, PROFESSION, PROFESSION_NAME, QUALIFICATION)  values    ('ЛХФ',  '1-75 01 01',      'Лесное хозяйство', 'инженер лесного хозяйства' );
 insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)   values    ('ЛХФ',  '1-75 02 01',   'Садово-парковое строительство', 'инженер садово-паркового строительства' );
  insert into PROFESSION(FACULTY, PROFESSION,  PROFESSION_NAME, QUALIFICATION)   values    ('ЛХФ',  '1-89 02 02',   'Туризм и природопользование', 'специалист в сфере туризма' );
 go
 insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
    values  ('РИТ', 'Редакционно-издательских тенологий','ИДиП');     
insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
   values  ('СБУАиА', 'Статистики, бухгалтерского учета, анализа и аудита', 'ИЭФ');  
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ТДП','Технологий деревообрабатывающих производств', 'ТТЛП'); 
insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
values  ('ТиДИД','Технологии и дизайна изделий из древесины','ТТЛП');  
insert into PULPIT   (PULPIT,  PULPIT_NAME, FACULTY)
   values  ('ТиП', 'Туризма и природопользования','ЛХФ');
   insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
   values  ('ТЛ', 'Транспорта леса', 'ТТЛП');			
   insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('ТНВиОХТ','Технологии неорганических веществ и общей химической технологии','ХТиТ'); 
  insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('ТНХСиППМ','Технологии нефтехимического синтеза и переработки полимерных материалов','ТОВ'); 
 insert into PULPIT   (PULPIT, PULPIT_NAME, FACULTY)
 values  ('ХПД','Химической переработки древесины','ТОВ');  
  insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
values  ('ХТЭПиМЭЕ',    'Химии, технологии электрохимических производств и материалов электронной техники','ХТиТ');  
 insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
values  ('ЭТиМ',    'Экономической теории и маркетинга','ИЭФ');  
 insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
values  ('ИСиТ',    'Информационные системы и технологии','ИТ');  
 insert into PULPIT   (PULPIT,    PULPIT_NAME, FACULTY)
values  ('ПОиСОИ',    'Полиграфического оборудования и систем обработки информации','ПиМ');  
 insert into PULPIT   (PULPIT, FACULTY)
values  ('ОВ','ПиМ');  





                
               
               


                                                                                                                                                      




  




